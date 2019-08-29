function [H_clean] = cleanActivations(H, threshold)

% Clean NMFD activations
%
% Input:
%   1) H - activation matrix
%       RxN
%   2) threshold - activations lower than the threshold will be set to zero
%
% Output:
%   1) H_clean - cleaned and binarized activation matrix
%       RxN
%
% Dimensions:
%	R - sources i.e. bases
%	N - mixture length

[R,N] = size(H);
H_clean = zeros(R,N);

% keep the activations with the highest amplitude out of every 3 consecutive
% activations
for r=1:R 
    if H(r,1)>H(r,2)
            H_clean(r,1) = H(r,1);
    end
    
    for n=2:N-1 % start with the second sample, leave the last
        if H(r,n) > H(r,n-1) && H(r,n) > H(r,n+1) 
            H_clean(r,n) = H(r,n);
        end
    end
    
    if H(r,N)>H(r,N-1)
            H_clean(r,N) = H(r,N);
    end
end

H_clean(H_clean < threshold) = 0;
H_clean(H_clean >= threshold) = 1;


