function S = toSources_NMFD(W, H)

% Construct estimated sources from bases and activations where each source 
%   is represented with a single 2D base 
%
% Input:
%   W - 3D array containing the magnitude of STFTs of bases (single-sided)
%       MxTxR 
%   H - activation matrix
%       RxN
% 
% Output:
%   S - 3D array containing the magnitude of STFTs of each estimated source
%       RxMxN
% 
% Dimensions:
%   M - frequency bins
%   T - convolution depth
%   R - number of bases
%   N - mixture lenght (STFT time frames)

[R, N] = size(H);

[M,T,~] = size(W);
S = zeros(R,M,N);
for r=1:R 
    for t=0:T-1
        Wt = permute(W(:,t+1,:), [1 3 2]);
        S(r,:,:) = permute(S(r,:,:), [2 3 1]) + Wt(:,r)*shift(H(r,:),t);
    end
end

    