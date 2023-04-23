clc
clear all

C=[1 2];% objective function
a=[-1 1;1 1];%constraint
b=[1 2];
n=size(a,1);
s=eye(size(a,1));%no. of rows or constraint

%simplex table

A=[-1 1 1 0 1;1 1 0 1 2];
cost=zeros(1,size(A,2));
cost(1:n)=C;

bv= n+1:1:size(A,2)-1; %index for bv
zjcj=cost(bv)*A-cost;
zcj=[zjcj; A];

simptable=array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2))={'x_1','x_2','s_1','s_2','sol'};
disp("Initial Simplex Table")
disp(simptable)
fprintf("\nBasic variables : %d %d",bv);
RUN=true;

while RUN

if any(zjcj<0) %check for negative value
    fprintf('\nThe current BFS is not optimal \n')
   zc=zjcj(1:end-1);
   [Enter_val, pvt_col]= min(zc);
   fprintf("\nentering variable: %d",pvt_col);
   if all(A(:,pvt_col)<=0)
    error('LPP is Unbounded');
   else
       sol=A(:,end);
       column=A(:,pvt_col);
       for i=1:size(A,1)
         if column(i)>0
            ratio(i)= sol(i)./column(i);
         else
            ratio(i)=inf;
         end
       end
       [leaving_val, pvt_row]=min(ratio);
       fprintf("\nexiting variable: %d",bv(pvt_row))
   end
bv(pvt_row)=pvt_col;
pvt_key=A(pvt_row, pvt_col);
A(pvt_row,:)=A(pvt_row,:)./pvt_key;
for i=1:size(A,1)
    if i~=pvt_row
        A(i,:)=A(i,:)-A(i, pvt_col).*A(pvt_row,:);
    end
end
    zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:);
    zcj=[zjcj;A];
    fprintf("\n");
    table=array2table(zcj);
    table.Properties.VariableNames(1:size(zcj,2))={'x_1','x_2','s_1','s_2','sol'};
    disp(table)
   fprintf("\nBasic variables : %d %d",bv);
else
    RUN=false;
    fprintf('\nThe current BFS is optimal \n')
    end
end