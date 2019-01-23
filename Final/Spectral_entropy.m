%% Spectral_entropy

for ii= 1:length(Mario4_GMM_Table.ChNum)
    
row=Mario4_GMM_Table.ChNum(ii);
center_peak=round((Mario4_GMM_Table.startsegment(ii)+Mario4_GMM_Table.endsegment(ii))/2);
colstar=center_peak-266;
colend=center_peak+266;
L=length(colstar:colend);    
       
Y=fft(Mario4raw_8min(row,colstar:colend));

L=length(315854:315921);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

total_power=sum(P1);

%Denoising procedure
for k = 1:length(P1)
    
    if P1(1,k)< 0.01*total_power
       P1(1,k)=0;
    end
    
end


sum_fft_abs = sum(P1);

normalized_spectrum = P1 ./ sum_fft_abs;

Nonzero=find(normalized_spectrum);


normalized_spectrum = normalized_spectrum(:,any(normalized_spectrum,1));


spectral_entropy =  -sum(normalized_spectrum.* log(normalized_spectrum));


Mario4_GMM_Table.Spectral_Entropy(ii)=(spectral_entropy);


end

%Mario4_GMM_Table.Spectral_Entropy=cell2mat(Mario4_GMM_Table.Spectral_Entropy)
