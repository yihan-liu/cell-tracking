clc
clearvars -except imageset

%% READ IN
folder = "2018_11_13_segmentation_data_for_Guorong";
filename = "HL-60_in_collagen_8bit";
format = '.mat';

load(fullfile(folder, strcat(filename, format)));

image = imageset(:, :, 75);
G = BlurredGMS(image, 1.5);
imshow(G, jet);
hold on

%% INITIALIZATION
[h, w] = size(image);
[row, col, s] = ACInit(h, w, 250);

%% ITERATION

w1 = 1;
w2 = 1;
step = 0.05;
threshold = 100;
E = ACEnergy(G, row, col, s, w1, w2);

while (E > threshold)
    
    % Calculate shifted arrays
    rowpp = circshift(row, -2);
    rowp = circshift(row, -1);
    rowm = circshift(row, 1);
    rowmm = circshift(row, 2);
    colpp = circshift(col, -2);
    colp = circshift(col, -1);
    colm = circshift(col, 1);
    colmm = circshift(col, 2);
    Gx = G - circshift(G, 1, 2);
    Gy = G - circshift(G, 1, 1);
    
    d_row_elastic = -2*w1*(rowp - 2*row + rowm);
    d_col_elastic = -2*w1*(colp - 2*col + colm);
    d_row_smooth = 2*w2*(rowpp - 4*rowp + 6*row - 4*rowm + rowmm);
    d_col_smooth = 2*w2*(colpp - 4*colp + 6*col - 4*colm + colmm);
    d_row_external = zeros(length(s), 1);
    d_col_external = zeros(length(s), 1);
    
    for i = 1: length(s)
        d_row_external(i) = Gy(row(i), col(i));
        d_col_external(i) = Gx(row(i), col(i));
    end
    
    d_row = d_row_elastic + d_row_smooth + d_row_external;
    d_col = d_col_elastic + d_col_smooth + d_col_external;
    
    row = round(row - d_row * step);
    col = round(col - d_col * step);
    
    E = ACEnergy(G, row, col, s, w1, w2);
    disp(E);
    
    pl = plot(row, col, 'r-x');
    hold on
    
end


hold off
