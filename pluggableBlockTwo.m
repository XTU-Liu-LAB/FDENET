function [ARS, downNetWithoutDelete] = pluggableBlockTwo(workspace, passSet)
    global network downNet;
    
    % obtain the downNet
    downNet = buildOrUpdateNet(0.05, network);
    % a copy of the downNet
    downNetWithoutDelete = downNet;
    PRIRTCL = getPRIR(downNet);
    PRIRTCL = separate(0.05, PRIRTCL);
    PRIRTCLIdx = unique(PRIRTCL(:, 1 : 2), 'rows');
    if ~isempty(passSet)
         PRIRTCLIdx = setdiff(PRIRTCLIdx, passSet, 'rows');
    end
    length = size(PRIRTCLIdx, 1);
    for i = 1 : length
        % update the downNet directly without experiment
        downNet(PRIRTCLIdx(i, 2), PRIRTCLIdx(i,1)) = 0;
    end
    [x, y] = find(downNet == 1);
    downNetIdxs = [y, x];
    ARS = [];
    if ~isempty(workspace) && ~isempty(downNetIdxs)
        % pick out the edges that exist in the network but do not exist in the downNet
        ARS = setdiff(workspace, downNetIdxs, 'rows');
    end
end