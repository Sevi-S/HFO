# HFO
## HFO Project final product methods and code


### Filtering
1. Raw data

2. Bipolar montages
   - Bandpass Filtering - not in github

### "Sieving"
3. Staba - StabaMethod(need getHfo function file, in same directory)
    - delete full 0 rows - {filename(~filename.ChNum,:) = []}
    - zero crossing numbers - zeroCrossingPostStaba


4. Hilbert transform
   -  FFT - FFT

### Feature extraction
5. 3 different features
   - Spectral Entropy - SpectralEntropy
   - Subband power ratio - SubbandPowerRatio
   - Peak to Notch ratio - FrequencyWithMaxPn

### Clustering and Graphing
6. Gmm


all matlab files are in foler named "Final"
all experimental and trial code can be found in "testCode"
