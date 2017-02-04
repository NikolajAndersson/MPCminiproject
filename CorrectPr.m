function [ procent] = CorrectPr( rating )
%Calcuate the procentage of correctly guessed
%   To count as a correct answer, the intended emotion must be rated higher
happypr = 0; sadpr = 0; angrypr = 0; fearpr = 0;
happyQ = [1, 4, 15, 14];
angryQ = [9, 16, 2, 11];
fearQ = [5, 12, 10, 3];
sadQ = [13, 8, 7, 6];
happyIntended = [];
sadIntended = [];
fearIntended = [];
angryIntended = [];


CorrectHappy = 0; CorrectSad = 0; CorrectFear = 0; CorrectAngry = 0;
falseHappy = 0;falseSad = 0;falseFear = 0; falseAngry = 0;
for i = 1:4
    happyIntended = [happyIntended, rating(:,happyQ(i)*4-3:happyQ(i)*4)];
    sadIntended = [sadIntended, rating(:,sadQ(i)*4-3:sadQ(i)*4)];
    fearIntended = [fearIntended, rating(:,fearQ(i)*4-3:fearQ(i)*4)];
    angryIntended = [angryIntended, rating(:,angryQ(i)*4-3:angryQ(i)*4)];
    
    % fear
    for j = 1:size(rating,1)
        rate = fearIntended(j,i*4-3:i*4);
        highest = max(rate);
        if max(rate) ~= rate(1)
            %disp('false')
            falseFear = falseFear + 1;
            %break; % not rated highest on happiness
        else
            count = 0;
            for h = 1:4
                if rate(h) == highest
                    %disp(h);
                    count = count + 1;
                end
            end
            if count == 1 && rate(1) == highest
                % Yaaay correct answer
                CorrectFear = CorrectFear + 1;
            else
                %wrong
                falseFear = falseFear + 1;
            end
        end
    end
    
    % Angry
    for j = 1:size(rating,1)
        rate = angryIntended(j,i*4-3:i*4);
        highest = max(rate);
        if max(rate) ~= rate(2)
            %disp('false')
            falseAngry = falseAngry + 1;
            %break; % not rated highest on happiness
        else
            count = 0;
            for h = 1:4
                if rate(h) == highest
                    %disp(h);
                    count = count + 1;
                end
            end
            if count == 1 && rate(2) == highest
                % Yaaay correct answer
                CorrectAngry = CorrectAngry+ 1;
            else
                %wrong
                falseAngry = falseAngry + 1;
            end
        end
    end
    
    % happy
    for j = 1:size(rating,1)
        rate = happyIntended(j,i*4-3:i*4);
        highest = max(rate);
        if max(rate) ~= rate(3)
            %disp('false')
            falseHappy = falseHappy + 1;
            %break; % not rated highest on happiness
        else
            count = 0;
            for h = 1:4
                if rate(h) == highest
                   % disp(h);
                    count = count + 1;
                end
            end
            if count == 1 && rate(3) == highest
                % Yaaay correct answer
                CorrectHappy = CorrectHappy + 1;
            else
                %wrong
                falseHappy = falseHappy + 1;
            end
        end
    end
    
    % sad
    for j = 1:size(rating,1)
        rate = sadIntended(j,i*4-3:i*4);
        highest = max(rate);
        if max(rate) ~= rate(4)
           % disp('false')
            falseSad = falseSad + 1;
            %break; % not rated highest on happiness
        else
            count = 0;
            for h = 1:4
                if rate(h) == highest
                    %disp(h);
                    count = count + 1;
                end
            end
            if count == 1 && rate(4) == highest
                % Yaaay correct answer
                CorrectSad = CorrectSad + 1;
            else
                %wrong
                falseSad = falseSad + 1;
            end
        end
    end
    
end
total = 4 * size(happyIntended,1);
if falseHappy + CorrectHappy ~= total ...
        || falseFear + CorrectFear ~=total ...
        || falseSad + CorrectSad ~=total...
        || falseAngry + CorrectAngry ~= total
    disp('Somethings wrong')
end
%falseHappy + CorrectHappy

happypr = CorrectHappy/total;
sadpr = CorrectSad/total;
fearpr = CorrectFear/total;
angrypr = CorrectAngry/total;
procent = [happypr; sadpr; angrypr; fearpr] * 100;
end

