function [pmn]=computeParamsEStepNonRigid(w,sigma2,X,Y,M,N,D,W,G)

pmn=zeros(M,N);

denominatorTerm2=power((2.0*pi*sigma2),D/2.0)*(w/(1-w))*(M/N);

for n=1:N
    denominatorTerm1=0;
    for m=1:M
        yscaled=(Y(m,:)+G(m,:)*W);
        term1=sum(X(n,:)-yscaled(:));
        term12=sum(term1.*term1);
        numeratorTerm=(-1.0/(2.0*sigma2))*(term12);
        
        
        
        denominatorTerm1=denominatorTerm1+numeratorTerm;
        
        pmn(m,n)=exp(numeratorTerm);
    end
    
    denominatorTerm=denominatorTerm1+denominatorTerm2;
    pmn(m,n)=pmn(m,n)/denominatorTerm;
end


