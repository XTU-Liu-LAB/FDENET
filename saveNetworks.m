% GVRIR : global verified redundant indirect relationships
% GVDR : global verified direct relationships
% numOfEXP : number of experiment
% numOfUFEXP : number of useful experiment
% numOfULEXP : number of useless experiment

clear;
clc;

DS = 1;
result = [];
global data downNet netsize network updateFlag %datas in data inputting block
global real
global GVDR GVRIR %global register
global numOfEXP numOfUFEXP numOfULEXP %statistics

while DS == 1
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

    %% result
    fileName = string('RebuildedNetworks\\net-') + DS + string('.mat');
    fileName = char(fileName);
    [x, y] = find(network == 1);
    idx = [y, x];
    % get TP
    FP = setdiff(idx, real, 'rows');
    FP(:,3) = 0;
    TP = intersect(idx, real, 'rows');
    TP(:,3) = 1;
    FN = setdiff(real, idx, 'rows');
    FN(:,3) = 2;
    idx = [TP; FP; FN];
    save(fileName, 'idx');
    
    DS = DS + 1;
end