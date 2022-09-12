%F calculates F(p) 
function [ret] = F(p,alpha,q,R,T)

%liegt p im Definitionsbereich?
tmp = p >= abs(q) * sqrt(R*T)*ones(size(p));
tmp2 = p < 1/abs(alpha);
assert(isempty(tmp(tmp<1)),"F(p) can not be calculated since p<|q|*sqrt(R*T).");
assert(isempty(tmp2(tmp2<1)),"F(p) can not be calculated since p>1/|alpha|.");

ret = 1/alpha * p + (q.^2.*R.*T-1/(alpha^2)) .* log(abs(1+alpha*p))- q.^2.*R.*T.*log(p);
end