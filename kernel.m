% projections on the  top 15 principal axes + norm of vector

function [train, test] = kernel(train, test)
    train = double(train);
    test = double(test);
    [U,S,V] = svd(train);
    
    rowNorm = rownorm(train);
    train = train * V(:,1:15);
    train = [train, rowNorm];
    
    rowNorm = rownorm(test);
    test = test * V(:,1:15);
    test = [test, rowNorm];
end