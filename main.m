% GVRIR : global verified redundant indirect relationships
% GVDR : global verified direct relationships
% numOfEXP : number of experiment
% numOfUFEXP : number of useful experiment
% numOfULEXP : number of useless experiment

clear;
clc;

DS = 9;
result = [];
global data downNet netsize network updateFlag %datas in data inputting block
global real
global GVDR GVRIR %global register
global numOfEXP numOfUFEXP numOfULEXP %statistics

while DS == 9
    %% initialize variables
    data = getDataSet(DS);
    if DS <= 15
        data(:,1) = [];
    end
    downNet = [];
    GVDR = [];
    GVRIR = [];
    netsize = size(data, 1);
    network = [];
    numOfEXP = 0;
    numOfUFEXP = 0;
    numOfULEXP = 0;
    real = getGoldNet(DS);
    updateFlag = false;    
    passSet = [];
    
    %% PMFGRN
    tic;
    %%%%%%%%%%%%%%%module one%%%%%%%%%%%%%%%%%%
    passSet = moduleOne(passSet);
    %%%%%%%%%%%%%%%module two%%%%%%%%%%%%%%%%%%
    workspaceOfModuleFour = moduleTwo(passSet);
    %%%%%%%%%%%%%%%module three%%%%%%%%%%%%%%%%
    moduleThree();
    %%%%%%%%%%%%%%%module four%%%%%%%%%%%%%%%%%
    moduleFour(workspaceOfModuleFour);
    toc;

    %% statistic results
    [x, y] = find(network == 1);
    idx = [y, x]; 
    FP = size(setdiff(idx, real, 'rows'), 1);
    TP = size(idx, 1) - FP;
    TN = netsize * (netsize - 1) - size(real, 1) - FP;
    FN = size(real, 1) - TP;
    TPR = TP / (TP + FN);
    FPR = FP / (FP + TN);
    TNR = TN / (TN + TP);
    NPV = TN / (TN + FN);
    PPV = TP / (TP + FP);
    FDR = FP / (TP + FP);
    ACC = (TP + TN) / (TP + FP + TN + FN);
    vr = 0;
    if numOfEXP ~= 0
        vr = numOfUFEXP / numOfEXP;
    end
    result = [result; TP, FP, TN, FN, PPV, ACC,...
        numOfEXP, numOfUFEXP, numOfULEXP, vr];
    DS = DS + 1;
end