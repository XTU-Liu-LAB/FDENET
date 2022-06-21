function bc = getBalanceConcentration(data, network)
    global updateFlag netsize;
    bc = zeros(netsize, netsize);
    if ~updateFlag
        for i = 1 : netsize
            for j = 1 :netsize
                if i ~= j
                    % Obtain the expression value of the target gene to be determined
                    tgtLine = data(j,:);
                    if i > j
                        tgtLine(i)=[];
                        tgtLine(j)=[];
                    else
                        tgtLine(j)=[];
                        tgtLine(i)=[];
                    end
                    [Idx,C,sumD,D] = kmeans(tgtLine',1,'distance', 'cityblock','Replicates',1,'Start','sample');
                    bc(j, i) = C;
                end
            end
        end  
    else
        [x, y] = find(network == 1);
        idx = [y, x];
        for i = 1 : netsize
            for j = 1 :netsize
                if i ~= j
                    % Obtain the expression value of the target gene to be determined
                    tgtLine = data(j,:);
                    indexes = find(idx(:, 2) == j);
                    deletionSequence = idx(indexes, 1);
                    deletionSequence = [deletionSequence; i; j];
                    deletionSequence = sort(unique(deletionSequence), 'descend');
                    length = size(deletionSequence, 1);
                    for k = 1 : length  
                        tgtLine(deletionSequence(k)) = [];
                    end
                    [Idx,C,sumD,D] = kmeans(tgtLine',1,'distance', 'cityblock','Replicates',1,'Start','sample');
                    bc(j, i) = C;
                end
            end
        end  
    end
end