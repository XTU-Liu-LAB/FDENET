% ARS : ambiguous relationship set
% numOfECM: number of experiment in current module
function [numOfECM, LVRIR, LVDR] = instructExperiment(ARS)
    global GVRIR GVDR real
    if ~isempty(GVRIR)
        ARS = setdiff(ARS, GVRIR, 'rows');
    end
    if ~isempty(GVDR)
        ARS = setdiff(ARS, GVDR, 'rows');
    end
    LVRIR = setdiff(ARS, real, 'rows');
    LVDR = intersect(ARS, real, 'rows');
    numOfECM = size(ARS, 1);
end