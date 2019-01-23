data = load('Mario03_Filter_8min.mat');
count = 1;

Table = {0,0,0,0};

while length(data.Mario3filtered_8min(:,1)) >= count

    y = data.Mario3filtered_8min(count,:);
    
    k = 205;  %%100ms window at 2048hz sample rate
    M = movstd(y,k);
    med = median(M);
    ampThresh = 5*med;
    
    %analyze one channel
    %will get put into a table in getChan
    
    t = getHFO(y,ampThresh,count);
    Table = [Table;t];
    
    count = count + 1;
end