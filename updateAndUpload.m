function [network] = updateAndUpload(network, LVRIR, LVDR)
    global GVRIR GVDR
    GVRIR = [GVRIR; LVRIR];
    GVDR = [GVDR; LVDR];
    GVRIR = unique(GVRIR, 'rows');
    GVDR = unique(GVDR, 'rows');
    length = size(LVRIR, 1);
    for i = 1 : length
        network(LVRIR(i, 2), LVRIR(i,1)) = 0;
    end
    length = size(LVDR, 1);
    for i = 1 : length
        network(LVDR(i, 2), LVDR(i,1)) = 1;
    end
end