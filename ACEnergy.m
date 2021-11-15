function E = ACEnergy(G, row, col, s, w1, w2)
% ACENERGY Calculates the overall energy at each control point of the given
% active contour and gradient map
% Input
%   G: gradient squared map
%   col: indices of the control points on the contour
%   row: indices of the control points on the contour
%   s: parameterized control points
% Return
%   E: The overall energy cost by the given contour

% Initialize the energy arrays
elastic = zeros(length(s), 1);
smooth = zeros(length(s), 1);
external = zeros(length(s), 1);

% Calculate shifted arrays
rowp = circshift(row, -1);
rowm = circshift(row, 1);
colp = circshift(col, -1);
colm = circshift(col, 1);

for i = 1: length(s)
    
    elastic(i) = (rowp(i)-row(i))^2 + ...
        (colp(i)-col(i))^2;
    smooth(i) = (rowp(i)-2*row(i)+rowm(i))^2 + ...
        (colp(i)-2*col(i)+colm(i))^2;
    external(i) = -G(row(i), col(i))^2;
    
end

Ei = w1*sum(elastic) + w2*sum(smooth);
Ee = sum(external);
E = Ei + Ee;

end