end_learn = round(0.9*size(DerInputs,1));
names=["in1","in1der1", "in1der2","in2","in2der1","in2der2","in3","in3der1","in3der2","in4","in4der1","in4der2","in5","in5der1","in5der2"];
% inputsTrain=DerInputs(1:end_learn,:);
% inputsTest=DerInputs(end_learn+1:end,:);
% % 
% outputsTrain=DerOutputs(1:end_learn,:);
% outputsTest=DerOutputs(end_learn+1:end,:);

c = cvpartition(length(DerInputs),"Holdout",0.10);
trainingIdx = training(c); % Indices for the training set
testIdx = test(c); % Indices for the test set

inputsTrain=DerInputs(trainingIdx,:);
inputsTest=DerInputs(testIdx,:);

outputsTrain=DerOutputs(trainingIdx,:);
outputsTest=DerOutputs(testIdx,:);

rnn=fitrnet(inputsTrain,outputsTrain,'Standardize',true,'OptimizeHyperparameters','auto','PredictorNames',names);
inputsTrain=DerInputs(1:end_learn,:);
inputsTest=DerInputs(end_learn+1:end,:);
% 
outputsTrain=DerOutputs(1:end_learn,:);
outputsTest=DerOutputs(end_learn+1:end,:);

outputs_learn=predict(rnn,inputsTrain);
outputs_test=predict(rnn,inputsTest);
coefficientT=corrcoef(outputsTest,outputs_test)
coefficientL=corrcoef(outputsTrain,outputs_learn)

figure,plot([outputsTrain outputs_learn])
title('Derivative matrix- Learning')
figure,plot([outputsTest outputs_test])
title('Derivative matrix- Test')

LimeResults=lime(rnn,inputsTrain);
%DerInputs=nameVariables(DerInputs,2);

ind=1;
for r=1:length(DerOutputs)
    if DerOutputs(r,1)>=3 || DerOutputs(r,1)<=-3
        peaks(ind,1)=r;
        ind=ind+1;
    end
end


s=1;
for i=1:length(peaks)
    p=peaks(i,1);
    for j=10:-1:0
    samples(1,s)=p-j;
    s=s+1;
    end
    for k=1:9
        samples(1,s)=p+k;
        s=s+1;
    end
end
samples=sort(samples);
j=1;
for i=1:length(samples)-1
       if samples(1,i)==samples(1,i+1)    
       samp(j,1)=samples(1,i+1);
       i=i+1;
else
           samp(j,1)=samples(1,i+1);
           j=j+1;
       end
end

idx=1;
for i=1:length(samp)
        res(idx,1)=fit(LimeResults,DerInputs(samp(i,1),:),15);
         Lime{idx,1}.Index=samp(i,1);
         [~,I] = sort(abs(res(idx,1).SimpleModel.Beta),'descend');
         Lime{idx,1}.ImportantPredictors=[names(I)' res(idx,1).SimpleModel.Beta(I)];
          clear I
        idx=idx+1;
end
       


        % results = fit(prova,DerInputs(380,:),15);
% [~,I] = sort(abs(results.SimpleModel.Beta),'descend');
% table(results.SimpleModel.ExpandedPredictorNames(I)',results.SimpleModel.Beta(I),'VariableNames',{'Exteded Predictor Name','Coefficient'})
% queryPoint = DerInputs(1,:);
% for i=1:length(RegInputs)
% results = fit(prova,DerInputs(380,:),3);
% end
% prova=lime(rnn,inputsTrain);
% idx=1;
% for i=1:length(Derivative)
% if DerOutputs>=2
%     results = fit(prova,DerInputs(1,:),3);


% check=1;
% for h=1:length(ImportantPredictors)
%     for p=1:length(ImportantPredictors)
%         if ImportantPredictors{p,1}.predictors(:,1)==ImportantPredictors{h,1}.predictors(:,1)
%             equal(check,1)=ImportantPredictors{h,1}.Index;
%         end
%     end
%     check=check+1;
% end
m=1;
for  t=1:length(Lime)
    for  p=1:length(peaks)
    if Lime{t,1}.Index==peaks(p)
        LimeMatrix(:,m)=[Lime{t,1}.Index ; Lime{t,1}.ImportantPredictors(:,1);'peak'];
        break;
    else
        LimeMatrix(:,m)=[Lime{t,1}.Index ; Lime{t,1}.ImportantPredictors(:,1); 0];
    end
    end
    m=m+1;
end

for c=1:size(LimeMatrix,2)
    i=str2num(LimeMatrix(1,c));
    LimeMatrix(18,c)=DerOutputs(i,1);
end

