% code2
% my solution is column wise
% format short
clc
% input 1: input parameter
c=[1 2 0 0];
A=[-1 1 1 0 ; 1 1 0 1];
b=[1;2];
% phase2: no of constraint & variable
m=size(A,1);           % no of constraint 
n=size(A,2);            % no of variable


% phase 3: compute the ncm bfs
nv=nchoosek(n,m);
t=nchoosek(1:n,m);
sol=[];
for i=1:nv
    y=zeros(n,1);
  
    x=A(:,t(i,:))\b;
      if all(x>=0&x~=inf&x~=-inf)
    y(t(i,:))=x;
    sol=[sol y];
      end
end

sol

   z =c*sol;
    [Zmax,Zind]=max(z);
    BFS=sol(:,Zind);
    BFS