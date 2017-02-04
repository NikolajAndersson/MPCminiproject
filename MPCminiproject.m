clear; clc; close all;
fid = fopen('DataMPC.txt')
categori = textscan(fid,'%s',67)
data = textscan(fid,['%f %s %s',repmat('%f',[1,64])])
fclose(fid);

age = data{1}
sex = strcmp(data{2},'Male')
musician = strcmp(data{3},'Yes')
%%

angryID = [];fearID = [];happyID = []; sadID = [];
for i = 1:64
    if mod(i, 4) == 1
        fearID = [fearID, i]
    end
    if mod(i, 4) == 2
       angryID = [angryID, i]; 
    end
    if mod(i, 4) == 3
        happyID = [happyID, i];
    end
    if mod(i, 4) == 0
       sadID = [sadID, i]
    end
end
angryID = angryID + 3;
fearID = fearID + 3;
happyID = happyID + 3; 
sadID = sadID + 3;

%%
% 1: BE happy Question 1
% 2: BE angry Question 9
% 3: BE fear  Question 5
% 4: BE sad   Question 13
% 5: BR happy Question 4
% 6: BR angry Question 16
% 7: BR fear  Question 12
% 8: BR sad   Question 8
% 9: HA happy Question 15
% 10: HA angryQuestion 2
% 11: HA fear Question 10
% 12: HA sad  Question 7
% 13: MO happyQuestion 14
% 14: MO angryQuestion 11
% 15: MO fear Question 3
% 16: MO sad  Question 6

happyQ = [1, 4, 15, 14];
angryQ = [9, 16, 2, 11];
fearQ = [5, 12, 10, 3];
sadQ = [13, 8, 7, 6];
qOrder = [1, 10, 15, 5, 3, 16, 12, 8, 2, 11, 14, 7, 4, 13, 9, 6];
rating = [];
for i = 4:67
    rating = [rating, data{i}];
end
%%

%happyBE = rating(:,1:4)
happyIntended = [];
sadIntended = [];
fearIntended = [];
angryIntended = [];
h = []; a = []; s = []; 
f = [];
% Sorting all same intended emotions across music into variables
for i = 1:4
    h = [h, happyQ(i)*4-3:happyQ(i)*4]
    s = [s, sadQ(i)*4-3:sadQ(i)*4]
    f = [f, fearQ(i)*4-3:fearQ(i)*4]
    a = [a, angryQ(i)*4-3:angryQ(i)*4]
    happyIntended = [happyIntended, rating(:,happyQ(i)*4-3:happyQ(i)*4)]
    sadIntended = [sadIntended, rating(:,sadQ(i)*4-3:sadQ(i)*4)]
    fearIntended = [fearIntended, rating(:,fearQ(i)*4-3:fearQ(i)*4)]
    angryIntended = [angryIntended, rating(:,angryQ(i)*4-3:angryQ(i)*4)]   
end
%happyIntended(:,happyQ(1):happyQ(1)+3) % all emotions
%%
%mean(happyIntended)
figure
plot(mean(happyIntended))
hold on;
plot(mean(sadIntended))
plot(mean(fearIntended))
plot(mean(angryIntended))
set(gca,'XTick',1:16,'XTickLabel',{'Fear','Angry','Happy','Sad'})
legend('Happy Intended','Sad Intended','Fear Intended','Angry Intended')
%% 
% plot happy Intended
%figure
hmean = mean(fearIntended);
hfearmean = mean(hmean(1:4:16))
hangermean = mean(hmean(2:4:16))
hhappymean = mean(hmean(3:4:16))
hsadmean = mean(hmean(4:4:16))
%histogram('Categories', {'Fear','Anger','Happy','Sad'}, 'BinCounts',[hfearmean  hangermean hhappymean hsadmean])
%%
% histograms of Intended emotions
plotMeanHist(happyIntended,'Happy Intention')
plotMeanHist(sadIntended,'Sad Intention')
plotMeanHist(fearIntended,'Fear Intention')
plotMeanHist(angryIntended,'Angry Intention')

%%

ageMean = mean(age)
ageSTD = std(age)
MaleTestSubjects = sum(sex)
Musicians = sum(musician)

%% 
% testing the function
asdasd = Achievement([0 1 0 0],[6 6 5 5])
%corr([0 0 1 0]',[1 0 0 0]')
%%
%[F A H S] = [0 1 0 0],
happyBE = []; happyBR = []; happyHA = []; happyMO = [];
angryBE = []; angryBR = []; angryHA = []; angryMO = [];
fearBE = []; fearBR = []; fearHA = []; fearMO = [];
sadBE = []; sadBR = []; sadHA = []; sadMO = []; 
% Composer features
BE = [1:4];
BR = [5:8];
HA = [9:12];
MO = [13:16];
% Calculate Achievement for all emotions and composers
for i = 1:size(happyIntended,1)
    
    fearBE(:,i) = Achievement([1 0 0 0],fearIntended(i,BE));
    fearBR(:,i) = Achievement([1 0 0 0],fearIntended(i,BR));
    fearHA(:,i) = Achievement([1 0 0 0],fearIntended(i,HA));
    fearMO(:,i) = Achievement([1 0 0 0],fearIntended(i,MO));
    
    angryBE(:,i) = Achievement([0 1 0 0],angryIntended(i,BE));
    angryBR(:,i) = Achievement([0 1 0 0],angryIntended(i,BR));
    angryHA(:,i) = Achievement([0 1 0 0],angryIntended(i,HA));
    angryMO(:,i) = Achievement([0 1 0 0],angryIntended(i,MO));
    
    happyBE(:,i) = Achievement([0 0 1 0],happyIntended(i,BE));
    happyBR(:,i) = Achievement([0 0 1 0],happyIntended(i,BR));
    happyHA(:,i) = Achievement([0 0 1 0],happyIntended(i,HA));
    happyMO(:,i) = Achievement([0 0 1 0],happyIntended(i,MO));
    
    sadBE(:,i) = Achievement([0 0 0 1],sadIntended(i,BE));
    sadBR(:,i) = Achievement([0 0 0 1],sadIntended(i,BR));
    sadHA(:,i) = Achievement([0 0 0 1],sadIntended(i,HA));
    sadMO(:,i) = Achievement([0 0 0 1],sadIntended(i,MO));  
end
%% 
% Table with results
meanResults = [mean(happyBE) mean(happyBR) mean(happyHA) mean(happyMO); ...
    mean(sadBE) mean(sadBR) mean(sadHA) mean(sadMO); ...
    mean(angryBE) mean(angryBR) mean(angryHA) mean(angryMO);...
    mean(fearBE) mean(fearBR) mean(fearHA) mean(fearMO)];
Berwald = round([meanResults(:,1); mean(meanResults(:,1)) ],2);
Brahms = round([meanResults(:,2); mean(meanResults(:,2)) ],2);
Haydn = round([meanResults(:,3); mean(meanResults(:,3)) ],2);
Mozart = round([meanResults(:,4); mean(meanResults(:,4))],2);
M = round([mean(meanResults,2); 0],2);
roworder = {'Happiness'; 'Sadness';'Anger';'Fear'; 'M'}
table(Berwald, Brahms, Haydn, Mozart, M, 'RowNames', roworder)

%% 
CorrectPr(rating)
%%
Correct_Answer = round(CorrectPr(rating))%[happyprocent; sadprocent; angryprocent; fearprocent]; 
pM = round(mean(Correct_Answer),2)
Correct_Answer = [Correct_Answer; pM]
table(Correct_Answer, 'RowNames', roworder)
%% What needs to be done? 
% Other measures: r, E ? 
r = corr([0 0 1 0]', [5 3 6 2]') % intended emotion corr rated
E = 6/sum([5 3 6 2]) % rated intended emotion / rated emotions
% t-test and ANOVA
% Can't be done, no other test group