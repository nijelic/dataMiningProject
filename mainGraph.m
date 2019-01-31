function [PIc3] = mainGraph(constraintNum, numberOfExamples)
  if numberOfExamples >250
    numberOfExamples = 250;
  end
  
  [U,G] = surfer('https://www.index.hr',numberOfExamples);
  W = G;
  sizeW = size(W,1);
  randMat = randi(constraintNum, sizeW, sizeW, 1);
  W = (randMat==1).*(G==1)-(randMat==2).*(G==1);
  
  vrijeme = tic
  
  [PIc1] = SS_Kernel_Kmeans(G, 1, int32(numberOfExamples/25) + 1, W, 10);
  t = toc(vrijeme)
  [PIc2] = SS_Kernel_Kmeans(G, 2, int32(numberOfExamples/25) + 1, W, 10);
  t = toc(vrijeme)-t
  [PIc3] = SS_Kernel_Kmeans(G, 3, int32(numberOfExamples/25) + 1, W, 10);
  t = toc(vrijeme)-t
  sum(abs(PIc1-PIc2))
  sum(abs(PIc3-PIc2))
  sum(abs(PIc1-PIc3))
end