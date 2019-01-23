%%Frequency with max P/N

%counting the rows where no P/N is given
count=1;
Empty_PeakNotch_row=[];

for i= 1:length(Mario4_GMM_Table.ChNum)
 

row=Mario4_GMM_Table.ChNum(i);
center_peak=round((Mario4_GMM_Table.startsegment(i)+Mario4_GMM_Table.endsegment(i))/2);
colstar=center_peak-208;
colend=center_peak+208;
  
 
L=length(colstar:colend);

Y=fft(Mario4raw_8min(row,colstar:colend));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
ps=P1;
ps_denoised=P1;


f = 2048*(0:(L/2))/L;

total_power=sum(P1);

for ii = 1:length(P1)
    
    if ps_denoised(1,ii)< 0.01*total_power
        ps_denoised(1,ii)=0;
    end
    
end


%Find the local maximum
[HighBand_ind]= find(f > 80  & f <500);
[LowBand_ind]= find(f > 40  & f <100);



%Find the local minimum

if length(LowBand_ind)<3
    LL=length(LowBand_ind);
    LowBand_ind(1,(LL+1)) = LowBand_ind(LL)+1 ;    % add an extra colum in case it is smaller than 3 col need to define the peaks
    [throughs] = findpeaks(-ps(LowBand_ind));
    
    for iii= 1:length(throughs)
       
    throughs_locs(iii)= find(-throughs(iii)==ps);
    
    end
    
  

else
[throughs,throughs_locs] = findpeaks(-ps(LowBand_ind));

 for k= 1:length(throughs)
        
    throughs_locs(k)= find(-throughs(k)==ps);
   
 end
end


if isempty(throughs)
    fprintf('No minimum found  row : %d .\n', i)
     
      Empty_PeakNotch_row(0+count,1)=i;
       
       count=count+1;
   %continue
  
else

%Find the local maximum
min_energy=min(-throughs);

start_peak=find(min_energy==ps);
end_peak=HighBand_ind(end);
[pks_denoised,pksLocs_denoised] = findpeaks(ps_denoised(start_peak:end_peak));

for kk= 1:length(pks_denoised)
        
    pksLocs_denoised(kk)= find(pks_denoised(kk)==ps);
    
end


end

if  isempty(pks_denoised) || max(pks_denoised)==0
    fprintf('no peak has been detected in the denoised signal row %d .\n', i)
    
    Empty_PeakNotch_row(0+count,1)=i;
    count=count+1;
    
  continue
end

   

% Find the nearsest minimum next to the peak
ratiotable=pks_denoised;

for j= 1:length(pksLocs_denoised)
 
if f(pksLocs_denoised(j))-50 <=0
    [Hz_Range]= find(f(1)  & f < f(pksLocs_denoised(j)));  

   
else
[Hz_Range]= find(f > f(pksLocs_denoised(j))-50  & f < f(pksLocs_denoised(j)));  
end

if isempty(Hz_Range)
    fprintf('No minimum found in the 50Hz range... row %d .\n',i)
    
    Empty_PeakNotch_row(0+count,1)=i;
    count=count+1;
    
    continue 
else
[En_value,En_locs] = findpeaks(-ps(Hz_Range));

for jj= 1:length(En_locs)
        
   En_locs(jj)= find(-En_value(jj)==ps);
    
end


if isempty(En_value)
        fprintf('No En_value...row %d', i)
        
         Empty_PeakNotch_row(0+count,1)=i;
         count=count+1;
         
        continue
else
ratiotable(2,j)= -En_value(end);

end

%%
for z=1:length(ratiotable(1,:))

    if  isempty(ratiotable(2,z)) 
        
    elseif ratiotable(2,z) ~= 0;
    ratiotable(3,z)= ratiotable(1,z)/ratiotable(2,z);
    end

end

P_N_ratio=max(ratiotable(3,:));
    Mario4_GMM_Table.F_Nratio(i)={P_N_ratio};

end

end

end


Mario4_GMM_Table(Empty_PeakNotch_row,:) = [];
Mario4_GMM_Table.F_Nratio=cell2mat(Mario4_GMM_Table.F_Nratio);

