# HFO
## HFO Project final product methods and code

1. Raw data

### 1.Filtering
   - Bipolar montages made with EEGLAB in matlab
   - Bandpass Filtering - not in github

### 2. Sieving
   - StabaMethod - StabaMethod.m, getHfo.m (need getHfo function file, in same directory)
   - delete full 0 rows - {filename(~filename.ChNum,:) = []}
   - zero crossing numbers - zeroCrossingPostStaba.m
   - Hilbert transform *need to upload code*
   -  FFT - FFT.m

### 3. Feature extraction
   - Spectral Entropy - SpectralEntropy.m
   - Subband power ratio - SubbandPowerRatio.m
   - Peak to Notch ratio - FrequencyWithMaxPn.m

### 4. Clustering and Graphing
   - Gmm/k means
   - *upload code*


all matlab files are in foler named "Final"
all experimental and trial code can be found in "testCode"
