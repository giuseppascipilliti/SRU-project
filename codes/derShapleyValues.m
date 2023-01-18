ShapResults=shapley(rnn,inputsTrain,'UseParallel',true);
% res=fit(ShapResults,DerInputs(1,:));
names=nameVariables(DerInputs,2);

% ind=1;
% for r=1:length(DerOutputs)
%     if DerOutputs(r,1)>=3 || DerOutputs(r,1)<=-3
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

idx=1;
for i=1:length(samp)
        res(idx,1)=fit(ShapResults,DerInputs(samp(i,1),:));
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
    if ShapValues{t,1}.Index==peaks(p)
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
    ShapMatrix(18,c)=DerOutputs(i,1);
end
