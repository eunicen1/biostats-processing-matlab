%%
Fs = 44100;
%signalX = audiorecorder(44100, 16, 1); %Initialization
%"Hello."
%recordblocking(signalX,3); %Saves 3s of recording
%stop(signalX);
%p = play(signalX); %Plays back recording
%signalXdata = getaudiodata(signalX); %Saves
sound(signalXdata, Fs);
%% built-in convolution
[y_1, Fs_1] = audioread('BiomedicalSciences.wav');
[y_2, Fs_2] = audioread('CastilloDeLosTresReyesDelMorroArch.wav');
[y_3, Fs_3] = audioread('NaumburgBandshell.wav');
conv1 = conv(signalXdata, y_1(:,2));
conv2 = conv(signalXdata, y_2(:,2));
conv3 = conv(signalXdata, y_3(:,2));
sound(conv1, (Fs_1+Fs)/2); 
sound(conv2, (Fs_2+Fs)/2);
sound(conv3, (Fs_3+Fs)/2);
plot(linspace(1,3, length(conv1)), conv1);
plot(linspace(1,3, length(conv2)), conv2);
plot(linspace(1,3, length(conv3)), conv3);
title("Three Seconds of Audio Input Convolved with h1, h2, h3");
xlabel('Progression of Time (s)');
ylabel('Audio Signal');
legend('h1', 'h2','h3');

%% hard-coded convolution
H1 = fft(y_1);
H2 = fft(y_2);
H3 = fft(y_3);
X = fft(signalXdata);

C1 = conv(H1(:,2), X);
C2 = conv(H2(:,2), X);
C3 = conv(H3(:,2), X);

c1 = ifft(C1);
c2 = ifft(C2);
c3 = ifft(C3);

plot(linspace(1,3, length(c1)), c1);
plot(linspace(1,3, length(c2)), c2);
plot(linspace(1,3, length(c3)), c3);
title("Three Seconds of Audio Input Convolving the Signal and Impulse FT for c1-3");
xlabel('Progression of Time (s)');
ylabel('Audio Signal');
legend('c1', 'c2','c3');

%%
xx = conv(signalXdata, signalXdata);
plot(linspace(1,3, length(xx)),xx);
title("Three Seconds of Audio Input Convolving the Signal with Itself");
xlabel('Progression of Time (s)');
ylabel('Audio Signal');
sound(xx, Fs);