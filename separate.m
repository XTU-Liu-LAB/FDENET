function [AR, passSet] = separate(alpha2, workspace)
    global data GVRIR GVDR;
    
    AR = zeros(0, 3);
    passSet = zeros(0, 2);
    for i = 1 : size(workspace, 1)
        edge = workspace(i, 1:2);
        if ~isempty(GVRIR) && ismember(edge, GVRIR, 'rows')
            continue;
        end
        if ~isempty(GVDR) && ismember(edge, GVDR, 'rows')
            continue;
        end
        regulator = workspace(i, 1);
        target = workspace(i, 2);
        condition = workspace(i, 3);
        
        regLine = data(regulator, :);
        tgtLine = data(target, :);
        condLine = data(condition, :);
        
        regLine(target) = [];
        tgtLine(target) = [];
        condLine(target) = [];
        
        cmiv = cmi(regLine, tgtLine, condLine);
        if cmiv < alpha2
            AR = [AR; regulator, target, condition];
        else
            passSet = [passSet; regulator, target];
        end
    end
end