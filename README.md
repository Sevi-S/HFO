# HFO Project final product methods and code

### 0. Start with raw EEG data

### 1. Filtering
   - Bipolar montages made with EEGLAB in matlab
   - Bandpass Filtering - FIRFILTFILT.m

### 2. Sieving
   - StabaMethod - StabaMethod.m, getHfo.m (need getHfo function file, in same directory)
   - delete full 0 rows - {filename(~filename.ChNum,:) = []} - run from matlab command line
   - zero crossing numbers - ZeroCrossing.m
   - Hilbert transform Hilbert.m
   -  FFT - FFT.m

### 3. Feature extraction
   - Spectral Entropy - SpectralEntropy.m
   - Subband power ratio - SubbandPowerRatio.m
   - Peak to Notch ratio - FrequencyWithMaxPn.m

### 4. Clustering and Graphing
   - GMM Clustering and Elbow to find k value - GMMClusteringElbow.m


All matlab files are in foler named "Final".
All experimental and trial code can be found in "testCode".
Procdure was done the order of this list. Further information about methods can be found in the comments of each file or within the methods section of our paper.

