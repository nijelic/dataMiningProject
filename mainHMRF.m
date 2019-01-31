function [PIc] = mainHMRF(testX, testY, trainX, trainY)
  for n=[20,40,60,80]
    avrAcc = 0;
    avrTime = 0;
    for t = 1:5
      % data preparation
      [Xtest, Ytest, Xtrain, Ytrain] = selection(testX, testY, trainX, trainY, n);
      [Xtest, Xtrain] = kernel(Xtest, Xtrain);
      K = Xtest * Xtest';
      sizeK = size(K,1);
      W = zeros(sizeK, sizeK);
      for i=1:int32(sizeK*sizeK/50)
        j = randi(sizeK,1);
        l = randi(sizeK,1);
        if testY(1,j)==testY(1,l)
          W(j,l) = 1;
          W(l,j) = 1;
        else 
          W(j,l) = -1;
          W(l,j) = -1;
        end
      end  
      % algorithm
      vrijeme = tic;
      [PIc] = Kernel_HMRF_kmeans(K, 3, W, 10);
      avrTime += toc(vrijeme);
      
      % calculating accuracy
      permutations = perms([3,8,9]);
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