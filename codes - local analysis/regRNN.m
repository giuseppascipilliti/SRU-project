% end_learn = round(0.8*size(RegInputs,1));
% names=["in1(k-1)","in1(k-3)","in1(k-5)","in1(k-7)","in1(k-9)","in2(k-1)","in2(k-3)","in2(k-5)","in2(k-7)","in2(k-9)","in3(k-1)","in3(k-3)","in3(k-5)","in3(k-7)","in3(k-9)","in4(k-1)","in4(k-3)","in4(k-5)","in4(k-7)","in4(k-9)","in5(k-1)","in5(k-3)","in5(k-5)","in5(k-7)","in5(k-9)"];
% 
% c = cvpartition(length(RegInputs),"Holdout",0.20);
% trainingIdx = training(c); % Indices for the training set
% testIdx = test(c); % Indices for the test set
% 
% inputsTrain=RegInputs(trainingIdx,:);
% inputsTest=RegInputs(testIdx,:);
% 
% outputsTrain=RegOutputs(trainingIdx,:);
% outputsTest=RegOutputs(testIdx,:);
% 
% rnn=fitrnet(inputsTrain,outputsTrain,'Standardize',true,'OptimizeHyperparameters','auto','PredictorNames',names);
% inputsTrain=RegInputs(1:end_learn,:);
% inputsTest=RegInputs(end_learn+1:end,:);
% % 
% outputsTrain=RegOutputs(1:end_learn,:);
% outputsTest=RegOutputs(end_learn+1:end,:);
% 
% outputs_learn=predict(rnn,inputsTrain);
% outputs_test=predict(rnn,inputsTest);
% coefficientT=rms(outputsTest-outputs_test)
% coefficientL=rms(outputsTrain-outputs_learn)
% 
% figure,plot([outputsTrain outputs_learn])
% % title('Regressors matrix- Learning')
% figure,plot([outputsTest outputs_test])
% title('Regressors matrix- Test')
% LimeResults=lime(rnn,inputsTrain);
% LimeResults=lime(rnn,RegInputs(samp,:));
% LimeResults=lime(rnn,RegInputs);

% ind=1;
% for r=1:length(RegOutputs)
% %     if RegOutputs(r,1)>=3 || RegOutputs(r,1)<=-3
%     if RegOutputs(r,1)>=0.65
%         peaks(ind,1)=r;
%         ind=ind+1;
%     end
% end
% 
% 
% s=1;
% for i=1:length(peaks)
%     p=peaks(i,1);
%     for j=10:-1:0
%     samples(1,s)=p-j;
%     s=s+1;
%     end
%     for k=1:9
%         samples(1,s)=p+k;
%         s=s+1;
%     end
% end
% samples=sort(samples);
% j=1;
% for i=1:length(samples)-1
%        if samples(1,i)==samples(1,i+1)    
%        samp(j,1)=samples(1,i+1);
%        i=i+1;
% else
%            samp(j,1)=samples(1,i+1);
%            j=j+1;
%        end
% end 
samp=[377 388 1477 1488 4531 4542 7663 7674 9620 9631 9634 9645]';
LimeResults=lime(rnn,'DataLocality','local','NumNeighbors',10)
%LimeResults=lime(rnn,inputsTrain)

idx=1;
for i=1:length(samp)
        res(idx,1)=fit(LimeResults,RegInputs(samp(i,1),:),25,'NumNeighbors',10);
%res(idx,1)=fit(LimeResults,RegInputs(samp(i,1),:),25);
         Lime{idx,1}.Index=samp(i,1);
         [~,I] = sort(abs(res(idx,1).SimpleModel.Beta),'descend');
         Lime{idx,1}.ImportantPredictors=[names(I)' res(idx,1).SimpleModel.Beta(I)];
          clear I
        idx=idx+1;
end
   

%         results = fit(prova,DerInputs(380,:),15);
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
% m=1;
% for  t=1:length(Lime)
%     for  p=1:length(peaks)
%     if Lime{t,1}.Index==peaks(p)
%         LimeMatrix(:,m)=[Lime{t,1}.Index ; Lime{t,1}.ImportantPredictors(:,1);'peak'];
%         break;
%     else
%         LimeMatrix(:,m)=[Lime{t,1}.Index ; Lime{t,1}.ImportantPredictors(:,1); 0];
%     end
%     end
%     m=m+1;
% end
% 
% for c=1:size(LimeMatrix,2)
%     i=str2num(LimeMatrix(1,c));
%     LimeMatrix(28,c)=RegOutputs(i,1);
% end

% outputs_learn=predict(res(124,1).SimpleModel,inputsTrain);
% outputs_test=predict(res(124,1).SimpleModel,inputsTest);
% coefficientT=corrcoef(outputsTest,outputs_test)
% coefficientL=corrcoef(outputsTrain,outputs_learn)
% % 
% % figure,plot([outputsTrain outputs_learn])
% % % title('Regressors matrix- Learning')
% % figure,plot([outputsTest outputs_test])
% % % title('Regressors matrix- Test')
% % LimeResults=lime(rnn,inputsTrain);
% 
% plot(DerOutputs)
% hold on
% hold on, plot(polyshape([0 0 10072 10072],[0.65 1.25 1.25 0.65]))
