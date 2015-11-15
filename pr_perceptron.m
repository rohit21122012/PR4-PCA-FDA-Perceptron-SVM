function [ weights ] = pr_perceptron( X, Y, learningRate )
% X is N*P and Y is N*1
% weights is N*1    
    numOfExamples = size(X,1);
    numOfFeatures = size(X,2);
    
    %Init the weights 
     weights = rand(numOfFeatures+1,1);
     %X(Y==-1) = -1*X(Y==-1);    
   
%    miscriteria = (weights'*X')
%      miscriteria(Y==-1) = -1*miscriteria(Y==-1)';
%      misclassifiedX = X(miscriteria <= 0,:)
%      Y = Y(miscriteria <= 0,:)
%      misclassifiedX(Y==-1,:) = -1*misclassifiedX(Y==-1,:)
% 
%      deltaWeight = sum(misclassifiedX,1);
%      deltaWeight = learningRate*deltaWeight;
    
    miscs = {};
    X = [ones(numOfExamples,1) X]
    disc = (weights'*X')
    for i=1:numOfExamples
        if(Y(i)*disc(i) < 0)
            miscs{size(miscs,1)+1} = X(i,:);
        end 
         weights = weights + times(Y(i),X(i,:))';
    end
  
    cell2mat(miscs')
    deltaWeight = sum(cell2mat(miscs'),1);
    syms xs ys
    while(isempty(miscs) == 0)
        newWeights = weights  + deltaWeight';
        weights = newWeights;
        
        miscs = {};
        disc = (weights'*X')'
        for i=1:numOfExamples
            display(Y(i)*disc(i))
            if(Y(i)*disc(i) < 0)
                miscs{size(miscs,1)+1} = X(i,:);
            end 
             weights = weights + times(Y(i),X(i,:))';
        end
        
         cell2mat(miscs')
         deltaWeight = sum(cell2mat(miscs'),1);
         
         ezplot(weights' * [1 xs ys]');
         hold on
         a = X(Y==1,:);
         plot(a(:,1), a(:,2),'.b');
         a = X(Y==-1,:);
         plot(a(:,1), a(:,2),'xr');
         
         hold off
         k = waitforbuttonpress;
    end
    
    %Iterate by changing weights
%     while(isempty(misclassifiedX) == 0)
%         
%         newWeights = weights  + deltaWeight';
%         
%         weights = newWeights;
%         
%      miscriteria = (weights'*X')
%      miscriteria(Y==-1) = -1*miscriteria(Y==-1)'
%      misclassifiedX = X(miscriteria <= 0,:)
%      Y = Y(miscriteria <= 0,:)
%      misclassifiedX(Y==-1,:) = -1*misclassifiedX(Y==-1,:)
% 
%      deltaWeight = sum(misclassifiedX,1);
%      deltaWeight = learningRate*deltaWeight;
% 
%     end
end

