load('mocofinal.mat');


%compute qom for shl
qom = {};
for k = 1:22
    for j = 1:37461
        for l = 1:6
            counter = 0;
            counter = counter + (shl.(sprintf('shl%d',k))(j,l)).^2;
        end
        sqcount = sqrt(counter);
        qom.(sprintf('qom%d',k))(j,1) = sqcount;
    end
end

% segment windows per 22 people (qom)
% in each 22
    
winsize = 1100;
slide_incr = 10;
win = {};
for k = 1:22
    numstps = round((37461-winsize)/slide_incr);
    l = 1;
    for j = 1:numstps
        win.(sprintf('win%d',k)).(sprintf('dows%d',j)) = qom.(sprintf('qom%d',k))(l:l+winsize,1);
        win.(sprintf('win%d',k)).(sprintf('sums%d',j)) = sum(win.(sprintf('win%d',k)).(sprintf('dows%d',j)));
        win.(sprintf('win%d',k)).(sprintf('mean%d',j)) = mean(win.(sprintf('win%d',k)).(sprintf('dows%d',j)));
        win.(sprintf('win%d',k)).(sprintf('std%d',j)) = std(win.(sprintf('win%d',k)).(sprintf('dows%d',j)));
        l = l+slide_incr;
    end
end

%separate into arrays for sums, means, sds
for k = 1:22
    for j = 1:3636
        sums.(sprintf('sum%d',k))(j,1) = win.(sprintf('win%d',k)).(sprintf('sums%d',j));
        stds.(sprintf('std%d',k))(j,1) = win.(sprintf('win%d',k)).(sprintf('std%d',j));
        means.(sprintf('mean%d',k))(j,1) = win.(sprintf('win%d',k)).(sprintf('mean%d',j));
    end
end
       
%find peaks per 22 from sums of qom data
peaks = {};
locs = {};
w = {};
p = {};
for k = 1:22
    [peaks.(sprintf('peak%d',k)), locs.(sprintf('loc%d',k)), w.(sprintf('w%d',k)), p.(sprintf('p%d',k))] = findpeaks(sums.(sprintf('sum%d',k)));
end


%peaks of peaks to reduce total number of peaks
peaks2 = {};
locs2 = {};
w2 = {};
p2 = {};
for k = 1:22
    [peaks2.(sprintf('peak%d',k)), locs2.(sprintf('loc%d',k)), w2.(sprintf('w%d',k)), p2.(sprintf('p%d',k))] = findpeaks(peaks.(sprintf('peak%d',k)));
end


%%%%%%on a better day, instead of doing this, calculate qom for all
%%%%%%<peaks,loc,w,p> cluster in a better way and then decide on the final
%%%%%%peakwins

%peak windows
peakwins = {};
for k = 1:22
   x = length(peaks2.(sprintf('peak%d',k)));
   for j = 1:x
       numstpID = locs.(sprintf('loc%d',k));
       pointer = numstpID*slide_incr;
       point = pointer(j,1);
       for i = 1:winsize;
            for l = 1:6
               peakwins.(sprintf('peakwin%d',k)).(sprintf('sel%d',j))(i,l) = shl.(sprintf('shl%d',k))(i+point,l);    
            end
       end
    end
end


%allwindows
allwins.win0 = {};
for k = 1:22
    x = length(fieldnames(peakwins.(sprintf('peakwin%d',k))));
    for j = 1:x
        l = length(fieldnames(allwins));
        allwins.(sprintf('win%d',l+1)) = peakwins.(sprintf('peakwin%d',k)).(sprintf('sel%d',x));
    end
end


%qom of all windows
qomall = {};
for k = 2:length(fieldnames(allwins));
    for j = 1:1100
        for l = 1:6
            counter = 0;
            counter = counter + (allwins.(sprintf('win%d',k))(j,l)).^2;
        end
        sqcount = sqrt(counter);
        qomall.(sprintf('qom%d',k))(j,1) = sqcount;
    end
end

    
% initialize f.f1-f6 feature vectors for each of the 6 sets of features
f = {};
feature = [];
f.f1 = [];
%f1
counter = 0;
for k = 2:length(fieldnames(qomall));
    for j = 1:1100
        feature = [feature; allwins.(sprintf('win%d',k))(j,2)-allwins.(sprintf('win%d',k))(j,5)];
    end
    meanfeature = mean(feature);
    f.f1 = [f.f1; meanfeature];
end

%f2
feature = [];
f.f2 = [];
for k = 2:length(fieldnames(qomall));
    for j = 1:1100
        feature = [feature; abs(allwins.(sprintf('win%d',k))(j,4))-abs(allwins.(sprintf('win%d',k))(j,1))];
    end
    meanfeature = mean(feature);
    f.f2 = [f.f2; meanfeature];
end

%f3
feature = [];
f.f3 = [];
for k = 2:length(fieldnames(qomall));
    for j = 1:1100
        feature = [feature; allwins.(sprintf('win%d',k))(j,1)-transpose(allwins.(sprintf('win%d',k))(j,4))];
    end
    meanfeature = mean(feature);
    f.f3 = [f.f3; meanfeature];
end

%f4
feature = [];
f.f4 = [];
for k = 2:length(fieldnames(qomall));
    for j = 1:1100
        sumrh = abs(allwins.(sprintf('win%d',k))(j,1))+ abs(allwins.(sprintf('win%d',k))(j,2))+abs(allwins.(sprintf('win%d',k))(j,3));
        sumlh = abs(allwins.(sprintf('win%d',k))(j,4))+ abs(allwins.(sprintf('win%d',k))(j,5))+abs(allwins.(sprintf('win%d',k))(j,6));
        qomrh = sqrt(sumrh^2);
        qomlh = sqrt(sumlh^2);
        feature = [feature; qomrh-qomlh];
    end
    meanfeature = mean(feature);
    f.f4 = [f.f4; meanfeature];
end

%f5
feature = [];
f.f5 = [];
for k = 2:length(fieldnames(qomall));
    for j = 1:1100
        x = allwins.(sprintf('win%d',k))(j,1);
        y = allwins.(sprintf('win%d',k))(j,2);
        z = allwins.(sprintf('win%d',k))(j,3);
        feature = [feature; x.^2+y.^2+z.^2];
    end
    meanfeature = mean(feature);
    f.f5 = [f.f5; meanfeature];
end


%f6
feature = [];
f.f6 = [];
for k = 2:length(fieldnames(qomall));
    for j = 1:1100
        feature = [feature; dtw(allwins.(sprintf('win%d',k))(j,2),allwins.(sprintf('win%d',k))(j,5))];
    end
    meanfeature = mean(feature);
    disp(meanfeature);
    f.f6 = [f.f6; meanfeature];
end




% calculate means, sd for each array for f.f1-f6 (end up with 6 means)
m = [];
for n = 1:6
    m(n,1) = mean(f.(sprintf('f%d',n)));
    m(n,2) = std(f.(sprintf('f%d',n)));
end


% plot f.f1-f6 (plots of means)
figure


        
% decide thresholds
s = {};    
l = 0;
for k = 2:length(f.f1)
    if -40 < f1(k,1) < 20 
        s.s1.(sprintf('s%d',l+1)) = allwins.(sprintf('win%d',k));
        l = l+1;  
    end
end

for k = 2:length(f.f1)
    if 
        s.s2.(sprintf('s%d',l+1)) = allwins.(sprintf('win%d',k));
        l = l+1;  
    end
end

for k = 2:length(f.f1)
    if 
    s.s3.(sprintf('s%d',l+1)) = allwins.(sprintf('win%d',k));
        l = l+1;  
    end
end

for k = 2:length(f.f1)
    if 
    s.s4.(sprintf('s%d',l+1)) = allwins.(sprintf('win%d',k));
    l = l+1;  
    end
end

for k = 2:length(f.f1)
    if
        s.s5.(sprintf('s%d',l+1)) = allwins.(sprintf('win%d',k));
        l = l+1;  
    end
end

for k = 2:length(f.f1)
    if
        s.s6.(sprintf('s%d',l+1)) = allwins.(sprintf('win%d',k));
        l = l+1;
    end
end



m2 = [];
for n = 1:6
    m(n,1) = mean(s.(sprintf('s%d',n)));
    m(n,2) = std(s.(sprintf('s%d',n))); 
end


% s1-s6