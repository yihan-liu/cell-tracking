function G = BlurredGMS(I, sigma)
% BlurredGMS Calculate the blurred squared gradient magnitude of an image
% Input
%   I: Original image
%   sigma: parameter in Gaussian filter
% Return
%   G: 2D mapping of the blurred gradient magnitude squared

% initialize the neighboring values
Ixp = zeros(size(I)); % (i-1, j)
Ixm = zeros(size(I)); % (i+1, j)
Iyp = zeros(size(I)); % (i, j-1)
Iym = zeros(size(I)); % (i, j+1)

% parameters for computing derivatives
xstp = 1; % delta x
ystp = 1; % delta y

% calculate space derivatives
Ixp(1:end-1, :) = I(2:end, :);
Ixm(2:end, :) = I(1:end - 1, :);
Iyp(:, 1:end-1) = I(:, 2:end);
Iym(:, 2:end) = I(:, 1:end-1);
Ix = (Ixp-Ixm) ./ (2*xstp);
Iy = (Iyp-Iym) ./ (2*ystp);

G0 = Ix.^2 + Iy.^2;
G = imgaussfilt(G0, sigma);

end