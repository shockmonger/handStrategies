%Calculate LH RH averages in all three axes
for j = 3:65
    label = varnames(j)
        for i = 1:22
            S =['s' num2str(i)];
            tempArr = vertcat((S).label);
%             results.label = mean(tempArr)
        end
end

%Calculate QoM for Hands
 
for j = 1:65
label = varnames(i)
results.label = {}
end

%Z axis vs rest

stdRHX = zeros(1,1);
stdLHX = zeros(1,1);
stdLHY= zeros(1,1);
stdLHZ= zeros(1,1);
stdRHY= zeros(1,1);
stdRHZ= zeros(1,1);
for i = 1:22
    S = ['s' num2str(i)];
    stdRHX = vertcat(stdRHX, std(data.(S).RHX));
    stdLHX = vertcat(stdLHX, std(data.(S).LHX));
    stdLHY = vertcat(stdLHY, std(data.(S).LHY));
    stdLHZ = vertcat(stdLHZ, std(data.(S).LHZ));
    stdRHY = vertcat(stdRHY, std(data.(S).RHY));
    stdRHZ = vertcat(stdRHZ, std(data.(S).RHZ));
    
end

meanRHZ = mean(stdRHZ)
meanLHZ = mean(stdLHZ)
meanRHY = mean(stdRHY)
meanRHX = mean(stdRHX)
meanLHY = mean(stdLHY)
meanLHX = mean(stdLHX)

%cv of hands in each axis

maxRHX = zeros(1,1);
maxLHX = zeros(1,1);
maxLHY= zeros(1,1);
maxLHZ= zeros(1,1);
maxRHY= zeros(1,1);
maxRHZ= zeros(1,1);

for i = 1:22
    S = ['s' num2str(i)];
    maxRHX = vertcat(maxRHX, max(data.(S).RHX));
    maxLHX = vertcat(maxLHX, max(data.(S).LHX));
    maxLHY = vertcat(maxLHY, max(data.(S).LHY));
    maxLHZ = vertcat(maxLHZ, max(data.(S).LHZ));
    maxRHY = vertcat(maxRHY, max(data.(S).RHY));
    maxRHZ = vertcat(maxRHZ, max(data.(S).RHZ));
    
end

meanRHZ = mean(maxRHZ)
meanLHZ = mean(maxLHZ)
meanRHY = mean(maxRHY)
meanRHX = mean(maxRHX)
meanLHY = mean(maxLHY)
meanLHX = mean(maxLHX)


stdmaxLHX = std(maxLHX)
stdmaxLHY = std(maxLHY)
stdmaxLHZ = std(maxLHZ)
stdmaxRHX = std(maxRHX)
stdmaxRHY = std(maxRHY)
stdmaxRHZ = std(maxRHZ)

ratiorhx = 100*stdmaxRHX/meanRHX
ratiorhy = 100*stdmaxRHY/meanRHY
ratiorhz = 100*stdmaxRHZ/meanRHZ
ratiolhx = 100*stdmaxLHX/meanLHX
ratiolhy = 100*stdmaxLHY/meanLHY
ratiolhz = 100*stdmaxLHZ/meanLHZ


%QoM
vels ={};
for i = 1:22
    S = ['s' num2str(i)];
    V = ['v' num2str(i)];
    vels.(V) = diff(S);
    
end
