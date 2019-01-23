%% ZeroCrossing - To ensure segments following Staba method do not cross the zero line more than 10 times
    % Megan Entzinger
    % 17-Jan-2019

load Mario03_Filter_8min.mat; %load filtered data
datadata = data;

load mario03Staba.mat; %load data containing segments following Staba method
filtereddata = testTable;

i = 1;
j = 1;

% Table created to store all data points to survive zero crossing filtering step
Mario03_Filter_8min_Zeros = table([0],[0],[0],[0],'VariableNames',{'chanNum','zerocrossing','startsegment','endsegment'});

%Variables in table
chanNum = 0; %Bipolar montage channel number
zerocrossing = 0; %Number of times the data crosses the zeroline
startsegment = 0; %Data point at start of segment
endsegment = 0; %Data point at end of segment

MarioZeroCrossingTable = zeros(1000,4);

%Loops through each segment from start to end to count number of zero crossings
while i <= 34688 %Change Value depending on number of segments following staba method
    
    j = filtereddata{i, 3}; %Assigns j values as start point
    
    while j <= (filtereddata{i, 4}) %while j values is less than end point
        
        if j > 2 && data(filtereddata{i,1}, j) > 0 && data(filtereddata{i,1}, j-1) < 0
            %Checks if data point is above zero and previous value is below zero making it a point at which is crosses zero
            zerocrossing = zerocrossing + 1;
        
        elseif j > 2 && data(filtereddata{i,1}, j) < 0 && data(filtereddata{i,1}, j-1) > 0
            %Checks if data point is below zero and previous value is above zero making it a point at which is crosses zero
            zerocrossing = zerocrossing + 1;
           
        end
        
        j = j + 1;
    
    end
    
    % After looping through segments, checks if crosses zero less than 10 times and assigns to able
    % Otherwise, it moves to the next segment
    if zerocrossing <= 10
        
        chanNum = filtereddata{i,1};
        startsegment = filtereddata{i,3};
        endsegment = filtereddata{i,4};

        T = table(chanNum, zerocrossing, startsegment, endsegment);
        Mario03_Filter_8min_Zeros = [Mario03_Filter_8min_Zeros; T];

        zerocrossing = 0;
    
    end
    
    zerocrossing = 0;
    
    i = i + 1;
    
    % Prints segment number every 100 segments
    if rem(i,100) == 0
        fprintf('i:  %d \n' , i);
    end
        
end