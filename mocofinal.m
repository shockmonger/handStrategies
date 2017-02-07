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

       
        % select top 32 most far away from each other (sum of rhy)
temparray = [];
for k = 1:22
    
        
        % find indices for top 32 most far away from each other
    
    % send from indices of all top 704 to arrays select1:704 (6 col vector)

    
% initialize f.f1-f6 feature vectors for each of the 6 sets of features

    % calculate 6x<704x1> vector for f1-f6, f1-f6 are arrays, f is structure

        % calculate means for each array for f.f1-f6 (end up with 6 means)

        % calculate sd for each row for f.f1-f6 (end up with  6 sds)
        
        % plot f.f1-f6 (plots of means)

        
% decide thresholds
    
% s.s1-s6 struct.array for means from 1-6 for 704 rows depending on thresholds
    
    % means of s1-s6
    
    % sds of s1-s6