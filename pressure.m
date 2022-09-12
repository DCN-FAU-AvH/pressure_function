%calculates the pressure drop in one pipe
%enddruck = 0: returns pressure drop along the pipe
%enddruck = 1: returns only the pressure in the target node
function [p_ret] = pressure(pipe,q,p_start,enddruck)

load("data.mat");
theta = theta_func(q);

%check critial length
a = 2*(F(p_start,alpha_,q(pipe),R,T)-F(abs(q(pipe))*sqrt(R*T),alpha_,q(pipe),R,T));
b = (R*T*abs(q(pipe))^2*theta(pipe));
L_critical = a / b;

if abs(theta(pipe))>0
    assert (L(pipe)<L_critical,"Das Rohr ist länger als die kritische Länge L_c aus Corollary 1");
end

%calculate the pressure as described in the thesis
x = 0:dx:L(pipe);
p = zeros(size(x));
p(1) = p_start;

F_p_0 = F(p(1),alpha_,q(pipe),R,T);
arg = F_p_0 - 0.5*R*T*q(pipe)*abs(q(pipe))*abs(theta(pipe))*x(2:end); 
[p(2:end),flag] = F_inv(arg,alpha_,q(pipe),R,T);

%q = 0? 
if flag == -1 
    p(2:end) = p_start*ones(size(p(2:end)));
end

if enddruck
    p_ret = p(end);
else
    p_ret = p;
end


end