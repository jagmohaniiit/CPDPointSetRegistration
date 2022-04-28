function result=diagonalMatrixFromVector(inputVec)
n=length(inputVec);
result=zeros(n,n);
for ii=1:n
    result(ii,ii)=inputVec(ii);
end