data = load('Mario03_Filter_8min.mat');
count = 1;

Table = {0,0,0,0};

while length(data.Mario3filtered_8min(:,1)) >= count %scroll through data 1 channel at a time

    y = data.Mario3filtered_8min(count,:);
    
    k = 205;  %%100ms window at 2048hz sample rate
    M = movstd(y,k);    %moving standard deviation
    med = median(M);    %mean   
    ampThresh = 5*med;  % define threshold
    
    %analyze one channel
    %will get put into a table in getChan
    
    t = getHFO(y,ampThresh,count);  %get hfos
    Table = [Table;t]; %export to table
    
    count = count + 1;
end
