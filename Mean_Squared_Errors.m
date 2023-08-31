%%Note: This function is needed to run Code_Sample_2.

function [MSEhat] = MSE(Y,x,h);

N=length(Y);

%Gaussian Kernel
K=normpdf((x-x')/h);
ssr=zeros(N,1);

%Loop empployed to train the data
for i=1:N;

    Ytrain=Y;
    Ktrain=K(:, i);
    Yreal=Ytrain(i,1);

    Ytrain(i,:)=[];
    Ktrain(i,:)=[];
    fhat=sum(Ktrain);

    Yhat= (Ytrain'*Ktrain)/fhat;
    ssr(i)=(Yhat-Yreal)^2;

end;

MSEhat=sum(ssr);