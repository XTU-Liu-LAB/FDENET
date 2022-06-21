% ARS : ambiguous relationship set
% numOfECM: number of experiment in current module
function [passSet] = moduleOne(passSet)
     global updateFlag numOfEXP numOfUFEXP numOfULEXP network;
     alpha1 = 0.5;
     round = 0; % number of iteration rounds
     while alpha1 > 0.200000000001
        alpha1 = alpha1 - 0.05; % step size
        network = buildOrUpdateNet(alpha1, network);
        updateFlag = true;
        workspace = getPRIR(network);
        
        %% going into the pluggable block
        [ARS, passSet] = pluggableBlockOne(workspace, passSet);
        
        %% back to the basic function block
        [numOfECM, LVRIR, LVDR] = instructExperiment(ARS); % instruct and feedback  
        numOfEXP = numOfEXP + numOfECM;
        numOfUFEXP = numOfUFEXP + size(LVRIR, 1);
        numOfULEXP = numOfULEXP + size(LVDR, 1);
%         LVRIR = ARS;
%         LVDR = [];
        % update the network and upload information according to the feedback
        network = updateAndUpload(network, LVRIR, LVDR);
        round = round + 1;
     end
end