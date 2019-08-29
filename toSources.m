function [S] = to_sources(W,H,R_nmf)

% Input:
%   W - magnitude 3D array containing STFTs of bases (single-sided)
%       MxTxR or MxR
%   H - activation matrix
%       RxN
%   R_nmf - number of bases per source for NMF
% 
% Output:
%   S - magnitude 3D array containing STFTs of each estimated source
%       RxMxN
% 
% Dimensions:
%   M - frequency bins
%   T - convolution depth
%   R - sources i.e. bases
%   N - mixture lenght

[R, N] = size(H);

if length(size(W)) == 3 % NMFD
    [M,T,~] = size(W);
    S = zeros(R,M,N);
    for r=1:R 
        for t=0:T-1
            Wt = permute(W(:,t+1,:), [1 3 2]);
            S(r,:,:) = permute(S(r,:,:), [2 3 1]) + Wt(:,r)*shift(H(r,:),t);
        end
    end
else % NMF
    [M,~] = size(W);
    R = R/R_nmf;
    S = zeros(R,M,N);
    S_parts = zeros(M,N);
    for r=1:R % sources
        S_parts(:) = 0;
        for r_nmf=1:R_nmf % source parts of a source
            S_parts = S_parts + W(:,(r-1)*R_nmf+r_nmf)*H((r-1)*R_nmf+r_nmf,:);
        end
        S(r,:,:) = S_parts; % add source parts to a source
    end
end
    