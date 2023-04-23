


c= [2 3 4 7];
A= [2 3 -1 4; 1 -2 6 -7];
b= [8; -3];

m= size(A,1);
n = size (A,2);
   nv=nchoosek(n,m);
   t=nchoosek(1:n,m);
   sol=[];
   for i = 1:nv
       y=zeros (n,1);
       x= A (:,t(i,:))\b;
      if all (x>0 &x~=inf & x~=-inf)
      y(t(i,:))= x;
       sol=[sol y];
       end
   end
   sol
   z=c*sol;
[zmax zind]=max (z);
BFS = sol(: ,zind);
BFS

optval = [BFS' zind]
optimal_BFS = array2table(optval)
optimal_BFS.Properties.VariableNames(1:size (optimal_BFS,2)) = {'x_1','x_2','x_3','x_4','value_of_z'}

  