%visualizes the pressur drop (for a length-faithful representation the x 
%and y values must be entered by hand)
close all;
clear;
load('result.mat');
load('data.mat');

%if q is negative: change the direction of the edge and make q positive
s_bild1 = s;
t_bild1 = t;
for i = 1:length(q) 
    if q(i)<0
        tmp = s_bild1(i);
        s_bild1(i) = t(i);
        t_bild1(i) = tmp;
    end
end

weights = abs(q(pipes));
G = digraph(s_bild1,t_bild1,round(weights,2));
LWidths = 15*G.Edges.Weight/max(G.Edges.Weight);

%figure 1: 2d-Plot with q on the edges
figure;
p = plot(G,'LineWidth',LWidths,'EdgeLabel',G.Edges.Weight,...
    'EdgeFontSize', 17,'MarkerSize',13, 'ArrowSize',10,'NodeFontSize',20,'Layout','force');

highlight(p, start_knoten, 'NodeColor', 'g');
highlight(p, end_knoten, 'NodeColor', 'r');
title('|q| in kg m^{-2} s^{-1}'); 
legend('network');
xlabel('$x$[km]','interpreter','latex');
ylabel('$y$[km]','interpreter','latex');
set(gca,'FontSize',15);

%figure 2: 3d-Plot of the pressure drop
figure;
G = graph(s,t,weights);
z = min(pressure_end(1,end_knoten))*ones(1,length(x));
LWidths = 10*G.Edges.Weight/max(G.Edges.Weight);

h = plot(G,'XData',x,'YData',y,'ZData',z,'LineWidth',LWidths,'MarkerSize',10,'NodeFontSize',13);
highlight(h, start_knoten, 'NodeColor', 'g');
highlight(h, end_knoten, 'NodeColor', 'r');
hold on; grid on;
colormap parula;
title('pressure value');
format bank

%plot the pressure drop per pipe
for i = 1:anzahl_kanten
    p_e1 = pressure{i};
    x1 = linspace(h.XData(s(i)),h.XData(t(i)),length(p_e1));
    y1 = linspace(h.YData(s(i)),h.YData(t(i)),length(p_e1));
    pl = scatter3(x1,y1,p_e1,20,p_e1,'filled');
%label the nodes
    if example == 0
        txt = string(round(p_e1(end)/10000));
        text(x(i+1),y(i+1),p_e1(end)+50000,strcat(txt,'\cdot10^5'),'FontSize',16);
        if i==1
            txt = string(round(p_e1(1)/10000));
            text(x(i),y(i),p_e1(1)+50000,strcat(txt,'\cdot10^5'),'FontSize',16);
        end
    elseif example == 1
        if i<4 || i == 5
            txt = string(round(p_e1(end),-3)/100000);
            text(x(i+1),y(i+1),p_e1(end)+20000,strcat(txt,'\cdot10^5'),'FontSize',16);
            if i == 1
                txt = string(round(p_e1(1),-3)/100000);
                text(x(i),y(i),p_e1(i)+20000,strcat(txt,'\cdot10^5'),'FontSize',16);
            end
        elseif i == 6
            txt = string(round(p_e1(end),-3)/100000);
            text(x(i-1),y(i-1),p_e1(end)+20000,strcat(txt,'\cdot10^5'),'FontSize',16);
        end
    elseif example == 2
        if i<4
            txt = string(round(p_e1(end),-3)/100000);
            text(x(i+1),y(i+1),p_e1(end)+3000,strcat(txt,'\cdot10^5'),'FontSize',16);
            if i == 1
                txt = string(round(p_e1(1),-3)/100000);
                text(x(i),y(i),p_e1(i)+3000,strcat(txt,'\cdot10^5'),'FontSize',16);
            end
        elseif i == 5
            txt = string(round(p_e1(end),-3)/100000);
            text(x(i),y(i),p_e1(end)+3000,strcat(txt,'\cdot10^5'),'FontSize',16);
        elseif i == 7
            txt = string(round(p_e1(end),-3)/100000);
            text(x(i-1),y(i-1),p_e1(end)+3000,strcat(txt,'\cdot10^5'),'FontSize',16);
        end 
    end
end

color_matrix = zeros(anzahl_knoten,3);
color_matrix(:,3) = ones(anzahl_knoten,1);
color_matrix(start_knoten,:) = repmat([0 1 0],length(start_knoten),1);
color_matrix(end_knoten,:) = repmat([1 0 0],length(end_knoten),1);

scatter3(h.XData,h.YData,pressure_end(1,:),50,color_matrix,'filled');

xlabel('$x$[km]','interpreter','latex','FontSize',20);
ylabel('$y$[km]','interpreter','latex','FontSize',20);
zlabel('$p$[Pa]','interpreter','latex','FontSize',20);
legend('Graph','pressure','interpreter','latex' );
colorbar;
set(gca,'FontSize',15);