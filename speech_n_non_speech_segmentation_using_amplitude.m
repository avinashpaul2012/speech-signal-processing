clear all;
clc;
[y,fs] = audioread('inputSpeech1.wav');
y = (y-mean(y));
y=y(1:end)/abs(max(y(1:end)));
%plot(y);
f_d = 0.001;
f_size = round(f_d * fs);
n = length(y);
n_f = floor(n/f_size);  %no. of frames
temp = 0;
for i = 1 : n_f
   p(i)=0;
   eframe(i)=0;
   frames(i,:) = y(temp + 1 : temp + f_size);
   temp = temp + f_size;
   for j=1:f_size;
        eframe(i)=eframe(i)+(abs(frames(i,j)))^2;
   end
   if (eframe(i)>.1 && eframe(i)<.3)
       p(i)=1;
   end 
   if(eframe(i)>.3)
       p(i)=2;
   end
end

id = find(p==1); 
id1=find(p==2);
fr_ws = frames(id,:);
y_r = reshape(fr_ws',1,[]);
fr_ws1 = frames(id1,:);
y_r1 = reshape(fr_ws1',1,[]);
% subplot(3,1,1);
% stem(eframe);

subplot(3,1,1);
plot(y);title('actual speech');
subplot(3,1,2);
plot(y_r); title(' silence part');
subplot(3,1,3);
plot(y_r1); title(' speech part');