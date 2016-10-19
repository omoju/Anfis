% Author: OMOJU THOMAS
% Get the correct Names for the inputs and the membership functions
for t=1:MaxDim, 
    MyFIS3Dim2.input(1,t).name = MyFIS3Dim.input(1,t).name;
end

for t=1:MaxDim,
    MyFIS3Dim2.input(1,t).mf(1,1).name = MyFIS3Dim.input(1,t).mf(1,1).name;
    MyFIS3Dim2.input(1,t).mf(1,2).name = MyFIS3Dim.input(1,t).mf(1,2).name;
    MyFIS3Dim2.input(1,t).mf(1,3).name = MyFIS3Dim.input(1,t).mf(1,3).name;
end

% Plot membership functions
subplot(2,2,1);
plotmf(MyFIS3Dim2, 'input', 1);
subplot(2,2,2);
plotmf(MyFIS3Dim2, 'input', 2);
subplot(2,2,3);
plotmf(MyFIS3Dim2, 'input', 3);

Max_index = size(testData);
Max_index = Max_index(1, 1);

anfis_output = evalfis(testData(:,1:MaxDim), MyFIS3Dim2);
subplot(211),plot([1:Max_index], anfis_output, 'r*', [1:Max_index], testData(:,MaxDim + 1), 'b.')
xlabel('Index');
ylabel('Output');
title('Experiment 2: Testing Data: Blue.      FIS Output: Red*');

error = testData(:,MaxDim + 1) - anfis_output;



class_benign = 0;
class_malignant = 0;
class_misclassified = 0;
mis_index = [0 , 0];

% Classification Table
for index = 1: Max_index
    if ((anfis_output(index) < (testData(index,MaxDim+1) - 0.5)) | (anfis_output(index) < (testData(index,MaxDim+1) + 0.5)))
         if(testData(index, MaxDim+1) == 2)
             class_benign = class_benign + 1;
         else(testData(index, MaxDim+1) == 4)
             class_malignant = class_malignant + 1;
         end
    else
        class_misclassified = class_misclassified + 1;
        if(testData(index, MaxDim+1) == 2)
            mis_index = [mis_index; 2, index];
        else
            mis_index = [mis_index; 4, index];
        end
    end
end



% Percent Misclassified
Mis_per = (class_misclassified / Max_index) * 100;
