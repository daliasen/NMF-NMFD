function [M] = shift(M,s)

% Horizontal shift
%
% Input:
%   1) M - 2D array
%   2) s - shift amount (number of columns), 
%         0 means no shift, 
%         positive means shift right, 
%         negative means shift left 
% 
% Output:
%   1) M_shifted - M shifted by s columns

[r,c] = size(M);

if abs(s) > c
    error('Shift amount exeeds columns.')
end
    
if s < 0 % shift left if negative
        M = circshift(M, [0, s]);
        s = abs(s);
        M(:,end-s+1:end) = zeros(r, s);
elseif s > 0 % shift right if positive
        M = circshift(M, [0, s]);
        M(:,1:s) = zeros(r, s);
end
