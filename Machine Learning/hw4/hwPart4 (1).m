function Exp
    load mnist.mat
    rand('seed',1);
    Num = zeros(size(label,1),1);
    for i=1:10
        Num(label(:,i)==1)=i;
    end
    num_labels = 10;
    cv = cvpartition(Num,'KFold',10);
    pairwise = nchoosek(1:num_labels,2);            % 1-vs-1 pairwise models
    svmModel = cell(size(pairwise,1),1);            % Store binary-classifers
    Loops = [0.001, 0.01, 0.1, 1, 10, 100, 1000];
    Accuracy = zeros(7,7);
    for boxC = 1:length(Loops)
        for sigma = 1:length(Loops)
            Err = 0.0;
            for i = 1:cv.NumTestSets
                trainIndex =  cv.training(i);
                testIndex = cv.test(i);
                trainX = data(trainIndex,:);
                testX = data(testIndex,:);
                trainY = Num(trainIndex,:);
                testY = Num(testIndex,:);
                for k=1:numel(svmModel)
                    %# get only training instances belonging to this pair
                    idx = any( bsxfun(@eq, trainY, pairwise(k,:)) , 2 );
                    %# train
                    svmModel{k} = svmtrain(trainX(idx,:),trainY(idx,:),'kernel_function','rbf', 'rbf_sigma', Loops(sigma), 'boxconstraint' , Loops(boxC));
                end
                Predict = predictSVM(svmModel,testX);
                Err = Err + mean(double(Predict == testY)) * 100;
            end
            Accuracy(boxC,sigma) = Err/cv.NumTestSets;
            fprintf('\n CrossValidation Set Accuracy with boxConstraint %f and sigma %f is : %f\n',Loops(boxC), Loops(sigma), Err/cv.NumTestSets);
        end
    end
    Accuracy
end