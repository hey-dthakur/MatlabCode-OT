%input
c=[3 5];
A=[1 2; 1 1 ; 0 1];
b=[2000; 1500; 600];

%phase 2 = IneqSign 0 for <=sign and 1 for 0>=sign
IneqSign= [0 0 1];


%Identity matrix
s = eye (size (A,1)); 
ind = find (IneqSign>=0);
s(ind ,:)= -s(ind,:);

% Representing objfn
objfn = array2table(c);
objfn.Properties.VariableNames(1:size (c,2))= {'x1','x2'};

%constraint
mat = [A s b];
constraint = array2table (mat);
constraint.Properties.VariableNames(1:size (mat,2))= {'x1','x2','s1','s2','s3','s4'};
objfn
constraint


