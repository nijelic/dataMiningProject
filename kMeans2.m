% K: kernel matrix, k: number of clusters,
% tmax : optional maximum number of iterations, α: weight vector, 
% PIc: optional initial clusters
function [] = kMeans(K, k, tMax, alfa, PIc)
       
    % initialization
    t = 0;
    sizeK = size(K, 1);
    distances = zeros(sizeK, k);
    if PIc == 0
      PIc = {};
      for i = 1:k
        PIc(1, end + 1) = [floor(sizeK/k)*(i-1) + 1 : round((sizeK/k)*i)];
      end
     end
     for i = 1:sizeK
       for McI = 1:k
         first = 2 * sum( alfa(:,PIc{1,McI}) * K(i, PIc{1,McI}))/sum(alfa(:,PIc{1,McI}));
         second = 0;
         for j = PIc{1,McI})
           for l = PIc{1,McI})
             second = second + alfa(1,j)*alfa(1,l)*K(j,l)
           end
          end
          second = second/(sum(alfa(:,PIc{1,McI}))^2);
         distances(i,McI) = K(i,i) - first + second;
       
    
end