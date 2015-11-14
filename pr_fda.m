function [ reducedX ] = pr_fda( X, Y )
    posX = X(Y==0,:);
    negX = X(Y==1,:);
    scatterPos = cov(posX) * size(posX,1);
    scatterNeg = cov(negX) * size(negX,1);
    withClassScatter = scatterPos + scatterNeg;
    reducedX = withClassScatter\(mean(posX,1) + mean(negX,1))'; 
end

