load('moco.mat')

%calculate derivates of hand motion in three axes
% for i = 1:22
%     S =['sh' num2str(i)];
%     a= [S.RHX,(S).RHY,(S).RHZ];
% end

for k=1:22
x = d.(sprintf('d%d', k));
%disp(k);
len(k,1)= length(x);
end


%plot all rhxderivatives
figure
for k = 1:22
    x = d.(sprintf('d%d',k));
    subplot(22,1,k);
    plot(x(:,2));
    title(k);
end


%plot all rhx motion data
figure
for k = 1:22
    x = sh.(sprintf('sh%d',k));
    subplot(22,1,k);
    plot(x(:,1));
    title(k);
end


%qom sums create
qom = {};
for k = 1:22
    x = sh.(sprintf('sh%d',k));
    for i = 1:length(x)
        qom.(sprintf('qom%d',k))(i,1) = sum(x(i,1:6));
    end
end


%plot of all qoms
figure
for k = 1:22
    p= qom.(sprintf('qom%d',k));
    subplot(22,1,k);
    plot(p(:,1));
    title(k);
end


%for each column, calculate max min from sh1-22
max_sh = {};
min_sh = {};
for k = 1:22
%    t = sh.(sprintf('sh%d',k));
    for j = 1:6
        max_sh.(sprintf('max%d',k))(1,j) = max(sh.(sprintf('sh%d',k))(:,j));
        min_sh.(sprintf('min%d',k))(1,j) = min(sh.(sprintf('sh%d',k))(:,j));
    end
end
    

%for each column in sh, normalize based on max min from above
newSH = {};
for k = 1:22
    newSH.(sprintf('newSH%d',k)) = mat2gray(sh.(sprintf('sh%d',k)));
end


%newqom after normalization
newQoM = {};
for k = 1:22
    x = newSH.(sprintf('newSH%d',k));
    for i = 1:length(x)
        newQoM.(sprintf('newQoM%d',k))(i,1) = sum(x(i,1:6));
    end
end

%normalize new qom
normQoM = {};
for k = 1:22
    normQoM.(sprintf('normQoM%d',k)) = mat2gray(newQoM.(sprintf('newQoM%d',k)));
end



figure
subplot(2,1,1)
plot(newSH.newSH1)
subplot(2,1,2)
plot(newSH.newSH2)
    
%compare normalized qom to before qom
figure
subplot(4,2,1)
plot(newQoM.newQoM1)
subplot(4,2,2)
plot(newQoM.newQoM10)
subplot(4,2,3)
plot(newQoM.newQoM14)
subplot(4,2,4)
plot(newQoM.newQoM15)
subplot(4,2,5)
plot(normQoM.normQoM1)
subplot(4,2,6)
plot(normQoM.normQoM10)
subplot(4,2,7)
plot(normQoM.normQoM14)
subplot(4,2,8)
plot(normQoM.normQoM15)


figure
subplot(5,1,1)
plot(sh1)
subplot(5,1,2)
plot(d.d1)
subplot(5,1,3)
plot(normQoM.normQoM1)
subplot(5,1,4)
plot(newQoM.newQoM1)
subplot(5,1,5)
plot(mat2gray(diff(normQoM.normQoM1)))

%trial
nsumgrad = gradient(nsum)
for i = 1:length(nsumgrad)
if nsumgrad(i,1) < -0.04
nsumgrad(i,1) = -0.04
end
end



%length to 37470
shl = {};
for k = 1:22
    difflength = lengths(k) - 37459;
    shl.(sprintf('shl%d',k)) = sh.(sprintf('sh%d',k))(difflength:end,1:6);
end


%absolval of shl
for k = 1:22
    shl.(sprintf('shl%d',k)) = abs(shl.(sprintf('shl%d',k)));
end



%sliding window analysis
winsize = 1100;
slide_incr = 50;
win = {};
for k = 1:22
    numstps = round((37460-winsize)/slide_incr);
    for j = 1:numstps
        win.(sprintf('win%d',k)).(sprintf('dows%d',j)) = shl.(sprintf('shl%d',k))(j:j+winsize,2);
        win.(sprintf('win%d',k)).(sprintf('sums%d',j)) = sum(win.(sprintf('win%d',k)).(sprintf('dows%d',j))); %only rhy for each shl
    end
end

%corrected sliding window
winsize = 1100;
slide_incr = 10;
win = {};
for k = 1:22
    numstps = round((37460-winsize)/slide_incr);
    l = 1;
    for j = 1:numstps
        win.(sprintf('win%d',k)).(sprintf('dows%d',j)) = shl.(sprintf('shl%d',k))(l:l+winsize,2);
        win.(sprintf('win%d',k)).(sprintf('sums%d',j)) = sum(win.(sprintf('win%d',k)).(sprintf('dows%d',j))); %only rhy for each shl
        l = l+slide_incr;
    end
end


%find top 16 sums in each 22 win.win'k's
sums = {};
indices = {};
maxindex = {};
for k = 1:22
    x = [];
    for j = 1:numstps
        x = [x;win.(sprintf('win%d',k)).(sprintf('sums%d',j))];
    end
[sums.(sprintf('sum%d',k)), indices.(sprintf('ind%d',k))] = sort(x(:),'descend');
maxindex.(sprintf('maxind%d',k)) = indices.(sprintf('ind%d',k))(1:16);
end


% segment windows per 22 people (rhy)
    % in each 22
       
        % select top 32 most far away from each other (sum of rhy)
        
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