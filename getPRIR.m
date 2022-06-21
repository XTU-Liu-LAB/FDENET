% PRIR : potentially redundant indirect relations
function PRIR = getPRIR(network)
    [x, y] = find(network == 1);
    idx = [y, x];
    PRIR = zeros(0, 3);
    for i = 1: size(idx, 1)
        edge = idx(i, :);
        currentRegulator = edge(1);
        currentTarget = edge(2);

        % find all targets of the current regulator
        indexes = idx(:,1) == currentRegulator;
        edges = idx(indexes, :);
        targetsOfCurrentRegulator = edges(:, 2);
        % find all targets of the current target
        indexes = idx(:,1) == currentTarget;
        edges = idx(indexes, :);
        targetsOfCurrentTarget = edges(:, 2);
        
        % get the potentially redundant indirect relations
        coTargets = intersect(targetsOfCurrentRegulator, targetsOfCurrentTarget, 'rows');
        if ~isempty(coTargets)
            for j = 1 : size(coTargets)
                PRIR = [PRIR; currentRegulator, coTargets(j), currentTarget];
            end
        end
    end
end