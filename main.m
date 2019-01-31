function [PIc] = main(testX, testY, trainX, trainY)
  for n=[20,40,60,80]
    avrAcc = 0;
    avrTime = 0;
    for t = 1:5
      % data preparation
      [Xtest, Ytest, Xtrain, Ytrain] = selection(testX, testY, trainX, trainY, n);
      [Xtest, Xtrain] = kernel(Xtest, Xtrain);
      K = Xtest * Xtest';
      
      % algorithm
      vrijeme = tic;
      [PIc] = kMeans(K, 3, 10, 0, 0);
      avrTime += toc(vrijeme);
      
      % calculating accuracy
      permutations = perms([3,8,9]);
      sizeK = size(K,1);
      maximum = 0;
      for i = 1:6
        for j=1:sizeK
          PIc2 = permutations(i,PIc(j,1));
        end
        if maximum<sum(PIc2==Ytest)
          maximum = sum(PIc2==Ytest);
        end
      end
      avrAcc+=maximum/sizeK
      sizeK
      toc(vrijeme)
    end
    avrTime = avrTime/5
    avrAcc = avrAcc/5
  end
end