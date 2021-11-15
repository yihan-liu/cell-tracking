function [row, col] = ACTracker(I, n)
% ACTRACKER  Create an active contour that eventually identifies
% the boundary of the given image.
% Input
%   I: a grayscale image.
%   n: number of control points.
% Returns
%   [row, col]: indices of the control points which are at the boundary.

[height, width] = size(I);

[row, col, s] = ACInit(height, width, n);
G = BlurredGMS(I, 3);
E = ACEnergy(G, row, col, s);

step = 1;
threshold = 100;

w1 = 1;
w2 = 1;

while (E > threshold)
    
    [row, col] = ACUpdate(G, row, col, s, w1, w2, step);
    E = ACEnergy(G, row, col, s, w1, w2);
    
end

end