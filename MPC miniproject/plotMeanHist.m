function [] = plotMeanHist(intendedEmotion,name)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
hmean = mean(intendedEmotion)
hfearmean = mean(hmean(1:4:16))
hangermean = mean(hmean(2:4:16))
hhappymean = mean(hmean(3:4:16))
hsadmean = mean(hmean(4:4:16))
figure
histogram('Categories', {'Fear','Anger','Happy','Sad'}, 'BinCounts',[hfearmean  hangermean hhappymean hsadmean])
title(name,'FontSize', 16)

ylim([0 6])
end

