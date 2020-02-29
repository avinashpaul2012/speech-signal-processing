clear all;
clc;
[y,fs] = audioread('inputSpeech3.wav');
y = (y-mean(y));
y=y(1:end)/abs(max(y(1:end)));
y1=y(30000:40000);
subplot(3,1,1);
plot(y);title('actual speech');
grid on;
grid minor;
 subplot(3,1,2);
 plot(y1); title('finding pitch');
 grid on;
grid minor;
ac=xcorr(y1,y1);
subplot(3,1,3);
plot(ac); title('autocorrelation');
pf=32000/260
