%------------------------- kein Kreis ------------------------------------%
%input
R = 447.80152; %J kg^-1 K^-1
T = 273.15; %K
alpha_ = -2.41499e-08; %Pa^-1
L = 1000*[15; 30; 10];%m
D = 1; %m
k = 0.05e-03; %m
b = [-120; 0; 60; 60]; %kg s^-1
p_0 = 9e5; %Pa
eta = 11.9e-06; %kg m^-1 s^-1

dx = 100; %step width in m

%x- and y-coord. for the plot 
x = [0,15,15*(1+sqrt(3)),15+5*sqrt(3)];
y = [0,0,15,-5];

 A = [-1,0,0;
      1,-1,-1;
      0,1,0;
      0,0,1];

%define a sequence of pipes (without circles) through the network that 
%connects the start node with all end nodes
start_weg = [1,2,3];


%------------------no input anymore - do not change-----------------------%
start_knoten = find(b<0);
[s,t,pipes] = get_edges(A,start_knoten);
end_knoten = find(b>0);
[anzahl_knoten,anzahl_kanten] = size(A);
[~,max_wege] =  mode(t); 
example = 0;

save('data',"R","T","alpha_","L","D","k","b","p_0","eta","dx","A","s","t",...
    "start_weg","pipes","start_knoten","end_knoten","anzahl_knoten","anzahl_kanten",...
    "max_wege","x","y","example");
find_q();