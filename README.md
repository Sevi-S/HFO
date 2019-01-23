# HFO
## HFO Project final product methods and code

1. Raw data

### Filtering
2. Bipolar montages
   - Bipolar montages made with EEGLAB in matlab
   - Bandpass Filtering - not in github

### "Sieving"
3. Staba 
   - StabaMethod - StabaMethod.m, getHfo.m (need getHfo function file, in same directory)
   - delete full 0 rows - {filename(~filename.ChNum,:) = []}
   - zero crossing numbers - zeroCrossingPostStaba.m
   - Hilbert transform *need to upload code*
   -  FFT - FFT.m

### Feature extraction
4. 3 different features
   - Spectral Entropy - SpectralEntropy.m
   - Subband power ratio - SubbandPowerRatio.m
   - Peak to Notch ratio - FrequencyWithMaxPn.m

### Clustering and Graphing
5. Gmm
   - *upload code*


all matlab files are in foler named "Final"
all experimental and trial code can be found in "testCode"
