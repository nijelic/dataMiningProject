% S: input similarity matrix, k: number of clusters, 
% W: constraint penalty matrix, tMax : optional maximum number of iterations

function [PIc]=Kernel_HMRF_kmeans(S, k, W, tMax)
  K = S + W;
  sizeK = size(K, 1);
  alfa = ones(1, sizeK);
  K = K + max(max(K))*eye(sizeK);
  PIc = FarthestFirstInit(K, k, W);
  PIc = kMeans(K, k, tMax, alfa, PIc);
end
