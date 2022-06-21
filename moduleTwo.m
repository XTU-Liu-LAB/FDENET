% ARS : ambiguous relationship set
% numOfECM: number of experiment in current module
% PRIRTCL : potentially redundant indirect relationships in three-node closing
%   loops
function workspaceOfModuleFour = moduleTwo(passSet)
    global numOfEXP numOfUFEXP numOfULEXP network downNet;
    [x, y] = find(network == 1);
    workspace = [y, x];
    
    %% going into the pluggable block
    [ARS, downNetWithoutDelete] = pluggableBlockTwo(workspace, passSet);
    
    %% back to the basic function block
    [numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
    workspaceOfModuleFour = LVRIR;
    numOfEXP = numOfEXP + numOfECM;
    numOfUFEXP = numOfUFEXP + size(LVRIR, 1);
    numOfULEXP = numOfULEXP + size(LVDR, 1);
%     LVRIR = ARS;
%     LVDR = [];
%     workspaceOfModuleFour = LVRIR;
    network = updateAndUpload(network, LVRIR, LVDR);
    downNet = updateAndUpload(downNetWithoutDelete, LVRIR, LVDR);% update the downNet
end