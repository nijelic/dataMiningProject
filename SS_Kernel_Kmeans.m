% A: input affinity matrix, obj : clustering objective, k: number of clusters,
% W: constraint penalty matrix, tmax : optional maximum number of iterations
%
% if obj == 1, will be "SS ratio association" calculated
% if obj == 2, will be "SS ratio cut" calculated
% if obj == 3, will be "SS normalized cut" calculated
% else basic kMeans

function [PIc] = SS_Kernel_Kmeans(A, obj, k, W, tMax)
  sizeA = size(A, 1);
  sigma = max(max(A));
  
  if obj == 1
    alfa = ones(1, sizeA);
  
  elseif obj == 2
    alfa = ones(1, sizeA);
    D = eye(sizeA);
    for i = 1:sizeA
      D(i,i)=sum(A(i,:));
    end
    A = A - D;
    
  elseif obj == 3
    alfa = ones(1,sizeA);
    for i = 1:sizeA
      alfa(1,i) = sum(A(i, :));
    end

  else
    alfa = ones(1, sizeA);
  end
  
  D = diag(1./alfa);
  K = sigma * D + D * (A + W) * D;
  
  PIc = FarthestFirstInit(A, k, W);
  PIc = kMeans(K, k, tMax, alfa, PIc);