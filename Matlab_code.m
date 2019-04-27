clc;clear;close;
n=input('Enter the size of the matrix : ');
A=randi([-100 100],n);
%A=rand(n,n); 
disp("Input Matrix:");
disp(A);
Amax=max(max(A));
A=A/Amax;
A_inv=[];
eta=0.01;
W = -eta * (A'*A);
inverse=inv(A);
tic
for i=1:n
    Ain=A(i,:)';
    vold=zeros(1,length(Ain))';
    vnew = vold + (W*vold) + (eta*Ain);
    vdiff = (W*vold) + (eta*Ain);            %vnew - vold;
    while(1)
        if(sum((abs(vdiff))<=10^(-8))==n)
            break;
        else
            vold = vnew;
            vnew = vold + (W*vold) + (eta*Ain);
            vdiff = (W*vold) + (eta*Ain);       %vnew - vold;
        end
    end
    A_inv=[A_inv vnew];
end    
toc
tic
ytrue=inv(A);
toc
disp("Computed from model:");
disp(A_inv*Amax);
disp("Computed from inbuilt Matlab function inv:");
disp(ytrue*Amax);
disp("Error Matrix");
disp((ytrue*Amax)-(A_inv*Amax));