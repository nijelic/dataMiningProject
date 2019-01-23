function [V] = rownorm(M)
  sizeM = size(M);
  V = [];
  for i=1:sizeM(1,1)
    V = [V;norm(M(i,:))];
  end
  end
