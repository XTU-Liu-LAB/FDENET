function network = buildOrUpdateNet(alpha1, network)
    global data GVRIR GVDR updateFlag;
    if ~updateFlag  % build a network 
        bc = getBalanceConcentration(data, network);
        diff = data - bc;
        network = abs(diff) >= alpha1;
        % set the main diagonal to 0
        network(logical(eye(size(network)))) = 0;
    else  % update the network
        bc = getBalanceConcentration(data, network);
        diff = data - bc;
        network = abs(diff) >= alpha1;
        network(logical(eye(size(network)))) = 0;
        length = size(GVRIR, 1);
        for i = 1 : length
            network(GVRIR(i, 2), GVRIR(i, 1)) = 0;
        end
        length = size(GVDR, 1);
        for i = 1 : length
            network(GVDR(i, 2), GVDR(i, 1)) = 1;
        end
    end
end