function [row, col, s] = ACInit(h, w, n)
% ACTIVECONTOURINIT Initialize the contour
% Input
%   h: height of the image
%   w: width of the image
%   n: number of control point
% Return
%   row: row number of the initialized control points
%   col: column number of the initialized control points

row = zeros(n, 1);
col = zeros(n, 1);
s = linspace(0, 1-1/n, n);

rad = 50;
offset = 5;

h_red = h - 2*offset - 2*rad;
w_red = w - 2*offset - 2*rad;
dia = 2*rad;

len = h_red*2 + w_red*2 + pi*dia;
h_ratio = h_red/len; % height ratio in perimeter
w_ratio = w_red/len; % width ratio in perimeter
r_ratio = (1/4)*pi*dia/len; % rounded corner ratio in perimeter
step = len/n;

r_num = floor(n*r_ratio); % number of control point on rounded corner
h_num = floor(n*h_ratio); % number of control point on height
w_num = floor(n*w_ratio); % number of control point on weight

coeff = transpose([1, 1, 1, 1, 2, 2, 2, 2;
        0, 0, 1, 1, 1, 1, 2, 2;
        0, 1, 1, 2, 2, 3, 3, 4]);
segments = coeff*[w_num; h_num; r_num];

for i = 1: n
    
    if i <= segments(1) % top border
        row(i) = floor(offset);
        col(i) = floor(offset + rad + step*i);
    elseif i <= segments(2) % topright corner
        row(i) = row(segments(1)) + ...
            floor(rad * (1 - cos((i-segments(1))*step/rad)));
        col(i) = col(segments(1)) + ... 
            floor(rad * sin((i-segments(1))*step/rad));
    elseif i <= segments(3) % right border
        row(i) = floor(offset + rad + (i-segments(2))*step);
        col(i) = floor(w - offset);
    elseif i <= segments(4) % bottomright corner
        row(i) = row(segments(3)) + ...
            floor(rad * sin((i-segments(3))*step/rad));
        col(i) = col(segments(3)) - ...
            floor(rad * (1 - cos((i-segments(3))*step/rad)));
    elseif i <= segments(5) % bottom border
        row(i) = floor(h - offset);
        col(i) = floor(w - offset - rad - (i-segments(4))*step);
    elseif i <= segments(6) % bottomleft corner
        row(i) = row(segments(5)) - ...
            floor(rad * (1 - cos((i-segments(5))*step/rad)));
        col(i) = col(segments(5)) - ...
            floor(rad * sin((i-segments(5))*step/rad));
    elseif i <= segments(7) % left border
        row(i) = floor(h - offset - rad - (i-segments(6))*step);
        col(i) = floor(offset);
    elseif i <= segments(8) % topleft corner
        row(i) = row(segments(7)) - ...
            floor(rad * sin((i-segments(7))*step/rad));
        col(i) = col(segments(7)) + ...
            floor(rad * (1 - cos((i - segments(7))*step/rad)));
    else
        row(i) = row(1);
        col(i) = col(1);
    end
    
end

end