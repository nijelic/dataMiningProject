% K: kernel matrix, k: number of clusters,
% tmax : optional maximum number of iterations, α: weight vector, 
% PIc: optional initial clusters

function [PIc] = kMeans(K, k, tMax, alfa, PIc)
    c = -1
    % initialization
    sizeK = size(K, 1);
    distances = zeros(sizeK, k);
    if PIc == 0
      PIc = randi(k, sizeK, 1);
    end
    c=0
    % algorithm
    for t = 1:tMax
      for i = 1:sizeK
        for McI = 1:k
          first = 2 * sum( (alfa(:,PIc==McI)).*K(i, PIc==McI))/sum(alfa(:,PIc==McI));
          second = 0;
          for j = 1:sizeK
            for l = 1:sizeK
              if PIc(j,1) == McI && PIc(l,1) == McI
                second = second + alfa(1,j)*alfa(1,l)*K(j,l);
              end
            end
          end
          second = second/(sum(alfa(:,PIc==McI))^2);
          distances(i,McI) = K(i,i) - first + second;
        end
      end
      c=c+1
      for i = 1:sizeK
        m = min(distances(i,:));
        for j = 1:k
          if m == distances(i,j)
            PIc(i,1) = j;
            break;
          end
        end
        c = c+ 2
      end
      c=c+3
    end      
end