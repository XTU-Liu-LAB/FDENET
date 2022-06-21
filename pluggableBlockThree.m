function ARS = pluggableBlockThree(workspace)
    global data network;
    [x, y] = find(network == 1);
    idx = [y, x];
    parameters = getConfidenceInterval();
    
    ARS = zeros(0, 2);
    for i = 1 : size(workspace, 1)
        diff = parameters(2, workspace(i, 2));
        if parameters(2, workspace(i, 2)) >= 0.1
            if abs(data(workspace(i, 2), workspace(i, 1)) - parameters(1, workspace(i, 2))) > diff
                if ~ismember(workspace(i, 1), unique(idx(:, 1)))
                    continue;
                end
                ARS = [ARS; workspace(i, 1), workspace(i, 2)];
            end
        else
            if abs(data(workspace(i, 2), workspace(i, 1)) - parameters(1, workspace(i, 2))) > 0.1
                if ~ismember(workspace(i, 1), unique(idx(:, 1)))
                    continue;
                end
                ARS = [ARS; workspace(i, 1), workspace(i, 2)];
            end
        end
    end
end