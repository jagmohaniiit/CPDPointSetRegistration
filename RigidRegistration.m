function [YResult]=RigidRegistration(X,Y,w)
R=eye(3);
t=zeros(3,1);
s=1;
N=size(X,1);
M=size(Y,1);
D=size(Y,2);

sigma2=0.0;

for n=1:N
    for m=1:M
        term=(X(n,:)-Y(m,:));
        
        sigma2 = sigma2+sum(term.*term);
    end
end
sigma2 = sum(sigma2)/((D*N*M));

iter=1;

errorArray=[];
RArray=[];
sArray=[];
tArray=[];



while iter < 100

    %E-Step
    pmn=computeParamsEStep(X,Y,R,t,s,sigma2,M,N,D,w);
    
    %M-Step
    [R,s,t,sigma2]=computeParamsMStep(pmn,X,Y,M,N,D);
    Ytransformed(:,:)=(s*Y(:,:)*R')+t(:,:)';
    currentError=abs(mean(sum(sum((X(:,:)-Ytransformed(:,:))))));
    
    
    errorArray=[errorArray;currentError];
    RArray=cat(3,RArray,R);
    sArray=[sArray;s];
    tArray=[tArray;t'];
    
    %Y(:,:)=Ytransformed(:,:);
    iter=iter+1;
    Xdisp=["iter is ",iter,"error is",currentError];
    disp(Xdisp);
    
    size(errorArray)
    size(RArray)
    size(sArray)
    size(tArray)
    
end

[minError,minErrorIndex]=min(errorArray);

R=RArray(:,:,minErrorIndex);
s=sArray(minErrorIndex,:);
t=tArray(minErrorIndex,:);
% size(R)
% size(s)
% size(t)


for m=1:M
YResult(m,:)=(s*Y(m,:)*R')+t;
end