% Author: OMOJU Miller
% load breast cancer data
% 1. Clump Thickness               1 - 10
% 2. Uniformity of Cell Size       1 - 10
% 3. Uniformity of Cell Shape      1 - 10
% 4. Marginal Adhesion             1 - 10
% 5. Single Epithelial Cell Size   1 - 10
% 6. Bare Nuclei                   1 - 10
% 7. Bland Chromatin               1 - 10
% 8. Normal Nucleoli               1 - 10
% 9. Mitoses                       1 - 10
% 10. Class:                       (2 for benign, 4 for malignant)

% Clear all variables and figures.
  clear all;

  data1 = load('breast-cancer-wisconsin-clean.txt');
  data = [data1(:,1),data1(:,2), data1(:,3), data1(:,4), data1(:,5), data1(:,6), data1(:,7), data1(:,8), data1(:,9)];
  classes = data1(:, 10);
  
% Plot data.
  %plot([1:682],data,'x');
  
% Calculate PC's.
 myCov = cov(data);
 [pc, latent, explained] = pcacov(myCov);
 
 % rotate the data to the principal values
 finalData = data*pc(:,1:3);
 
% Plot data.
  figure;
  plot([1:682], finalData(:,1), 'b*', [1:682], finalData(:,2), 'ro',[1:682], finalData(:,3), 'gx');
  xlabel('Index');
  ylabel('Value');
  title('Reduced Data');
  h = legend('Clump Thickness','Uniformity of Cell Size', 'Uniformity of Cell Shape',3);

% Tidy up.
  close all;

  

