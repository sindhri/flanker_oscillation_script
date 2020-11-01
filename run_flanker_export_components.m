% calculate oscillation components and export values

addpath(genpath('/Users/wu/Documents/MATLAB/work/lib_basic/'));
%EEGLAB:
addpath('/Users/wu/Documents/MATLAB/work/toolbox/eeglab14_0_0b/');
addpath('/Users/wu/Documents/MATLAB/work/toolbox/eeglab14_0_0b/sample_locs');
addpath(genpath('/Users/wu/Documents/MATLAB/work/toolbox/eeglab14_0_0b/functions'));
addpath(genpath('/Users/wu/Documents/MATLAB/work/toolbox/eeglab14_0_0b/plugins'));
%items = 100:200:1500;

items = -100:100:500;
net_type = 1;
group_name = '';
list_selected_conditions = {[1,2], [1,3], [2,3], [4,5]};
for i = 1:length(list_selected_conditions)
    selected_conditions = list_selected_conditions{i};

[foi_ERSP,foi_ITC] = ITC_recompose_to_fullheadmap([4,7],...
    'flanker_fho/data/high/',net_type,items,'high',selected_conditions);

[foi_ERSP_alpha,foi_ITC_alpha] = ITC_recompose_to_fullheadmap([8,12],...
    'flanker_fho/data/high/',net_type,items,'high',selected_conditions);

[foi_ERSP_beta,foi_ITC_beta] = ITC_recompose_to_fullheadmap([13,28],...
    'flanker_fho/data/high/',net_type,items,'high',selected_conditions);


[foi_ERSP,foi_ITC] = ITC_recompose_to_fullheadmap([4,7],...
    'flanker_fho/data/low/',net_type,items,'low',selected_conditions);

[foi_ERSP_alpha,foi_ITC_alpha] = ITC_recompose_to_fullheadmap([8,12],...
    'flanker_fho/data/low/',net_type,items,'low',selected_conditions);

[foi_ERSP_beta,foi_ITC_beta] = ITC_recompose_to_fullheadmap([13,28],...
    'flanker_fho/data/low/',net_type,items,'low',selected_conditions);

end

limit_ERSP = [-1.9,1.9];
limit_ERSP_diff = [-1.6,1.6];
limit_ITC = [0,0.36];
limit_ITC_diff = [-0.17, 0.17];

 selected_conditions =[1,2];
 ITC_recompose_to_fullheadmap([4,7],...
    'flanker_fho/data/high/',net_type,items,'high',selected_conditions,...
limit_ERSP,limit_ERSP_diff, limit_ITC,limit_ITC_diff);
 ITC_recompose_to_fullheadmap([4,7],...
    'flanker_fho/data/low/',net_type,items,'low',selected_conditions,...
limit_ERSP,limit_ERSP_diff, limit_ITC,limit_ITC_diff);


%for machine learning a few subject cases!
%selected_conditions =[1,2];
%[foi_ERSP,foi_ITC] = ITC_recompose_to_fullheadmap([4,7],...
%    'flanker_fho/data/test/',net_type,items,'test',selected_conditions);


%calculate values on the whole group
items = -100:100:500;
net_type = 1;
group_name = '';
path_result = 'flanker_fho/data/combined/';
plot_or_not = 0;

foi_list = {[4, 7], [8, 12], [13, 28]};
foi_names = {'theta','alpha','beta'};
selected_condition_list = {1:3, [4,5]};
selected_condition_namelist = {'resp','stim'};

for i = 1:length(selected_condition_list)
    for j = 1:length(foi_list)
            selected_conditions = selected_condition_list{i};
            selected_condition_name = selected_condition_namelist{i};

            foi = foi_list{j};
            foi_name = foi_names{j};
    
            foi_struct = ITC_fullhead_recompose_individual(foi,path_result,group_name);
            eval(['[' selected_condition_name '_ERSP_' foi_name ',' selected_condition_name '_ITC_' foi_name ']' '= ITC_prepare_data_for_heatmap_individual(foi_struct,net_type,selected_conditions, plot_or_not)']);
%        [resp_ERSP,resp_ITC] = ITC_prepare_data_for_heatmap_individual(foi_struct,...
%        net_type,selected_conditions, plot_or_not);%prepare data for plotting
    end
end

%it's a hack, should fix ITC_fullhead_recompose_individual to add IDs
file_list = dir('flanker_fho/data/combined/');
file_list(1:2)=[];
id_list = cell(1);
for i = 1:length(file_list)
    id_list{i,1} = file_list(i).name(1:4);
end

%resp_ERSP_theta
foi_ERSP = resp_ERSP_theta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

poi(1).channel = [25, 8, 21, 14, 22, 15, 9, 16, 18, 10];
poi(1).name = 'inffrontal';
poi(1).time = [200,500];

poi(2).channel = [129, 7, 6, 106];
poi(2).name = 'central';
poi(2).time = [100,200];

poi(3).channel = [71, 76, 70, 75, 83, 66, 84 ];
poi(3).name = 'posterior';
poi(3).time = [200,500];

T_resp_ERSP_theta = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');

%resp_ERSP_alpha
foi_ERSP = resp_ERSP_alpha;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = [71, 76, 70, 75, 83, 66, 84 ];
poi(1).name = 'posterior';
poi(1).time = [200,500];

T_resp_ERSP_alpha = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');


%resp_ERSP_beta
foi_ERSP = resp_ERSP_beta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = [20, 12, 5, 118, 13, 6, 112, 28, 117, 29, 111];
poi(1).name = 'frontal';
poi(1).time = [200,500];

poi(2).channel = [51, 52, 60, 61, 62, 78, 85, 91, 96];
poi(2).name = 'posterior2';
poi(2).time = [200,500];

T_resp_ERSP_beta = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');

%resp_ITC_theta
foi_ERSP = resp_ITC_theta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = 1:129;
poi(1).name = 'fullhead';
poi(1).time = [0,500];

T_resp_ITC_theta = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');

%resp_ITC_alpha
foi_ERSP = resp_ITC_theta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = 1:129;
poi(1).name = 'fullhead';
poi(1).time = [0,500];

T_resp_ITC_alpha = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');


%resp_ITC_beta
foi_ERSP = resp_ITC_theta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = 1:129;
poi(1).name = 'fullhead';
poi(1).time = [0,500];

T_resp_ITC_beta = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');


%stim_ERSP_theta
foi_ERSP = stim_ERSP_theta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = [129, 7, 6, 106];
poi(1).name = 'central';
poi(1).time = [300,500];

poi(2).channel = [71, 76, 70, 75, 83, 66, 84];
poi(2).name = 'posterior';
poi(2).time = [100,300];

T_stim_ERSP_theta = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');


%stim_ERSP_alpha
foi_ERSP = stim_ERSP_alpha;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = [129, 7, 6, 106];
poi(1).name = 'central';
poi(1).time = [300,500];

poi(2).channel = [52, 59, 60, 63, 66];
poi(2).name = 'Lposterior';
poi(2).time = [300,500];

T_stim_ERSP_alpha = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');

%stim_ERSP_beta
foi_ERSP = stim_ERSP_beta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = [20, 12, 5, 118, 13, 6, 112, 28, 117, 29, 111];
poi(1).name = 'frontal';
poi(1).time = [300,500];

poi(2).channel = [51, 52, 60, 61, 62, 78, 85, 91, 96];
poi(2).name = 'posterior2';
poi(2).time = [300,500];

T_stim_ERSP_beta = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');


%stim_ITC_theta
foi_ERSP = stim_ITC_theta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = [11, 12, 5, 6, 16, 18, 19];
poi(1).name = 'frontal2';
poi(1).time = [100,200];

poi(2).channel = [71, 76, 70, 75, 83, 66, 84];
poi(2).name = 'posterior3';
poi(2).time = [100,300];

T_stim_ITC_theta = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');

%stim_ITC_alpha
foi_ERSP = stim_ITC_alpha;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = [11, 12, 5, 6, 16, 18, 19];
poi(1).name = 'frontal2';
poi(1).time = [200,500];

poi(2).channel = [55, 54, 79, 61, 62, 78];
poi(2).name = 'posterior4';
poi(2).time = [200,500];

T_stim_ITC_alpha = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');

%stim_ITC_theta
foi_ERSP = stim_ITC_beta;
for i = 1:length(foi_ERSP)
    foi_ERSP(i).id = id_list;
end

clear poi;
poi(1).channel = [129, 7, 6, 106];
poi(1).name = 'central';
poi(1).time = [100,200];

poi(2).channel = [71, 76, 70, 75, 83, 66, 84 ];
poi(2).name = 'posterior';
poi(2).time = [200,400];

T_stim_ITC_beta = ITC_fullhead_create_doi_from_foi_fho_multiple(foi_ERSP,...
    poi,'export.txt');

%combine tables
T_out = join(T_resp_ERSP_theta, T_resp_ERSP_alpha);
T_out = join(T_out, T_resp_ERSP_beta);
T_out = join(T_out, T_stim_ERSP_theta);
T_out = join(T_out, T_stim_ERSP_alpha);
T_out = join(T_out, T_stim_ERSP_beta);
T_out = join(T_out, T_resp_ITC_theta);
T_out = join(T_out, T_resp_ITC_alpha);
T_out = join(T_out, T_resp_ITC_beta);
T_out = join(T_out, T_stim_ITC_theta);
T_out = join(T_out, T_stim_ITC_alpha);
T_out = join(T_out, T_stim_ITC_beta);
writetable(T_out,'export_all','delimiter','\t');