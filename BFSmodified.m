% b=[1;2];
% A=[-1 1 1 0;1 1 0 1];
% C=[1 2 0 0];
m=input("No. of constraints:");
n=input("No. of variables(including slack):");
b=input("Rhs matrix:");
A=input("Coefficient matrix(including slack):");
C=input("Cost vector(including slack):");
pair=nchoosek(1:n,m);
BFS=[];
BIFS=[];
flag=true;
for i=1:length(pair)
    y=zeros(length(A),1);
    B=A(:,pair(i,:));
    if det(B)==0
        fprintf("Not a Basic Solution\n")
    else 
        x=B\b;
        if all(x>=0 & x~=-Inf & x~=Inf)
            y(pair(i,:))=x;
            BFS=[BFS y];
            if any(x==0)
                flag=false;
            end
        else
            y(pair(i,:))=x;
            BIFS=[BIFS y];
        end
    end
end
fprintf("Basic Infeasible Solutions:\n");
disp(BIFS);
if ~isempty(BFS)
    fprintf("Basic Feasible Solutions:\n")
    disp(BFS);
    if flag
        fprintf("Non-Degenerate B.F.S.\n");
               
    else
        fprintf("Degenerate B.F.S.\n");
       
    end
    Z=C*BFS;
        [Zmax,Zind] = max(Z);
        BFS = BFS(:,Zind);
        fprintf('Optimal soln \n')
        disp(BFS);
end
