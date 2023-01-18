# SRU-project


CREATION OF THE MATRICES OF INTEREST:
The LIME and SHAP methods have been applied to two matrices of interest, one related to the chosen regressors and the other to the first and second derivatives of the variables.
In order to construct them, the file SRUproject.m was created.
SRUproject.m calls the functions model_input.m and model_output.m for creating the regressors matrix of the inputs and of the output, RegInputs and RegOutputs respectively.
The function incrementalRatio.m is needed for the calculus of the derivatives.
The function creationMatrix.m generates the final derivatives matrix, DerInputs and DerOutputs.


REGRESSION NEURAL NETWORKS AND INDIVIDUATION OF THE SAMPLES OF INTEREST:
For applying LIME and SHAP the optimal RNNs have been obtained with the optimization of the hyperparameters.
For this aim, the scripts regRNN.m and derRNN.m were created.
Observe! In these scripts also LIME method is then implemented.
The first step is the partition of the dataset randomply in 80% for the training and the remaining 20% for the test.
fitrnet command was used for obtaining the rnn variables.
The dataset is partitioned again, now not randomly.
The peaks variables individuate the values of the outputs which are greater or equal to 3, and those which are less or equal to -3.
In order to analyze the 10 samples before and after the peaks the variable samples was created.
Definitely the variable samp contains all the samples of interest.


LIME:
In regRNN.m and derRNN.m LIME approach is implemented.
The command lime permits to obtain LimeResult variable which can be fitted for each queary point (the previous selected samples) of interest.
At this point, the vatriable Lime is created were Lime.Index contains the index of the sample selected, and Lime.ImportantPredictors contains the important predictors with the corresponding beta-values. 
Note! Lime variable is not the direct result of the fit command applied to LimeResult, instead it is the res variable which is too large to be inserted here.
At the end, LimeMatrix was constructed which is a matrix containing the index of the sample of interest, the corresponding important preictors and the label 'peak' that indicates if the sample is a peak or a close sample.


SHAPLEY VALUES:
At this point, it's possible to apply the command shapley to the rnn previously obtained, this brings to the ShapResults.
In order to find the Shapley Values, the command fit was inserted to each query point, obtaining in this way the res variables, which is not present here because too large.
The variable ShapValues contains the indices and the Shapley Values of each query point of interest.
The matrix ShapMatrix englobes the index of each query point, the important predictors and the label 'peak' if the sample is or not a peak.
