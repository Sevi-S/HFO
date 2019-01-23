y = z;
function [chTable] = getHFO(z, ampThresh, chanNum)%for one channel
tempTable = table([0],[0],[0],[0],'VariableNames',{'chanNum','numCross','lowerbound','upbound'});
%Step3
numCross = 0;
ms = 262; %data points per 128ms - start and finish are 128 ms before and after hFO main peak
len = length(y);      
count = 1;
[pks,locs] = findpeaks(y)
    while count < length(pks)
        if (pks(count)>ampThresh)
            
            numCross = numCross + 1;
            upbound = locs(count) + ms;%change pks(count) to correct index in original set
            lowerbound = locs(count) - ms;
        
            T = table(chanNum, numCross, lowerbound, upbound);
            tempTable = [tempTable;T];
           
            count = count+1;
        else
            count = count +1;
        end
    end
    chTable = tempTable;
end
