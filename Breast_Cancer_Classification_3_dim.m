% Author: OMOJU THOMAS
% Breast Cancer Prediction using the Adaptive Neuro Fuzzy Inference for
% 3-dimensional data

% load breast cancer finalData3
% 1. Clump Thickness               1 - 10
% 2. Uniformity of Cell Size       1 - 10
% 3. Uniformity of Cell Shape      1 - 10


clear all;
clear all;

data = load('finalData3.txt'); 
classes = load('classes.txt');

% Normalize the data using Z score
normdata = zscore(data);
data = [data classes];

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

MaxDim = 3;

clear d1;
clear d2;
clear d3;
clear d4;
clear d5;
clear d6;

% To start the training, we need an FIS structure that specifies the
% structure and initial parameters of the FIS for learning. This is the task of genfis1.
% initialize a fis with 3 gaussian member funtions per input.
MyFIS3Dim = genfis1(trnData, 3, 'gaussmf');

MyFIS3Dim.input(1,1).name = 'Clump Thickness';
    MyFIS3Dim.input(1,1).mf(1,1).name = 'LowThick';
    MyFIS3Dim.input(1,1).mf(1,2).name = 'MediumThick';
    MyFIS3Dim.input(1,1).mf(1,3).name = 'VeryThick';
    
MyFIS3Dim.input(1,2).name = 'Uniformity of Cell Size';
    MyFIS3Dim.input(1,2).mf(1,1).name = 'NotUniform';
    MyFIS3Dim.input(1,2).mf(1,2).name = 'FairlyUniform';
    MyFIS3Dim.input(1,2).mf(1,3).name = 'Uniform';
    
MyFIS3Dim.input(1,3).name = 'Uniformity of Cell Shape';
    MyFIS3Dim.input(1,3).mf(1,1).name = 'NotUniform';
    MyFIS3Dim.input(1,3).mf(1,2).name = 'FairlyUniform';
    MyFIS3Dim.input(1,3).mf(1,3).name = 'Uniform';

% The range of the membership functions
for t=1:MaxDim, 
    MyFIS3Dim.input(1,t).range = [min(data(:, t)) , max(data(:, t))];
end

% plot membership functions

subplot(2,2,1);
plotmf(MyFIS3Dim, 'input', 1);
subplot(2,2,2);
plotmf(MyFIS3Dim, 'input', 2);
subplot(2,2,3);
plotmf(MyFIS3Dim, 'input', 3);


% Train Network with 300 epochs.
k = [10 0 0.01 0.9 1.1];
[MyFIS3Dim1,error1,ss,MyFIS3Dim2,error2] = anfis(trnData,MyFIS3Dim,k,[],chkData);

% If training with back propagation, then import the fis to anfisedit and
% choose backpropagation algorithm.


