%F_inv calculates F^-1 using Newton iteration
%flag = -1: no change in pressure since q = 0
%error: 10^(-5)
%maximal number of iterations = 100
function [y_n1,flag] = F_inv(z,alpha,q,R,T)
flag = 0;
fehler = 10^(-5);
max_iter = 100;

%if q = 0 --> no change in pressure
if abs(q)<0.0001
    y_n1 = -1;
    flag = -1;
    return
end

%check conditions for the Newton iteration
tmp = z > F(abs(q)*sqrt(R*T),alpha,q,R,T);
assert(isempty(tmp(tmp<1)), ...
    "F_inv(z) kann nicht berechnet werden, da z > F(|q|sqrt(R*T)).");

%Newton iteration
phi = @(y) F(y,alpha,q,R,T) - z;

phi_prime = @(p) (p.^2-q.^2.*R.*T)./(p+alpha*p.^2);
y_n = (1/abs(alpha) - 100) *ones(size(z)) ; 

y_n1 = y_n - phi(y_n)./phi_prime(y_n); 

w = 1;
while norm(y_n-y_n1)>fehler && w<max_iter 
   y_n = y_n1;
   y_n1 = y_n - phi(y_n)./phi_prime(y_n); 
   w = w+1;
   if w == max_iter
       fprintf("Die maximale Anzahl an Iterationen (%d) wurde überschritten\n",max_iter);
   end
end
end