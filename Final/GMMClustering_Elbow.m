%% Clustering Method
    % Megan Entzinger
    % 22-Jan-2019

%% Copies Peak to Notch Ratio, Power Ratio and Spectral Entropy of Data Points into Matrix (GMMInput)

GMMinput = zeros(1112,3); %Change size depending on number of data points

for i = 1:1112 %Change end value depending on number of data points
    
    GMMinput(i,:) = Mario4_GMM_Table{i,6:8}; %Last 3 columns of input data
    
end

%% Clustering according to number of clusters (K)

K = 4; %Value changed depending on outcome of 'Elbow' plot

GMM = fitgmdist(GMMinput, K);
idx = cluster(GMM, GMMinput);

%% 3D Scatter Plot with clustered groups

clr = lines(K);
figure, hold on
scatter3(normalize(GMMinput(:,1), 'range'), normalize(GMMinput(:,2), 'range'), normalize(GMMinput(:,3), 'range'), 36, clr(idx,:), 'Marker','.');
hold off
view(3), axis vis3d, box on, rotate3d on
xlabel('\bf Freq with max P/N'), ylabel('\bf Sub-band power ratio'), zlabel('\bf Entropy')


%% Calculates and Plots 'Elbow' Plot - Run Section Separately!
% This section does not run smoothly due to bug in fitgmdist function. Run section repeatedly until loop finishes

Elbow = table([], 'VariableNames', {'loglike'}); %Creates Table for 'ElbowPlots'

L = 1;

while L <= 7
    
    GMM = fitgmdist(GMMinput, L);
    
    gmpdf4 = pdf(GMM, GMMinput); %Gaussian Probability Density Distribution (p(x))

    loglike = sum(log(gmpdf4)); %Max log-likelihood of GMM

    T = table(loglike); 
    Elbow = [Elbow; T];
    
    L = L + 1;

end

% Creates 'Elbow' plot
plot(1:7, Elbow{:,:});
xlabel('\bf Cluster Number'), ylabel('\bf \it Pi')
xticks([]), yticks([])

