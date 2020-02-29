clc;
clear all;
close all;
%y=load('C:\Users\hp\Desktop\biomedical_assignment\aaa.mat');
y=load('C:\Users\hp\Desktop\biomedical_assignment\ooo.mat');
%y=load('C:\Users\hp\Desktop\biomedical_assignment\eee.mat');
c = struct2cell(y);
y = cell2mat(c);
%y=y(1:90000);
for i=1:length(y)-1
    y(i+1)=y(i+1)-.95*y(i);  % pre emphasis
end
figure
plot(y)
title('original signal');
xlabel('sample no')
ylabel('amplitude')
y_f=y(4001:4500);
% for k=1:1000
% y1(k)=sin(2*pi*500*k/4000)+sin(2*pi*100*k/4000);
% end
 figure;
plot(y_f);
title('frame of signal used for finding spectrum');
xlabel('sample no')
ylabel('amplitude')
% y_f=y1;
figure;
w=hamming(500);
y_w=y_f.*w;
a=lpc(y_w,10);
rts = roots(a);
est_y = filter([0 -a(2:end)],1,y_w);
[h,w] = freqz(1,a,500);
count=0;
h1=20*log10(abs(h));
for i=2:length(h)-1
    if(h1(i)>h1(i-1) & h1(i)>h1(i+1))
        count=count+1;
        p(count)=w(i)*360;
        z(count)=h1(i);
    end
end
disp('Formant Frequency(rad/samples)')
Formant_Frequency=p
plot(w/pi,20*log10(abs(h)));
hold on;
y_fft=fft(est_y);
y_fft=y_fft(1:250);
w=w(1:250);
w=2*w;
plot(w/pi,20*log10(abs(y_fft)));
plot(w/pi,20*log10(abs(y_fft)));
title('Comarison of LP spectrum of different order and FFT spectrum');
xlabel('normalised frequency')
ylabel('20 log(abs(response)) in db')
legend('LP spectrum of order 10','FFT spectrum')
y_f=y_f';
y_f=y_f*10;