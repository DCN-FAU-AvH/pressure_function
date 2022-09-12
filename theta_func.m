%Calculates Re and theta as described in the thesis
function [theta] = theta_func (q)

load("data.mat");

Re = q.*D/eta;
tmp = -2*log10(1/3.7065 * k./D - 5.0425./Re .* log10(1/2.8257*(k./D).^1.1098 + 5.8506./(Re.^0.8981) ) );
lambda = 1./tmp.^2;
theta = lambda./D;

end

