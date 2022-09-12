%----------------------------- 2 Kreise ----------------------------------%
%input
R = 460.66628; %J kg^-1 K^-1
T = 288.15; %K
alpha_ = -2.51506e-08; %Pa^-1
L = 1000*[20;20;11.3;22;11;17;14];
D = [1.3; 1; 1.3; 1; 1; 1; 1]; %m
k = 0.01e-03; %m
b = [-120;0;0;0;0;120]; %kg s^-1
p_0 = 60e5; %Pa
eta = 11.9e-06; %kg m^-1 s^-1

%x- and y-coord. for the plot 
tmp = sqrt(3)/2;
x = [0,20,35.56,28,35.56+20.92,35.56+20.92+14];
y = [0,0,12.64,-8,3.08,3.08];

dx = 100; %step width in m

A = [-1,0,0,0,0,0,0;
    1,-1,-1,0,0,0,0;
    0,1,0,-1,-1,0,0;
    0,0,1,1,0,-1,0;
    0,0,0,0,1,1,-1;
    0,0,0,0,0,0,1];

%define a sequence of pipes (without circles) through the network that 
%connects the start node with all end nodes
start_weg = [1,2,5,7];

%------------------no input anymore - do not change-----------------------%
start_knoten = find(b<0);
[s,t,pipes] = get_edges(A,start_knoten);
end_knoten = find(b>0);
[anzahl_knoten,anzahl_kanten] = size(A);
[~,max_wege] =  mode(t);
example = 2;

save('data',"R","T","alpha_","L","D","k","b","p_0","eta","dx","A","s","t",...
    "start_weg","pipes","start_knoten","end_knoten","anzahl_knoten","anzahl_kanten",...
    "max_wege","x","y","example");
find_q();