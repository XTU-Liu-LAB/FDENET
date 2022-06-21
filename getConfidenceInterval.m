function parameters = getConfidenceInterval()
    global data netsize network;
    [x, y] = find(network == 1);
    idx = [y, x];
    mean = [];
    std = [];
    for i = 1 : netsize
        currentLine = data(i, :);
        if ~isempty(idx)
            indexes = find(idx(:, 2) == i);
            deletionSequence = idx(indexes, 1);
            deletionSequence = [deletionSequence; i];
            deletionSequence = sort(unique(deletionSequence), 'descend');
            length = size(deletionSequence, 1);
            for k = 1 : length  
                currentLine(deletionSequence(k)) = [];
            end
        end
        [muhat,sigmahat,muci,sigmaci] = normfit(currentLine);
        mean(i) = muhat;
        std(i) = sigmahat;
    end
    parameters = [mean; 2 * std];
end