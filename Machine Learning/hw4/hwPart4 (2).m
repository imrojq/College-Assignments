function predict = predictSVM(svmModel,X)
    predTest = zeros(size(X,1),numel(svmModel));
    %size(predTest)
    for k=1:numel(svmModel)
        predTest = svmclassify(svmModel{k}, X);
        %size(A)
        %break;
    end
    predict = mode(predTest,2);
end