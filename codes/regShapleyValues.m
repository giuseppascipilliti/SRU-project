ShapResults=shapley(rnn,inputsTrain,'UseParallel',true);


idx=1;
for i=1:length(samp)
        res(idx,1)=fit(ShapResults,RegInputs(samp(i,1),:));
         ShapValues{idx,1}.Index=samp(i,1);
         [~,I] = sort(abs(res(idx,1).ShapleyValues.ShapleyValue),'descend');
         ShapValues{idx,1}.shapvalues=[names(I)' res(idx,1).ShapleyValues.ShapleyValue(I)];
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
for  t=1:length(ShapValues)
    for  p=1:length(peaks)
    if ShapValues{t,1}.Index==peaks(p)-9
        ShapMatrix(:,m)=[ShapValues{t,1}.Index ; ShapValues{t,1}.shapvalues(:,1);'peak'];
        break;
    else
        ShapMatrix(:,m)=[ShapValues{t,1}.Index ; ShapValues{t,1}.shapvalues(:,1); 0];
    end
    end
    m=m+1;
end
for c=1:size(ShapMatrix,2)
    i=str2num(ShapMatrix(1,c));
    ShapMatrix(28,c)=RegOutputs(i,1);
end

% plot(res())
