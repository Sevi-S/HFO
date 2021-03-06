%% Subband_power_ratio

for ii= 1:length(Mario4_GMM_Table.ChNum)%scroll through data
    
     
row=Mario4_GMM_Table.ChNum(ii);


windowlength=ceil((Mario4_GMM_Table.lengthsegment(1)*0.48)/2);
overlaplength=ceil(windowlength/4);
    
%power
[pxx,f] = pwelch(data(row,Mario4_GMM_Table.startsegment(ii):Mario4_GMM_Table.endsegment(ii)),windowlength,overlaplength,1024,2048);


low_band = f > 16 & f < 80;%find low band
low_band_indices=find(low_band == max(low_band(:)));

high_band = f> 80 & f < 500;%find highband
high_band_indices=find(high_band == max(high_band(:)));




ratio = sum(pxx(high_band_indices(1):high_band_indices(end)))/sum(pxx(low_band_indices(1):low_band_indices(end)));%calculate ratio

Mario4_GMM_Table.Power_ratio(ii)={ratio};%push to table



end

 Mario4_GMM_Table.Power_ratio=cell2mat(Mario4_GMM_Table.Power_ratio);%cell to number

