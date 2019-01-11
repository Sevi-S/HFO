
r = randi([1 500],1,10000);

data = r;

%insert bipolar montage here
%Step 1 - filtering bandpass-filtfilt
d1 = designfilt('bandpassfir','FilterOrder',64,'CutoffFrequency1',80,'CutoffFrequency2',500,'SampleRate',2048);

y = filtfilt(d1,data)
plot(r)
plot(y)
spectrogram(r)
spectrogram(y)


%%
%step 2 and 3
%standard dev - moving window of 100ms
%k = 100ms - has to be hardedcoded later
k = 100;
M = movstd(y,k);

med = median(M);

ampThresh = 5*med;
plot(r)
yline(ampThresh,'--r')
%%
%step4
%change ms distance

%needs to be debugged.
%ms = 128
len = length(y)
xlen = 1


y
sector = zeros(2,len)
sector(1,:) = y

while len >0
    %have to figure this one out
    
     if (y(xlen)>100)%ampThresh goes here instead of 100
        
        upbound = xlen + ms;
        lowerbound = xlen - ms;
        
        sector(2,xlen)= 1;
     end
     
    xlen = xlen + 1;
    len = len -1;
end

%%
%sieveing process
%step5