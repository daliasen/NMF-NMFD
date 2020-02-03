function S = toSources_NMF(W, H, R_ps)

% Construct estimated sources from bases and activations where each source 
%   is represented with one or more 1D base
%
% Input:
%   W - 2D array containing the magnitude of STFTs of bases (single-sided)
%       MxR
%   H - activation matrix
%       RxN
%   R_ps - number of bases per source for NMF
% 
% Output:
%   S - 3D array containing the magnitude of STFTs of each estimated source
%       RxMxN
% 
% Dimensions:
%   M - frequency bins
%   R - number of bases
%   N - mixture lenght (STFT time frames)

[R_total, N] = size(H);

[M,~] = size(W);
R = R_total/R_ps; % get the number of sources
S = zeros(R,M,N);
S_parts = zeros(M,N);
for r=1:R % sources
    S_parts(:) = 0;
    for r_nmf=1:R_ps % source parts of a source
        S_parts = S_parts + W(:,(r-1)*R_ps+r_nmf)*H((r-1)*R_ps+r_nmf,:);
    end
    S(r,:,:) = S_parts; % assign added source parts to a source
end
    