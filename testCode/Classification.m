% This code has been written by Louis Weyland
% It makes the classification of an unknown point to  previously defined
% clusters by mean of the kmean built-in function. 
% By increasing k, the number of neigbouring points, the unknown point can
% be associated to a cluster with greater precision

filename= 'lemon-orange.txt';  
delimiterIn='\t';
headlinesIn= 1;
file_data=importdata(filename,delimiterIn, headlinesIn); % loading file with the according delimiter since it is a txt.file and taking the header row into account
file_data;
A= file_data.data;   % containing just the data without headers
col_headers= file_data.colheaders;   % containing the header information
 
% This code has been written by Louis Weyland
% The use of this code is to generate a classification
training_data=A;
rng(2);
K=5;
C= kmeans(training_data,K);  % using the kmeans built-in function

training_data = cat(2, training_data,C);
gscatter(training_data(:,1), training_data(:,2), C); % plotting the clusters

test_data = [6.5 7.6; 7.5 8.7; 8.5 9];
% show test data on the same plot with the training data
plot(training_data(:,1), training_data(:,2), '+'); hold on; xlabel(col_headers{1}); ylabel(col_headers{2});
% show test data as red circles
plot(test_data(:,1), test_data(:,2), 'ro');
axis([3.7 11 3.7 11]); hold off;


j= length(training_data(:,1));

for o=1:j    % for every row of the  trainig data the square_distance of  the trainin_data to all the test  data is calculated 
    

   D(:,o) = square_distance(test_data,training_data(o,1:2))   ;
   
   
   % function [ d ] = square_distance(U,v)
   
   %This code has been written by Louis Weyland and consist of calulating the
   %sum-square error function

   %  n= length(U(:,1));



          %for k= 1:n
          %d(k,:) = sum((U(k,:) - v).^2);  % to each Xij is the difference calulated and then squared
          %end 


end

k= 5 ;  % number of nearest neighbours 

[d,ind] = sort((D) ,'ascend');   % sort the square_distance by the amount
 
indices = ind(1:5);        % taking the 3 first indices
nearestpoint = zeros(k, size(training_data,2));   % creating an empty matrix

for i = 1:k
    nearestpoint(i,:) = training_data(indices(i),:);   % fill the empty matrix with the data with the least square distance with the help of indices
end


[clusteradded, frequency] = mode(nearestpoint(:,3));    % doing the voting process by using the mode function which sees where the most values with the same value appear
