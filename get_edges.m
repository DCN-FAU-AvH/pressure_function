%- Using A to calculate the start (s) and target (t) node for every pipe
%- pipes gives the order in which the network can be solved iteratively

function [s,t,pipes] = get_edges(A,start_knoten)

[n,~] = size(A);
s = [];
t = [];
pipes = [];
list = [start_knoten]; 
check = ones(1,n);

while ~isempty(list)
    zeile = list(1);
    indices = find(A(zeile,:)== -1);
    for i = 1:length(indices)
        s(end+1) = zeile;
        spalte = indices(i); 
        target = find(A(:,spalte)==1);
        t(end+1) = target;
        pipes(end+1) = spalte;
        if(check(target))
            list(end+1) = target;
            check(target) = 0;
        end
    end
    list = list(2:end);
end

end