% A: input affinity matrix, k: number of clusters, W: constraint penalty matrix

function [PIc] = FarthestFirstInit(A, k, W)
  
  sizeA = size(A, 1);
  PIc = randi(k, sizeA, 1);
  M = max(W,W');
  for i = 1:sizeA
    for j = 1:sizeA
      for l = 1:sizeA
        if M(i,l)==1 && M(j,l)==1
          M(i,j) = 1;
          M(j,i) = 1;
        end
      end
    end
  end
  
  C = [];
  class = 1;
  for i = 1:sizeA
    control = 1;
    for j = 1:(i-1)
      if W(i, j)==1
        C = [C, C(1,j)];
        control = 0;
        break;
      end
    end
    if control
      C = [C, class];
      %if class < k
      class = class + 1;
      %end
    end
  end
  
  vecClass = zeros(1,class - 1);
  for i = 1:sizeA
    vecClass(1,C(1,i)) += 1;
  end
  maxC = max(max(C));
  PIc = zeros(1, sizeA);
  for i=1:sizeA
    if C(1,i) == maxC
      PIc(1,i) = 1;
    end
  end
  
  Mc = zeros(1,class -1);
  alfa = ones(1,sizeA);
  for i = 1:(class-1)
    count = 0;
    sumA = 0;
    for j = 1:sizeA
      if(C(1,j)==i)
        sumA += sqrt(A(j, j));
        count += 1;
      end
    end
    Mc(1,i) = sumA/count;
  end
  
  Mc2 = [];
  for i=1:(class-1)
    for j=1:(class-1)
      Mc2 = [Mc2, abs(Mc(1,i)-Mc(i,j))];
    end
  end

  