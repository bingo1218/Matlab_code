%test 2 general ttest
JAMA_LPP = [129 37 55 87 62];
chan = JAMA_LPP;
time = [0.4 1.5];

% find the time points for the effect of interest in the grand average data
timesel_drug = find(meth_drug_grandavg.time >= time(1) & meth_drug_grandavg.time <= time(2));
timesel_neu  = find(meth_neu_grandavg.time >= time(1) & meth_neu_grandavg.time <= time(2));
timesel_pos = find(meth_pos_grandavg.time >= time(1) & meth_pos_grandavg.time <= time(2));
timesel_neg  = find(meth_neg_grandavg.time >= time(1) & meth_neg_grandavg.time <= time(2));

% select the individual subject data from the time points and calculate the mean
for isub = 1:48
    for ichan = 1:length(chan)
    values_drug(isub,ichan) = mean(meth_drug_timelockanalysis_avg{isub}.avg(chan(ichan),timesel_drug));
    values_neu(isub,ichan)  = mean(meth_neu_timelockanalysis_avg{isub}.avg(chan(ichan),timesel_neu));
    values_pos(isub,ichan) = mean(meth_pos_timelockanalysis_avg{isub}.avg(chan(ichan),timesel_pos));
    values_neg(isub,ichan)  = mean(meth_neg_timelockanalysis_avg{isub}.avg(chan(ichan),timesel_neg));
    end
end
values_drug_mean = mean(values_drug,2);
values_neu_mean = mean(values_neu,2);
values_pos_mean = mean(values_pos,2);
values_neg_mean = mean(values_neg,2);
% plot to see the effect in each subject
M = [values_drug_mean(:) values_neu_mean(:)];
figure; plot(M', 'o-'); xlim([0.5 2.5])
legend({'subj1', 'subj2', 'subj3', 'subj4', 'subj5', 'subj6', ...
        'subj7', 'subj8', 'subj9', 'subj10','subj11','subj12',...
        'subj13','subj14','subj15','subj16','subj17','subj18',...
        'subj19','subj20','subj21','subj22','subj23','subj24',...
        'subj25','subj26','subj27','subj28','subj29','subj30',...
        'subj31','subj32','subj33','subj34','subj35','subj36',...
        'subj37','subj38','subj39','subj40','subj41','subj42',...
        'subj43','subj44','subj45','subj46','subj47','subj48'}, 'location', 'EastOutside');
    
    % dependent samples ttest\
stats = [];
drugminneu = values_drug_mean - values_neu_mean;
[h,p,ci,stats] = ttest(drugminneu, 0, 0.05);% H0: mean = 0, alpha 0.05



% select the individual subject data from the time points and calculate the mean
for isub = 1:48
    values_drug_avgchan(isub,[1:length(timesel_drug)]) = mean(meth_drug_timelockanalysis_avg{isub}.avg(chan,timesel_drug));
    values_neu_avgchan(isub,[1:length(timesel_drug)])  = mean(meth_neu_timelockanalysis_avg{isub}.avg(chan,timesel_neu));
    values_pos_avgchan(isub,[1:length(timesel_drug)]) = mean(meth_pos_timelockanalysis_avg{isub}.avg(chan,timesel_pos));
    values_neg_avgchan(isub,[1:length(timesel_drug)])  = mean(meth_neg_timelockanalysis_avg{isub}.avg(chan,timesel_neg));
    [values_drug_max(isub,1),values_drug_max(isub,2)] = max(values_drug_avgchan(isub,:));
    values_drug_max(isub,2) = values_drug_max(isub,2)*2-2+400;
    [values_neu_max(isub,1),values_neu_max(isub,2)] = max(values_neu_avgchan(isub,:));
    values_neu_max(isub,2) = values_neu_max(isub,2)*2-2+400;
    [values_pos_max(isub,1),values_pos_max(isub,2)] = max(values_pos_avgchan(isub,:));
    values_pos_max(isub,2) = values_pos_max(isub,2)*2-2+400;
    [values_neg_max(isub,1),values_neg_max(isub,2)] = max(values_neg_avgchan(isub,:));
    values_neg_max(isub,2) = values_neg_max(isub,2)*2-2+400;
    values_sd(isub,1) = std2(values_drug_avgchan(isub,:));
    values_sd(isub,2) = std2(values_pos_avgchan(isub,:));
    values_sd(isub,3) = std2(values_neg_avgchan(isub,:));
    values_sd(isub,4) = std2(values_neu_avgchan(isub,:));
    end
M_max = [values_drug_max(:,1) values_neu_max(:,1)];
figure; plot(M_max', 'o-'); xlim([0.5 2.5])
legend({'subj1', 'subj2', 'subj3', 'subj4', 'subj5', 'subj6', ...
        'subj7', 'subj8', 'subj9', 'subj10','subj11','subj12',...
        'subj13','subj14','subj15','subj16','subj17','subj18',...
        'subj19','subj20','subj21','subj22','subj23','subj24',...
        'subj25','subj26','subj27','subj28','subj29','subj30',...
        'subj31','subj32','subj33','subj34','subj35','subj36',...
        'subj37','subj38','subj39','subj40','subj41','subj42',...
        'subj43','subj44','subj45','subj46','subj47','subj48',...
        'subj49','subj50','subj51'}, 'location', 'EastOutside');
 
    %% extract sd data
    
