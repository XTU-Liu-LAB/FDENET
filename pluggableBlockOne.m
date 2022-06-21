function [ARS, passSet] = pluggableBlockOne(workspace, passSet)
    [AR, passSet2] = separate(0.2, workspace);
    ARS = unique(AR(:, 1 : 2), 'rows');% clear duplicates
    passSet = [passSet; passSet2];
    passSet = unique(passSet, 'rows');% clear duplicates
    ARS = setdiff(ARS, passSet, 'rows');
end