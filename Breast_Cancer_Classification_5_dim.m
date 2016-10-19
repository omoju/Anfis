% Author: OMOJU THOMAS
% Breast Cancer Prediction using the Adaptive Neuro Fuzzy Inference

% load breast cancer finalData
% 1. Clump Thickness               1 - 10
% 2. Uniformity of Cell Size       1 - 10
% 3. Uniformity of Cell Shape      1 - 10
% 4. Marginal Adhesion             1 - 10
% 5. Single Epithelial Cell Size   1 - 10

clear all;
clear all;

data = load('finalData.txt'); 
classes = load('classes.txt');

% Normalize the data using Z score
 normdata = zscore(data);

data = [normdata classes];
% create training and checking data


% equal distribution of data
d1=data(1:147, :);
d2=data(444:526, :);
trnData = [d1; d2];

d5=data(148:295, :);
d6=data(527:609, :);
testData = [d5;d6];

d3=data(296:443, :);
d4=data(610:682, :);
chkData = [d3;d4];

MaxDim = 5;

clear d1;
clear d2;
clear d3;
clear d4;
clear d5;
clear d6;

% To start the training, we need an FIS structure that specifies the
% structure and initial parameters of the FIS for learning. This is the task of genfis1.
MyFIS5Dim = genfis1(trnData, 3, 'gaussmf');

MyFIS5Dim.input(1,1).name = 'Clump Thickness';
    MyFIS5Dim.input(1,1).mf(1,1).name = 'LowThick';
    MyFIS5Dim.input(1,1).mf(1,2).name = 'MediumThick';
    MyFIS5Dim.input(1,1).mf(1,3).name = 'VeryThick';
    
MyFIS5Dim.input(1,2).name = 'Uniformity of Cell Size';
    MyFIS5Dim.input(1,2).mf(1,1).name = 'NotUniform';
    MyFIS5Dim.input(1,2).mf(1,2).name = 'FairlyUniform';
    MyFIS5Dim.input(1,2).mf(1,3).name = 'Uniform';
    
MyFIS5Dim.input(1,3).name = 'Uniformity of Cell Shape';
    MyFIS5Dim.input(1,3).mf(1,1).name = 'NotUniform';
    MyFIS5Dim.input(1,3).mf(1,2).name = 'FairlyUniform';
    MyFIS5Dim.input(1,3).mf(1,3).name = 'Uniform';
    
MyFIS5Dim.input(1,4).name = 'Marginal Adhesion';
    MyFIS5Dim.input(1,4).mf(1,1).name = 'Low';
    MyFIS5Dim.input(1,4).mf(1,2).name = 'Medium';
    MyFIS5Dim.input(1,4).mf(1,3).name = 'High';
    
MyFIS5Dim.input(1,5).name = 'Single Epithelial Cell Size';
    MyFIS5Dim.input(1,5).mf(1,1).name = 'Low';
    MyFIS5Dim.input(1,5).mf(1,2).name = 'Medium';
    MyFIS5Dim.input(1,5).mf(1,3).name = 'High';

% The range of the membership functions
for t=1:MaxDim, 
    MyFIS5Dim.input(1,t).range = [min(data(:, t)) , max(data(:, t))];
end

%We set the training options in the vector 
%   TRNOPT(1): training epoch number :100                    
%   TRNOPT(2): training error goal : 0                      
%   TRNOPT(3): initial step size : 0.01                        
%   TRNOPT(4): step size decrease rate : 0.9                   
%   TRNOPT(5): step size increase rate : 1.1      

k = [300 0 0.01 0.9 1.1];
[MyFIS5Dim1,error1,ss,MyFIS5Dim2,error2] = anfis(trnData,MyFIS5Dim,k,[],chkData);


