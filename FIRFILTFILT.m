%%% FIRfilt & Filtfilt
%% This code has been written by Louis Weyland 11/01/2019
%% Load the files and the interesting information 

EEG= pop_loadset('Mario15_seizure4_BipolarMOntage_Combined.set');
data= double(EEG.data);
time= EEG.times;
nCH = EEG.nbchan;


%% To do the filter with FIR and Filtfilt


d1 = designfilt('bandpassfir','FilterOrder',64,'CutoffFrequency1',80,'CutoffFrequency2',500,'SampleRate',2048);



for i=1:nCH
   
Mario4filtered(i,:)= filtfilt(d1,data(i,:));
 
end
%% Cut the filtered data to 8 min before seizure

Mario4filtered_8min=Mario4filtered(:,1:1000000);
Mario4_Filtered_Chname=extractfield(EEG.chanlocs,'labels')';

%% Cut the raw data to 8 min before seizure

Mario3raw_8min=data(:,1:1000000);

