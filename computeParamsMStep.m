function [R,s,t,sigma2]=computeParamsMStep(pmn,X,Y,M,N,D)

oneVecM=ones(M,1);
oneVecN=ones(N,1);

Np = (oneVecM'*pmn*oneVecN);
mux = ((1.0/Np)*X'*pmn'*oneVecM);
muy = ((1.0/Np)*Y'*pmn*oneVecN);
muxT = mux';
muyT = muy';

Xmu(:,:) = X(:,:)-muxT(:,1);
Ymu(:,:) = Y(:,:)-muyT(:,1);

size(Xmu)
size(Ymu)
size(pmn)

A = Xmu'*pmn'*Ymu;
P1Vec = pmn*oneVecN;
P1TVec = pmn'*oneVecM;
[U,~,V]=svd(A);
CVec=ones(D,1);
CVec(D,1)=det(U*V);
CMat=diagonalMatrixFromVector(CVec);
P1Mat=diagonalMatrixFromVector(P1Vec);
P1TMat=diagonalMatrixFromVector(P1TVec);
R=U*CMat*V;
s=trace(A'*R)/trace(Ymu'*P1Mat*Ymu);
t=mux-(s*R*muy);
sigma2=(1.0/(Np*D))*(trace(Xmu'*P1TMat*Xmu)-(s*trace(A'*R)));
