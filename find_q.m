%calculates a solution (q,p) 
load("data.mat");

%calculate a special solution q_sp as starting point
A_tilde = A(:,start_weg);
q_tilde = A_tilde\b; 
q_sp = zeros(size(A,2),1);
q_sp(start_weg) = q_tilde;

%the maximal value in q corresponds to q_sp(1)
max_value = q_sp(1);

diff = @(q) abs(p_diff(q));

%minimize p_diff(q) under the condition Aq = b
m = fmincon(diff,q_sp,[],[],A,b,-max_value*ones(1,anzahl_kanten),...
    max_value*ones(1,anzahl_kanten));

%print the solution (optional)
fprintf("p_diff(q):\n");
disp(diff(m));

fprintf("A*q - b:\n");
disp(A*m-b);

q = m./(pi*(D./2).^2);
fprintf("q:\n");
disp(q);

%calculates the pressure drop along the network for the solution q
[pressure,pressure_end] = calc_p(q);

save("result","m","q","pressure","pressure_end");
%visualize the result
visualisierung();

%auxiliary function to calculate the pressure drop on the whole network
%c: saves the pressure drop along each pipe
%presssure_values: saves the pressure value in each node
function [c,pressure_values] = calc_p(q)

%similar to p_diff.m
load('data.mat');
pressure_values = zeros(max_wege,anzahl_knoten); 
pressure_values(1,start_knoten) = p_0;

c(1,anzahl_knoten) = {0}; 

%calculate pressure on each pipe
for i = 1:length(s)
    start = s(i);
    target = t(i);
    pipe = pipes(i);
    idx = find(pressure_values(:,target)==0);
    p = pressure(pipe,q,pressure_values(1,start),0);
    pressure_values(idx(1),target) = p(end);
    c(1,i) = {p};
end

end
