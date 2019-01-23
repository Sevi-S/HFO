%% STFT on HFO candidate
%fast fourier transform

Mario4_GMM_Table = Mario4_Filtered_8min_HilbertCrossing; %load data
Matrix=[];
count=1;
for ii= 1:length(Mario4_Filtered_8min_HilbertCrossing.ChNum)    %length

    row=Mario4_Filtered_8min_HilbertCrossing.ChNum(ii);
    center_peak=round((Mario4_Filtered_8min_HilbertCrossing.startsegment(ii)+Mario4_Filtered_8min_HilbertCrossing.endsegment(ii))/2);
    colstar=center_peak-266;
    colend=center_peak+266;     %peaks on either side, 128ms on each side so 266 data points
    L=length(colstar:colend);
    
    Y=fft(Mario4raw_8min(row,colstar:colend));      %Matlab fft
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = 2048*(0:(L/2))/L;

    total_power=sum(P1);%get power

        for i = 1:length(P1) 
    
            if P1(1,i)< 0.01*total_power
                 P1(1,i)=0;
            end
    
        end

 Non_zero=find(P1); % find zeros

    for i=length(Non_zero)
 
         if f(Non_zero(i))> 80 
          
         else
    
        fprintf('This rows should be deleted: %d .\n', ii)
     
        Matrix(0+count,1)=ii;
       
        count=count+1;
      
        end
     end
 
end

Mario4_GMM_Table(Matrix,:) = [];

