% function returns some of data

function [testX, testNewY, trainX, trainNewY] = selection(testx, testy, trainx, trainy, numOfExamples)
    % dim 400 784
    perm = randperm(size(testx,1));
    testx = testx(perm, :);
    testy = testy(:, perm);
    testx = testx(1:2500, :);
    testy = testy(:, 1:2500);
    
    perm = randperm(size(trainx,1));
    trainx = trainx(perm, :);
    trainy = trainy(:, perm);
    trainx = trainx(1:2500, :);
    trainy = trainy(:, 1:2500);
    
    % test 3, 8, 9
    lenTest = size(testy);
    testNewX = [];
    testNewY = [];
    for i = 1:lenTest(1,2)
        if testy(1,i)==3 || testy(1,i)==8 || testy(1,i)==9
            testNewX = [testNewX, i];
            testNewY = [testNewY, testy(1,i)];
        end
    end
    
    % dim 400 16
    testNewSize = size(testNewX);
    testX = [];
    for j = 1:testNewSize(1,2)
        testX = [testX; testx(testNewX(1,j),:)];
    end
    testX = testX(1:numOfExamples,:);
    testNewY = testNewY(:,1:numOfExamples);
    
    % train 3, 8, 9
    lenTrain = size(trainy);
    trainNewX = [];
    trainNewY = [];
    for i = 1:lenTrain(1,2)
        if trainy(1,i)==3 || trainy(1,i)==8 || trainy(1,i)==9
            trainNewX = [trainNewX, i];
            trainNewY = [trainNewY, trainy(1,i)];
        end
    end
    
    % dim 400 16
    trainNewSize = size(trainNewX);
    trainX = [];
    for j = 1:trainNewSize(1,2)
        trainX = [trainX; trainx(trainNewX(1,j),:)];
    end
    trainX = trainX(1:numOfExamples, :);
    trainNewY = trainNewY(:, 1:numOfExamples);
end