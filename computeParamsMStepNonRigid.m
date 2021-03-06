function [G,W,sigma2]=computeParamsMStepNonRigid(sigma2,lambda,X,Y,M,N,D,G,P)

oneVecM=ones(M,1);
oneVecN=ones(N,1);

P1Vec = P*oneVecN;
P1TVec = P'*oneVecM;
P1Mat=diagonalMatrixFromVector(P1Vec);
P1MatinvMat=inv(P1Mat);
P1TMat = diagonalMatrixFromVector(P1TVec);


Amat=G+(lambda*sigma2)*(P1MatinvMat);

disp(cond(Amat))
disp(cond(P1Mat))
AmatinvMat=inv(Amat);

bVec=P1MatinvMat*P*X-Y;
W=AmatinvMat*bVec;
Np = (oneVecM'*P1Vec);
T=Y+G*W;
PXT=(P*X)';
TT=T';

sigma2=(trace(X'*P1TMat*X)-2.0*trace(PXT*T)+trace(TT*P1Mat*T))/(Np*D);



