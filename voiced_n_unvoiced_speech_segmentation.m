
clear all;
clc;
[y,fs] = audioread('inputSpeech2.wav');
y = (y-mean(y));
y=y(1:end)/abs(max(y(1:end)));
%plot(y);
f_d = 0.025;
f_size = round(f_d * fs);
n = length(y);
n_f = floor(n/f_size);  %no. of frames
temp = 0;
for i = 1 : n_f
   p(i)=0;
   eframe(i)=0;
   frames(i,:) = y(temp + 1 : temp + f_size);
   temp = temp + f_size;
   x=frames(i,:);
   zcr(i)=(sum(abs(diff(x>0))))/length(x);
   for j=1:f_size;
        eframe(i)=eframe(i)+(abs(frames(i,j)))^2;
   end
 if (zcr(i) < .5 & eframe(i)>1.5)
     p(i*f_size:(i+1)*f_size)=.8;
 end
 if(zcr(i) > .1 & eframe(i)>.1)
     p(i*f_size:(i+1)*f_size)=0;
 end
end
id = find(zcr < .5 & eframe>2); 
fr_ws = frames(id,:);
y_r = reshape(fr_ws',1,[]);
id1 = find(zcr > .1 & eframe>.15); 
fr_ws1 = frames(id1,:);
y_r1 = reshape(fr_ws1',1,[]);
subplot(3,1,2);
plot(y_r);
title('voiced part');
subplot(3,1,1);
plot(y);title('actual speech');
hold on
plot(p);
subplot(3,1,3);
plot(y_r1); title('unvoiced part');
