q = Mario3_GMM_Table(:,6:8);
x = table2array(q)
[numInst,numDims] = size(x);

%# K-means clustering
%# (K: number of clusters, G: assigned groups, C: cluster centers)
K = 3;
[G,C] = kmeans(x, K, 'distance','sqEuclidean', 'start','sample');

%# show points and clusters (color-coded)
clr = lines(K);
figure, hold on
scatter3(x(:,1), x(:,2), x(:,3), 36, clr(G,:), 'Marker','.')
scatter3(C(:,1), C(:,2), C(:,3), 100, clr, 'Marker','o', 'LineWidth',3)
hold off
view(3), axis vis3d, box on, rotate3d on
xlabel('x'), ylabel('y'), zlabel('z')