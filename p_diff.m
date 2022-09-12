%calculates the pressure difference in the whole network. When the optimal
%solution is found, this value is equal to zero.
function [diff] = p_diff(m)

load("data.mat");

%q noch durch Fläche teilen!
q_fix = m./(pi*(D./2).^2);

%save pressure values in every node (if more pipes lead to one node, then
%more pressure values are saved. In the end, the difference of those values 
%should be zero)
pressure_values = zeros(max_wege,anzahl_knoten); 
%start pressure
pressure_values(1,start_knoten) = p_0;

%calculate the pressure in every node
for i = 1:length(s)
    start = s(i);
    target = t(i);
    pipe = pipes(i);
    idx = find(pressure_values(:,target)==0);
    pressure_values(idx(1),target) = pressure(pipe,q_fix,pressure_values(1,start),1);
end

%calculate the pressure difference in the network 
diff = 0;
for knoten = 1:anzahl_knoten
    for i = 2:max_wege
       if(pressure_values(i,knoten) > 0)
           diff = diff + norm(pressure_values(1,knoten) - pressure_values(i,knoten))^2;
       else
           continue
       end
    end
end

end