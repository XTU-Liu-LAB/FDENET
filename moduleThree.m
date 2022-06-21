% ARS : ambiguous relationship set
% numOfECM: number of experiment in current module
function moduleThree()
    global numOfEXP numOfUFEXP numOfULEXP network downNet;
    [x, y] = find(network == 1);
    idx = [y, x];
    [x, y] = find(downNet == 1);
    downNetIdxs = [y, x];
    % pick out the edges that exist in the downNet but do not exist in the network
    workspace = setdiff(downNetIdxs, idx, 'rows');
    
    %% going into the pluggable block
    ARS = pluggableBlockThree(workspace);
    
    %% back to the basic functional block
    [numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
    numOfEXP = numOfEXP + numOfECM;
    numOfUFEXP = numOfUFEXP + size(LVDR, 1);
    numOfULEXP = numOfULEXP + size(LVRIR, 1);
%     LVRIR = [];
%     LVDR = ARS;
    network = updateAndUpload(network, LVRIR, LVDR);
end