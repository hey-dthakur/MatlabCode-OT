clc
clear all
m=4; % number of rows sources
n=4; % number of columns destinations
n_b=m+n-1; % number of basic variables
X=-ones(m,n); % initializng variables with negative 1
C=[2 3 4 1; 1 2 2 5; 2 4 3 2;3 6 4 3] % cost matrix
CC=C % copy of original cost matrix
a=[10 20 20 10] % supply
b=[15 15 10 10] % demand
% check balanced
if sum(a)==sum(b)
    for s=1:n_b
        % choosing the minimum cost entry in whole matrix, its different
        % than in a vector, check its working in command window
        [p,q]=min(C) 
        [u,v]=min(p)
        j=v
        i=q(j)
         X(i,j)=min(a(i),b(j)); % allocating at the least cost cell
        a(i)=a(i)-X(i,j); % updating supply
        b(j)=b(j)-X(i,j); % updating demand
        if a(i)==0 && b(j)~=0 % supply exhausted, demand still non zero
            C(i,:)=1000; % crossing out that row by giving high costs to all the entries in that row
        end
        if a(i)~=0 && b(j)==0 % demand exhausted, supply still non zero
            C(:,j)=1000; % crossing out that column by giving high costs to all the entries in that column
        end
        if a(i)==0 && b(j)==0 % if both supply and demand are exhausted, cross either row or column
            C(i,:)=1000;
        end
    end
else 
    disp('unbalanced tp')
    
    if sum(a)<sum(b) % supply is less than demand
        new_row=zeros(1,n);
        %penalty_vector=[4 5 6 2];
        C=[C;new_row];
        diff=sum(b)-sum(a);
        a=[a diff];
        m=m+1;
    else % supply is bigger than demand
        new_column=zeros(m,1);
        %storage_cost=[1 3 4 6];
        C=[C new_column];
        diff=sum(a)-sum(b);
        b=[b diff];
        n=n+1;
    end
    CC=C;
    X=-ones(m,n);
    for s=1:n_b
        [p,q]=min(C)
        [u,v]=min(p)
        j=v
        i=q(j)
        X(i,j)=min(a(i),b(j));
        a(i)=a(i)-X(i,j);
        b(j)=b(j)-X(i,j);
        if a(i)==0 && b(j)~=0
            C(i,:)=1000;
        end
        if a(i)~=0 && b(j)==0
            C(:,j)=1000;
        end
        if a(i)==0 && b(j)==0
            C(i,:)=1000;
        end
    end
end
X
%% compute cost of transportation
for i=1:m
    for j=1:n
        if X(i,j)<0 % the entries which remained negative are non basic variables, so making them zero
            X(i,j)=0;
        end
    end
end
XX=X
z=XX.*CC;
cost_shipping=sum(sum(z))