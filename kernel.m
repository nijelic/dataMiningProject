function [train, test] = kernel(train, test)
    train = double(train);
    test = double(test);
    [S,D,V] = svd(train);
    
    rowNorm = rownorm(train);
    train = train * V(:,1:15);
    train = [train, rowNorm];
    
    rowNorm = rownorm(test);
    test = test * V(:,1:15);
    test = [test, rowNorm];
end