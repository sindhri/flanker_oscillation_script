% plot the participants as a whole group
% ERSP for response (cong/incong) and ERSP for stim (cong/incong)
% frontal and posterior
% theta and alpha
% First: time-frequency of each cluster (cluster was chosen from the last
% iteration)

% from observations of fullhead oscillation plots, only include frontal and
% posterior, only limit to theta and alpha:
% theta inferior frontal [25, 8, 21, 14, 22, 15, 9, 16, 18, 10], resp
% 200-500 ms
% theta posterior: [71, 76, 70, 75, 83, 66, 84], resp 200-500 ms, and stim
% 100-300 ms
% alpha posterior: [71, 76, 70, 75, 83, 66, 84], resp 200-500 ms
% alpha left posterior: [52, 59, 60, 63, 66], stim 300-500 ms

% fullhead oscillation parameters
%baseline = 700;
% category_names = {'ERN','resp_congruent','resp_incongruent',...
%    'stim_congruent','stim_incongruent'};
% vbaseline = [-100,0];
% target_srate = 1000;
% id_type = 1;
% freq_limits = [3,30];

% fullhead of each time chosen from the time-frequency plots

addpath(genpath('/Users/wu/Documents/MATLAB/work/lib_basic/'));
%EEGLAB:
addpath('/Users/wu/Documents/MATLAB/work/toolbox/eeglab14_0_0b/');
addpath('/Users/wu/Documents/MATLAB/work/toolbox/eeglab14_0_0b/sample_locs');
addpath(genpath('/Users/wu/Documents/MATLAB/work/toolbox/eeglab14_0_0b/functions'));
addpath(genpath('/Users/wu/Documents/MATLAB/work/toolbox/eeglab14_0_0b/plugins'));

coi(1).channel = [25, 8, 21, 14, 22, 15, 9, 16, 18, 10];
coi(1).name = 'inferior_frontal';

coi(2).channel = [71, 76, 70, 75, 83, 66, 84];
coi(2).name = 'posterior';

%coi(3).channel = [52, 59, 60, 63, 66];
%coi(3).name = 'left_posterior';

id_type = 1;
oscillation_type = 'ERSP';
condition_of_interest = {[3,2],[5,4]};
pathname = 'flanker_fho/data/combined';
group_name = '';
for i = 1:length(coi)
    coi_struct = ITC_fullhead_recompose_one_cluster(coi(i),id_type, pathname, group_name);
        for j= 1:length(condition_of_interest)

            tfplot = ITC_images_for_2cond_coi(coi_struct, oscillation_type,...
            condition_of_interest{j});
        end
end


