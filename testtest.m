load Mario03_Filter_8min.mat;

datadata = data;

load mario03Staba.mat;

filtereddata = testTable;

i = 33027;
j = 1;

TableMario03_Filter_8min_Zeros1 = table([0],[0],[0],[0],'VariableNames',{'chanNum','zerocrossing','startsegment','endsegment'});

chanNum = 0;
zerocrossing = 0;
startsegment = 0;
endsegment = 0;

MarioZeroCrossingTable = zeros(1000,4);

Mario3_Filtered_8min_ZerosFilter = zeros(1000,5);

while i <= 34688
    
    j = filtereddata{i, 3};
    
    while j <= (filtereddata{i, 4})
        
        if j > 2 && data(filtereddata{i,1}, j) > 0 && data(filtereddata{i,1}, j-1) < 0
            
            zerocrossing = zerocrossing + 1;
        
        elseif j > 2 && data(filtereddata{i,1}, j) < 0 && data(filtereddata{i,1}, j-1) > 0
            
            zerocrossing = zerocrossing + 1;
           
        end
        
        j = j + 1;
    
    end
            
        if zerocrossing < 11

        chanNum = filtereddata{i,1};
        startsegment = filtereddata{i,3};
        endsegment = filtereddata{i,4};

        T = table(chanNum, zerocrossing, startsegment, endsegment);
        TableMario03_Filter_8min_Zeros1 = [TableMario03_Filter_8min_Zeros1; T];

        zerocrossing = 0;
        
        end
        
     zerocrossing = 0;
        
     i = i + 1;
        
end