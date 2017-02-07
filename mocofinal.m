load('mocofinal.mat');


%compute qom for shl
qom = {};
for k = 1:22
    for j = 1:37461
        for l = 1:6
            counter = 0;
            counter = counter + (shl.(sprintf('shl%d',k))(j,l));
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


%peak windows
peakwins = {};
for k = 1:22
   x = length(peaks.(sprintf('peak%d',k)));
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

    
% initialize f.f1-f6 feature vectors for each of the 6 sets of features
f = {};
    % calculate 6x<704x1> vector for f1-f6, f1-f6 are arrays, f is structure

        % calculate means for each array for f.f1-f6 (end up with 6 means)

        % calculate sd for each row for f.f1-f6 (end up with  6 sds)
        
        % plot f.f1-f6 (plots of means)

        
% decide thresholds
    
% s.s1-s6 struct.array for means from 1-6 for 704 rows depending on thresholds
s = {};    
    % means of s1-s6
    
    % sds of 
    s1-s6