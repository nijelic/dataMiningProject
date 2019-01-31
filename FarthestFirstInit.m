% A: input affinity matrix, k: number of clusters, W: constraint penalty matrix
% must-link = 1
% cannot-link = -1

function [PIc] = FarthestFirstInit(A, k, W)
  
  sizeA = size(A, 1);
  PIc = randi(k, sizeA, 1);
 
 % M = transitive closure of must-link
  M = sign(W + W');
  for i = 1:sizeA
    for j = 1:(i-1)
      for l = 1:sizeA
        if M(i,l)==1 && M(l,j)==1
          M(i,j) = 1;
          M(j,i) = 1;
        end
      end
    end
  end
  
  % transitive closure of cannot-link
  sizeAList = [1:sizeA];
  for i = 1:sizeA
    cannotLink = sizeAList(1,M(i,:)==-1);
    mustLink = sizeAList(1,M(i,:)==1);
    for j = cannotLink
      for l = mustLink
        M(j,l) = -1;
        M(l,j) = -1;
      end
    end
  end
  
  % C = connected components
  C = [];
  class = 1;
  for i = 1:sizeA
    control = 1;
    for j = 1:(i-1)
      % if must-link
      if W(i, j)==1
        C = [C, C(1,j)];
        control = 0;
        break;
      end
      % if cannot-link
      if W(i, j) == -1
        control = 0;
        C = [C, class];
        class = class + 1;
        break;
      end
    end
    if control == 1
      C = [C, class];
      %if class < k
      class = class + 1;
      %end
    end
  end
  
  % searching for largest connected component
  vecClass = zeros(1, class - 1);
  for i = 1:sizeA
    vecClass(1, C(1,i)) += 1;
  end
  maxC = max(max(C));
  
  % putting largest connected component into same cluster
  PIc = zeros(sizeA, 1);
  for i=1:sizeA
    if C(1,i) == maxC
      PIc(i,1) = 1;
    end
  end
  
  % Algorithm
  % setting mass centers
  Mc = zeros(1, class - 1);
  for i = 1:(class - 1)
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
  
  % calculating distances between mass centers
  distancesMc = [];
  for i=1:(class-1)
    distancesMc = [distancesMc; abs(Mc-Mc(1,i))];
  end
  
  % 
  used = zeros(1,k);
  used(1,1) = 1;
  ListSizeClass = [1: (class-1)];
  for i=1:(k-1)
    % finding farthest class
    while used(1,i+1)==0
      maxDistance = max(distancesMc(used(1,i),:));
      maxClass = ListSizeClass(1, distancesMc(used(1,i),:)==maxDistance);
      
      control = 1;
      for j=1:i
        if used(i,j)==maxClass(1,1)
          distancesMc(used(1,i),maxClass(1,1))=-1;
          control = 0;
          break;
        end
      end
      if control == 1
        used(1,i+1) = maxClass(1,1);
        for j=1:sizeA
          if C(1,j) == maxClass(1,1)
            PIc(j,1) = i;
          end
        end
      end
    end
  end
  
  % all others are in the last class
  for i = 1:sizeA
    if PIc(i,1)==0
      PIc(i,1)=k;
    end
  end
  