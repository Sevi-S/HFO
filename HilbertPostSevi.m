load Mario03_Filter_8min.mat

t = 1:1000000;

Median = zeros(76,4); 

x = 1; j = 1; k = 1; m = 1;

CrossThresholds = zeros(78, 1000000);

Background = zeros(78, 320);

Background(:,1:160) = Mario3filtered_8min(:,1:160);
Background(:,161:end) = Mario3filtered_8min(:,end-159:end);

while x < 8
    
    disp(x)
    
    hilbert_3 = abs(hilbert(Background.'));
    hilbert_3Median = median(hilbert_3);
    hilbert_3trans = hilbert_3.';
    
    hil_3medtrans = hilbert_3Median.';
    hilmedianthreshold = 3*hil_3medtrans;
   

x = x + 1;

end

%%

startsegment = 1;
endsegment = 1;
lengthsegment = 0;
crosscount = 0;
HFOcount = 0;

Mario3_Filtered_8min_HilbertFilter = table([0],[0],[0],[0],[0],'VariableNames',{'ChNum','startsegment','endsegment', 'lengthsegment', 'crosscount'});

%'Channel number' 'Start Time' 'End Time' 'Length' '# crossing threshold';

j = 1000000;
i = 1;

while i <= 15612 %Length of vector using Length()not working
    
    j = TableMario03_Filter_8min_ZerosCrossing{i, 3};
    
    while j <= (TableMario03_Filter_8min_ZerosCrossing{i, 4})
        
        if lengthsegment < 200
             
            if abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j).')) > hilmedianthreshold(TableMario03_Filter_8min_ZerosCrossing{i,1}, 1)
                                
               if j <= 2 && abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j-1).')) < hilmedianthreshold(TableMario03_Filter_8min_ZerosCrossing{i,1}, 1)
                    crosscount = crosscount + 1;
                    lengthsegment = lengthsegment + 1;
                    
               elseif j > 3 && abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j-2).')) < hilmedianthreshold(TableMario03_Filter_8min_ZerosCrossing{i,1}, 1)
                    crosscount = crosscount + 1;
                    lengthsegment = lengthsegment + 1;
                    
               else
                    lengthsegment = lengthsegment + 1;
               end
               
            elseif (abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j).')) < hilmedianthreshold(TableMario03_Filter_8min_ZerosCrossing{i,1}, 1))
                
                if j > 3 && (abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j-2).')) > hilmedianthreshold(TableMario03_Filter_8min_ZerosCrossing{i,1}, 1))
                    crosscount = crosscount + 1;
                    lengthsegment = lengthsegment + 1;
                
                elseif j > 4 && j < 1000000-4 && abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j).')) > abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j+3).')) && abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j).')) > abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j-3).'))
                     if lengthsegment > 60 && crosscount > 8

                            endsegment = j;
                            startsegment = endsegment - lengthsegment;
                            
                            HFOcount = HFOcount + 1;
                            
                            ChNum = TableMario03_Filter_8min_ZerosCrossing{i,1};
            
                            T = table(ChNum, startsegment, endsegment, lengthsegment, crosscount);
            
                            Mario3_Filtered_8min_HilbertFilter = [Mario3_Filtered_8min_HilbertFilter;T];

                            crosscount = 0;
                            lengthsegment = 0;

                     end
                      
                    crosscount = 0;
                    lengthsegment = 0;
                    

                elseif j < 4 && j > 1000000-3 && abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j).')) > abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j+1).')) && abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j).')) > abs(hilbert(Mario3filtered_8min(TableMario03_Filter_8min_ZerosCrossing{i,1},j-1).'))
                    crosscount = 0;
                    lengthsegment = 0;
                    
                else
                    lengthsegment = lengthsegment + 1;
                    
                end
                
            end
                    
               
        elseif lengthsegment >= 200 && crosscount > 8

            endsegment = j;
            startsegment = endsegment - lengthsegment;
            
            HFOcount = HFOcount + 1;
            
            ChNum = TableMario03_Filter_8min_ZerosCrossing{i,1};
            
            T = table(ChNum, startsegment, endsegment, lengthsegment, crosscount);
            
            Mario3_Filtered_8min_HilbertFilter = [Mario3_Filtered_8min_HilbertFilter;T];

            lengthsegment = 0;
            crosscount = 0;

        end
     
         j = j + 1;
         
    end
    
    i = i + 1;
    fprintf('i:  %d \n' , i);

end
