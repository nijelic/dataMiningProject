% K: kernel matrix, k: number of clusters,
% tmax : optional maximum number of iterations, alfa: weight Row-vector, 
% PIc: optional initial clusters as Vector

function [PIc] = kMeans(K, k, tMax, alfa, PIc)
    
    % initialization
    sizeK = size(K, 1);
    distances = zeros(sizeK, k);
    if PIc == 0
      PIc = randi(k, sizeK, 1);
    end
    if alfa == 0
      alfa = ones(1, sizeK);
    end
    
    % algorithm
    for t = 1:tMax
      
      % computing d(Xi, Mc)
      for i = 1:sizeK
        for McI = 1:k
          sumAlfa = sum(alfa(:,PIc==McI));
          if sumAlfa != 0
            first = 2 * sum( alfa(:,PIc==McI).*K(i, PIc==McI))/sumAlfa;
            second = 0;
            for j = 1:sizeK
              for l = 1:sizeK
                if PIc(j,1) == McI && PIc(l,1) == McI
                  second = second + alfa(1,j)*alfa(1,l)*K(j,l);
                end
              end
            end
            second = second/(sumAlfa^2);
          else
            first = 0;
            second = 0;
          end
          distances(i,McI) = K(i,i) - first + second;
        end
      end

      % changing cluster of each Xi, if needed
      converged = 1;
      for i = 1:sizeK
        m = min(distances(i,:));
        for j = 1:k
          if m == distances(i,j)
            if PIc(i,1) != j
              converged = 0;
            end
            PIc(i,1) = j;
            break;
          end
        end
      end
      if converged == 1
        break
      end
      
    end      
end