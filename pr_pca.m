function [ reducedX, coeffs, latents ] = pr_pca( X )
%Returns reduced dimensions of data after pca
   % zm is N * D
   % coeffs is D*D
   zm = X - repmat(mean(X), size(X,1), 1);
   [unordered_coeffs, unordered_latents] =  eig(cov(zm)); 
   [latents, order] = sort(diag(unordered_latents),'descend');
   coeffs = unordered_coeffs;
   for i= 1:length(latents)
      coeffs(:,order(i)) = unordered_coeffs(:,i);
   end
   
    
   reducedX = coeffs' * zm'; %reducedX is D*N now
   reducedX = reducedX(1,:)'; 
end