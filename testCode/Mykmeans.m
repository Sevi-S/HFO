function [indices] = Mykmeans(data, nbrcluster,iteratoinnbr)
% This code has been written by Louis Weyland 
% It use it to calculate the kmeans with a specific number of iteration X

  

  
  knbr = nbrcluster;                %number of clustering aka number of center generated
  l = size(data,1);                 % lenght of columns
  ind = zeros(size(data,1), 1); 
  
  %defining random points in the range of the data
  
  minxscale= min(data(:,1));       %  considering the first column to be the x coordinate
  maxxscale= max(data(:,1));       
  
  maxyscale=max(max(data(:,2:end)));
  minyscale=min(min(data(:,2:end)));
 
  
  rx = (maxxscale-minxscale).*rand(nbrcluster,1) + minxscale  % random center are generated in the range of the data
  ry= (maxyscale-minyscale).*rand(nbrcluster,1) + minyscale  %
  
  
  center= [rx ry];
  X= iteratoinnbr;
  
  for p=1:X
                                   % creating an indices matrix to capture which center k the data is the nearest
 for i=1:l                         % for every row of the data  the distance square of the first center is calculated
    k = 1;                          % and then the distance square of the other centers a calculated before passing to the next row of the data 
    dist1 = sum((data(i,:) - center(1,:)) .^ 2);  
    for ll=2:knbr
        dist2 = sum((data(i,:) - center(ll,:)) .^ 2);
        if(dist2 < dist1)           % thereby the distance square is  calculated and compared between the first center (initially said to be the min) and the other center         
          k = ll;                  % the center with lower distance square than the first is then assignet as nearest center to the repsective data point
        end
    end                          
    ind(i) = k       ;           % the ind stores the indices of the centre with the lowest distance square to the respective data point
  end


for u=1:knbr
    
    ci=data(ind==u,:);
    
    lengthci= length(ci(:,1));
    
    center(u,:) = sum(ci)/lengthci ;
   
   
    
end

  end
    scatter(data(:,1),data(:,2))
hold on 
plot(center(:,1),center(:,2),'.','MarkerSize',20)
hold off

end


