dataT = Mario3_GMM_Table;
numGraphs = max(dataT.Cluster);

data = table2array(dataT);

   Ufirst = unique(data(:,9)); %separate into 3 clusters
n=numel(Ufirst);
cluster = cell(n,1);
for K = 1:n
    index=data(:,9)==Ufirst(K);
  cluster{K} = data(index,:);
end

count = 1;
while numGraphs >= count
    
    tempData = cluster{count}
   %fuu = tempData(:,1)
    %foo = unique(tempData(:,1))
    
    [a,b]=hist(tempData(:,1),unique(tempData(:,1)));
    
    q = a'; 
    
    bar(b,q)
    
    
    count = count +1;
end
