% used saved oscillation components to plot fullhead correlation with
% behavior measurements
%should added srate and id in the calculation of foi_ERSP!!!

drift_table = readtable('drift.csv');

%run fullhead oscillation with drift.csv
file_list = dir('flanker_fho/data/combined/');
file_list(1:2)=[];
id_list = cell(1);
for i = 1:length(file_list)
    id_list{i,1} = file_list(i).name(1:4);
end


load('saved_ERSP_ITC/resp_ERSP_alpha.mat');
foi_ERSP = resp_ERSP_alpha;

load('saved_ERSP_ITC/resp_ERSP_theta.mat');
foi_ERSP = resp_ERSP_theta;

load('saved_ERSP_ITC/resp_ERSP_beta.mat');
foi_ERSP = resp_ERSP_beta;

load('saved_ERSP_ITC/resp_ITC_alpha.mat');
foi_ERSP = resp_ITC_alpha;

load('saved_ERSP_ITC/resp_ITC_beta.mat');
foi_ERSP = resp_ITC_beta;

load('saved_ERSP_ITC/resp_ITC_theta.mat');
foi_ERSP = resp_ITC_theta;

load('saved_ERSP_ITC/stim_ERSP_alpha.mat');
foi_ERSP = stim_ERSP_alpha;

load('saved_ERSP_ITC/stim_ERSP_beta.mat');
foi_ERSP = stim_ERSP_beta;

load('saved_ERSP_ITC/stim_ERSP_theta.mat');
foi_ERSP = stim_ERSP_theta;

load('saved_ERSP_ITC/stim_ITC_alpha.mat');
foi_ERSP = stim_ITC_alpha;

load('saved_ERSP_ITC/stim_ITC_beta.mat');
foi_ERSP = stim_ITC_beta;

load('saved_ERSP_ITC/stim_ITC_theta.mat');
foi_ERSP = stim_ITC_theta;

for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end


%EEGAVE2 = FH_convert_foi_ERSP_to_fake_EEGAVE(foi_ERSP,2);
items = 50:50:500;

EEGAVE1 = FH_convert_foi_ERSP_to_fake_EEGAVE(foi_ERSP,1);
corrintable = FH_cal_all_cor(EEGAVE1,drift_table);
for i = 2:4
    for j = 1:3
        FH_plot_cor2(corrintable,items, j,i);
    end
end

%test = readtable('test.csv');