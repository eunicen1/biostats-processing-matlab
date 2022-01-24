% help audiorecorder
% lab1.mat
%%
Fs = 44100;
%recObj = audiorecorder(44100, 16, 1); %Initialization
%"Hello."
%recordblocking(recObj,3); %Saves 3s of recording
%stop(recObj);
%p = play(recObj); %Plays back recording
%myRecording = getaudiodata(recObj); %Saves your audio as a double precision array
plot(linspace(0,3,length(myRecording)),myRecording); %Plots your recording
%sound(myRecording, Fs);
title('Three Seconds of Audio Input in Time Domain for Relatively Low and High Fs'); %The title of graph
xlabel('Progression of Time (s)');
ylabel('Audio Signal');
%recLow=audiorecorder(1000,16,1);
%"Hello."
%recordblocking(recLow, 3);
%stop(recLow);
p=play(recLow);
%myRecLow = getaudiodata(recLow);
hold on;
plot(linspace(0,3,length(myRecLow)), myRecLow);
legend(["44.1kHz", "1kHz"]);
%%
L = length(myRecording);
FastFourierTransform = fft(myRecording);
plot((0:L-1)*(Fs/L),FastFourierTransform,'c','LineWidth',3); 
title('Power / Amplitude Spectrum of Audio Signal at 44.1kHz');
xlabel('Frequency (hz)');
ylabel('Power / Amplitude');
hold on;
plot((0:L-1)*(Fs/L),real(FastFourierTransform), 'm','LineWidth',1); 
title('Power / Amplitude Spectrum of Audio Signal at 44.1kHz Re');
xlabel('Frequency (hz)');
ylabel('Power / Amplitude (Real)');

plot((0:L-1)*(Fs/L),imag(FastFourierTransform), 'b','LineWidth',1);
title('Power / Amplitude Spectrum of Audio Signal at 44.1kHz Separated (Re, Im)');
xlabel('Frequency (hz)');
ylabel('Power / Amplitude');
legend('P', 'Real(P)', 'Im(P)');

%%
myNoise = awgn(myRecording,30);
sound(myNoise, Fs); 
plot(linspace(0,3,length(myNoise)), myNoise);
title('Three Seconds of Noisy Audio Input in Time Domain'); %The title of graph
xlabel('Progression of Time (s)');
ylabel('Audio Signal');
%%
L = length(myNoise);
noiseFreq = fft(myNoise);
plot((0:L-1)*(Fs/L), real(noiseFreq));
title('Real Part of Power / Amplitude Spectrum of Noisy Audio Signal at 44.1kHz');
xlabel('Frequency (hz)');
ylabel('Power / Amplitude');
%FIR Finite Impulse Response
%% 
Fp = 0.33;
Fst = 1; 
Ap = 1;
Ast = 95;
lpFilt=designfilt('lowpassfir', 'PassbandFrequency', Fp, 'StopbandFrequency', Fst, 'PassbandRipple', Ap, 'StopbandAttenuation', Ast);
fvtool(lpFilt);
filteredNoise = filter(lpFilt, noiseFreq);
%%
filteredFreq = ifft(filteredNoise);
realComp=real(filteredFreq);
plot(linspace(0,3,length(realComp)), realComp); 

plot(linspace(0,3,length(myRecording)), myNoise);
hold on;
plot(linspace(0,3,length(myRecording)), realComp);
plot(linspace(0,3,length(myRecording)), myRecording);
title('Plot of Original Signal, Noisy Signal, and Filtered Signal at 44.1kHz');
xlabel('Progression of Time (s)');
ylabel('Audio Signal');
legend('Noisy', 'Filtered','Original');

