function ARS = pluggableBlockFour(workspace)
    global GVRIR network data;
    
    %% path rebuilding strategy
    [x, y] = find(network == 1);
    idx = [y, x];
    length = size(workspace, 1);
    ARS = zeros(0, 2);
    for i = 1 : length
        regulator = workspace(i, 1);
        target = workspace(i, 2);
        if ~ismember(regulator, unique(idx(:, 1)))
            continue;
        end
        candidate3 = zeros(0, 2);
        %%%%%%%%%%situation one%%%%%%%%%%%%%
        indexes = find(idx(:, 2) == target);
        medium =  zeros(size(indexes, 1), 1);
        medium(:) = regulator;
        candidate2 = [medium, idx(indexes, 1)];
        if ~isempty(intersect(candidate2, idx, 'rows'))
            continue;
        else
            if ~ isempty(GVRIR)
                candidate2 = setdiff(candidate2, GVRIR, 'rows');
            end
        end
        %%%%%%%%%%process candidate2%%%%%%
        lengthOfCAND2 = size(candidate2, 1);
        for j = 1 : lengthOfCAND2
            regLine = data(candidate2(j, 1), :);
            tgtLine = data(candidate2(j, 2), :);
            indexes = find(idx(:, 2) == candidate2(j, 2));
            deletionSequence = idx(indexes, 1);
            deletionSequence = [deletionSequence; candidate2(j, 2)];
            deletionSequence = sort(unique(deletionSequence), 'descend');
            lengthOfDS = size(deletionSequence, 1);
            for k = 1 : lengthOfDS  
                tgtLine(deletionSequence(k)) = [];
                regLine(deletionSequence(k)) = [];
            end
            MIV = cmi(regLine, tgtLine);
            candidate2(j, 3) = MIV;
        end
        if ~isempty(candidate2)
            candidate2 = sortrows(candidate2, -3);
            candidate3 = [candidate3; candidate2(1, 1 : 2)];
        end
        %%%%%%%%%%situation two%%%%%%%%%%%%%
        indexes = find(idx(:, 1) == regulator);
        medium =  zeros(size(indexes, 1), 1);
        medium(:) = target;
        candidate2 = [idx(indexes, 2), medium];
        if ~isempty(intersect(candidate2, idx, 'rows'))
            continue;
        else
            if ~ isempty(GVRIR)
                candidate2 = setdiff(candidate2, GVRIR, 'rows');
            end
        end
        %%%%%%%%%%process candidate2%%%%%%
        lengthOfCAND2 = size(candidate2, 1);
        for j = 1 : lengthOfCAND2
            if ~ismember(candidate2(j, 1), unique(idx(:, 1)))
                candidate2(j, 3) = 0;
                continue;
            end
            regLine = data(candidate2(j, 1), :);
            tgtLine = data(candidate2(j, 2), :);
            indexes = find(idx(:, 2) == candidate2(j, 2));
            deletionSequence = idx(indexes, 1);
            deletionSequence = [deletionSequence; candidate2(j, 2)];
            deletionSequence = sort(unique(deletionSequence), 'descend');
            lengthOfDS = size(deletionSequence, 1);
            for k = 1 : lengthOfDS  
                tgtLine(deletionSequence(k)) = [];
                regLine(deletionSequence(k)) = [];
            end
            MIV = cmi(regLine, tgtLine);
            candidate2(j, 3) = MIV;
        end
        if ~isempty(candidate2)
            candidate2 = sortrows(candidate2, -3);
            if candidate2(1, 3) > 0
                candidate3 = [candidate3; candidate2(1, 1 : 2)];
            end
        end
        ARS = [ARS; candidate3];
    end
    ARS = unique(ARS, 'rows');
end