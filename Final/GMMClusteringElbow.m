%% Clustering Method
    % Megan Entzinger
    % 22-Jan-2019

%% Copies Peak to Notch Ratio, Power Ratio and Spectral Entropy of Data Points into Matrix (GMMInput)

GMMinput = zeros(1112,3); %Change size depending on number of data points

%pp = table([], 'VariableNames', {'pxx'}); %Creates Table for 'Elbow Plots'

for i = 1:1112
    
    GMMinput(i,:) = Mario4_GMM_Table{i,6:8}; %Last 3 columns of input data
    
end

%% Clustering according to number of clusters (K)

K = 4; %Value changed depending on outcome of 'Elbow' plot

GMM4 = fitgmdist(GMMinput, K);

idx4 = cluster(GMM4, GMMinput);

%% 3D Scatter Plot with clustered groups

clr = lines(K);
figure, hold on
scatter3(normalize(GMMinput(:,1), 'range'), normalize(GMMinput(:,2), 'range'), normalize(GMMinput(:,3), 'range'), 36, clr(idx4,:), 'Marker','.');
hold off
view(3), axis vis3d, box on, rotate3d on
xlabel('\bf Freq with max P/N'), ylabel('\bf Sub-band power ratio'), zlabel('\bf Entropy')


%% Calculates and Plots 'Elbow' Plot

% gmpdf4 = pdf(GMM4, GMMinput); %Gaussian Probability Density Distribution (p(x))
% 
% pxx = sum(log(gmpdf4)); %Max log-likelihood of GMM
% 
% T = table(pxx); 
% pp = [pp;T];
% 
% % Creates 'Elbow' plot
% plot(1:7, pp{:,:});
% xlabel('\bf Cluster Number'), ylabel('\bf Pi')
% xticks([]), yticks([])

