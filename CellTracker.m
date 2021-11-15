clc;
clearvars -except imageset;

folder = "2018_11_13_segmentation_data_for_Guorong";
filename = "HL-60_in_collagen_8bit";
format = '.mat';

load(fullfile(folder, strcat(filename, format)));

control_points = 1000;

% for i = 1: size(imageset, 3)
%     
%    [row, col] = ACTracker(images(:, :, i), control_points);
%     
% end