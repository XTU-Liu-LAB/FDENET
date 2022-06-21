% ARS : ambiguous relationship set
% numOfECM: number of experiment in current module
function moduleFour(workspace)
    global numOfEXP numOfUFEXP numOfULEXP network;
    
    %% going into the pluggable block
    ARS = pluggableBlockFour(workspace);
    
    %% back to the basic function block
    [numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
    numOfEXP = numOfEXP + numOfECM;
    numOfUFEXP = numOfUFEXP + size(LVDR, 1);
    numOfULEXP = numOfULEXP + size(LVRIR, 1);
%     LVRIR = [];
%     LVDR = ARS;
    network = updateAndUpload(network, LVRIR, LVDR);
end