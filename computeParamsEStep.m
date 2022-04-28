function [pmn]=computeParamsEStep(X,Y,R,t,s,sigma2,M,N,D,w)

pmn=zeros(M,N);
for m=1:M
    for n=1:N
        yscaled=((s*R*Y(m,:)')+t(:))';
        term1=sum(X(n,:)-yscaled(:));
        term12=sum(term1.*term1);
        numeratorTerm=(-1.0/(2.0*sigma2))*(term12);
        pmn(m,n)=exp(numeratorTerm);
    end
end

sumpmn=sum(sum(pmn));
fixedTerm=power((2.0*pi*sigma2),D/2.0)*(w/(1-w))*(M/N);
denominator=sumpmn+fixedTerm;
for m=1:M
    for n=1:N
        pmn(m,n)=pmn(m,n)/denominator;
        
    end
end

