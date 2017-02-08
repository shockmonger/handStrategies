k = 
figure
subplot(4,1,1)
plot(peaks.peak13)
subplot(4,1,2)
plot(locs.loc13)
subplot(4,1,3)
plot(w.w13)
subplot(4,1,4)
plot(p.p13)


figure
subplot(4,1,1)
plot(peaks2.peak13)
subplot(4,1,2)
plot(locs2.loc13)
subplot(4,1,3)
plot(w2.w13)
subplot(4,1,4)
plot(p2.p13)

figure
for k = 1:6
subplot(6,1,k)
stem(fnorm.(sprintf('f%d',k)))
end