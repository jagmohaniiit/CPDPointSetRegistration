function [YResult]=NonRigidRegistration(X,Y,w,beta,lambda)

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
GArray=[];
WArray=[];


G=zeros(M,M);
firstTerm=-(1.0/(2.0*beta*beta));
for i=1:M
    for j=1:M
        yDiff=abs(Y(i,:)-Y(j,:));
        yDiff2=dot(yDiff,yDiff);
        G(i,j)=exp(firstTerm*yDiff2);
    end
end

W=zeros(M,D);

while iter < 100

    %E-Step
    P=computeParamsEStepNonRigid(w,sigma2,X,Y,M,N,D,W,G);
    
    %M-Step
    [G,W,sigma2]=computeParamsMStepNonRigid(sigma2,lambda,X,Y,M,N,D,G,P);
    Ytransformed=Y+G*W;
    currentError=abs(mean(sum(sum((X(:,:)-Ytransformed(:,:))))));
    
    
    errorArray=[errorArray;currentError];
    GArray=cat(3,GArray,G);
    WArray=cat(3,WArray,W);
    
    
    %Y(:,:)=Ytransformed(:,:);
    iter=iter+1;
    Xdisp=["iter is ",iter,"error is",currentError];
    disp(Xdisp);
    
   
end

[minError,minErrorIndex]=min(errorArray);

W=WArray(:,:,minErrorIndex);
G=GArray(:,:,minErrorIndex);

YResult=Y+G*W;
