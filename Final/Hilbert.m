%% Hilbert Method Filtering
    % Megan Entzinger
    % 18-Jan-2019
    
%% Calculates Background Threshold
% 3x Mean of Hilbert Transform of first and last 80ms of filterd data for each channel

Zeros = TableMario04_Filter_8min_Zeros; %Change input file to file following zero crossing filtering

FilteredData = Mario4filtered_8min; %Change input file to filtered full data prior to Staba

t = 1:1000000; %Change length depending on number of data points in full filtered data

endnumber = 17574; %Change value depending on number of segments from Staba method

Background = zeros(78, 320);
Background(:,1:160) = FilteredData(:,1:160);
Background(:,161:end) = FilteredData(:,end-159:end);

x = 1;

while x <= 78 %change depending on number of bipolar montage channels
    
    hilbert_4 = abs(hilbert(Background.')); %Calculates hilbert transform of first and last 80ms o filtered data
    hilbert_4Median = median(hilbert_4); % Calculates median for each channel
    hil_4medtrans = hilbert_4Median.'; % Transforms median matrix
    hilmedianthreshold = 3*hil_4medtrans; % Sets Threshold as 3x median for each channel
   

x = x + 1;

end

%% Ensures segements with hilbert peaks above background threshold are 30-100 ms in length

k = 1; m = 1;
startsegment = 1;
endsegment = 1;
lengthsegment = 0;

%Table to store saved segments - change name as desired
Mario4_Filtered_8min_HilbertLength = table([],[],[],[],'VariableNames',{'ChNum','startsegment','endsegment', 'lengthsegment'});

j = 1;
i = 1;

% Loops through each segment to find where the hilbert transform crosses the background threshold for 30-100ms
while i <= endnumber
    
    j = Zeros{i, 3}; %sets j to starting point of segment
    
    while j <= (Zeros{i, 4}) && j <= 1000000 % while j is less than end point of segment
        
        if j > 0 && abs(hilbert(FilteredData(Zeros{i,1},j).')) > hilmedianthreshold(Zeros{i,1}, 1 ) 
            % Checks is hilbert is above threshold - begins segment length count
            lengthsegment = lengthsegment + 1;

            if abs(hilbert(FilteredData(Zeros{i,1},j+1).')) < hilmedianthreshold(Zeros{i,1}, 1)
                %Checks if next data point is below threshold - if it is,it ends count od f segment length
                endsegment = j;
                startsegment = endsegment - lengthsegment;

                if lengthsegment > 62 && lengthsegment < 205
                    % after segment length is determined, check if segment is longer than 30ms and less than 100ms
                    % if it is, saves segment in table
                   
                    ChNum = Zeros{i,1};

                    T = table(ChNum, startsegment, endsegment, lengthsegment);
                    Mario4_Filtered_8min_HilbertLength = [Mario4_Filtered_8min_HilbertLength;T];
                    lengthsegment = 0;

                end
                
            end
            
        end
     
         j = j + 1;
         
    end
    
    i = i + 1;
    
    % Prints data point number every 100 points
    if rem(i,100) == 0
        fprintf('i:  %d \n' , i);
    end
    
end

%% Ensures previously saved segments following Hilbert transfrom cross threshold (filtered data) at least 8 times

% Table to save new segments - change as desired
Mario4_Filtered_8min_HilbertCrossing = table([],[],[],[],[],'VariableNames',{'ChNum','startsegment','endsegment', 'lengthsegment', 'crosscount'});

hilbertlength = Mario4_Filtered_8min_HilbertLength; % table of segments from previous section

crosscount = 0;

i = 1;

%Loops through each segment to count number of times filtered data crosses threshold
while i <= 11538 % change value to number of segments saved in previous section
    
    startsegment = hilbertlength{i,2};
    endsegment = hilbertlength{i,3};
    
    j = startsegment; %sets j to starting point of segment
    
    while j <= endsegment && j <= 1000000 % while j is less than end point of segment
       
        if FilteredData(hilbertlength{i,1},j) > hilmedianthreshold(hilbertlength{i,1}, 1) && FilteredData(hilbertlength{i,1},j-1) < hilmedianthreshold(hilbertlength{i,1}, 1)
            %Checks if data point is above threshold and previous point is below threshold - counts as crossing threshold once
            crosscount = crosscount + 1;
        
        elseif FilteredData(hilbertlength{i,1},j) > hilmedianthreshold(hilbertlength{i,1}, 1) && FilteredData(hilbertlength{i,1},j+1) < hilmedianthreshold(hilbertlength{i,1}, 1)
            %Checks if data point is below threshold and previous point is above threshold - counts as crossing threshold once
            crosscount = crosscount + 1;
            
        end
        
        j = j + 1;
        
    end
       
    if crosscount > 8
        % Checks if segment crosses threshold more than 8 times to eliminate noise
        % if the segment does, segment details are saved to table
        ChNum = hilbertlength{i,1};
        startsegment = hilbertlength{i,2};
        endsegment = hilbertlength{i,3};
        lengthsegment = hilbertlength{i,4};
         
        T = table(ChNum, startsegment, endsegment, lengthsegment, crosscount);
        
        Mario4_Filtered_8min_HilbertCrossing = [Mario4_Filtered_8min_HilbertCrossing; T];
         
        crosscount = 0;
         
    end

    i = i + 1;
    
     % Prints data point number every 100 points
    if rem(i,100) == 0
        fprintf('i:  %d \n' , i);
    end
    
    
end