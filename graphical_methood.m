clc;
close all;
%Graphical method to solve LPP
C=[2 3]
A=[1 2;1 1;0 1;1 0;0 1]
B=[200;1500;600;0;0]

x1=0:0.1:max(B);
x21=max(0,(B(1)-A(1,1)*x1)/A(1,2));
x22=max(0,(B(2)-A(2,1)*x1)/A(2,2));
plot(x1,x21,'red',x1,x22,'blue');
xlabel('xvalues');
ylabel('yvalues');
title('graph');
legend('x1+2x2','x1+x2');
sol=[];
for i=1:length(A)
    A1=A(i,:);
    B1=B(i);
    for j=i+1:length(A)
    A2=A(j,:);
    B2=B(j);
    A3=[A1;A2];
    B3=[B1;B2];
    X3=A3\B3;   
    sol =[sol X3];
    end
end

X1=sol(1,:);
X2=sol(2,:);
Y1=find(X1+2*X2>200);
sol(:,Y1)=[];
X1=sol(1,:);
X2=sol(2,:);
Y2=find(X1+X2>1500);
sol(:,Y2)=[];
X1=sol(1,:);
X2=sol(2,:);
Y3=find(X2>600);
sol(:,Y3)=[];
X1=sol(1,:);
X2=sol(2,:);
Y4=find(X1<0);
sol(:,Y4)=[];
X1=sol(1,:);
X2=sol(2,:);
Y5=find(X2<0);
sol(:,Y5)=[];
X1=sol(1,:);
X2=sol(2,:);

sol=sol';

for i=1:length(sol)
    obj(i,:)=sum(sol(i,:).*C);
end
[p,loc]=max(obj);
fprintf("Max value of objective function=");
disp(p);
fprintf("location:");
disp(sol(loc,:));
