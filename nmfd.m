function [W,H,E] = nmfd(V,W,H,I,flagUpdateBases)

% The update rule for activations was adapted from "Drum extraction in 
% single channel audio signals using multi-layer non negative matrix factor 
% deconvolution" by Laroche et al.
% The update rule for bases was adapted from "Non-negative Matrix Factor 
% Deconvolution; Extracation of Multiple Sound Sources from Monophonic 
% Inputs" by Smaragdis
% 
% Input:
%   1) V - magnitude of STFT of mixture (single-sided)
%       MxN
%   2) W - magnitude 3D array containing STFTs of bases (single-sided)
%       MxTxR
%   3) H - activation matrix
%       RxN
%   4) I - number of iterations
%   5) flagUpdateBases - update W if 1
% 
% Output:
%   1) W - estimated magnitude 3D array containing STFTs of bases (single-sided)
%       MxTxR
%   2) H - estimated activation matrix
%       RxN
%   3) E - vector containing error for each iteration
% 
% Dimensions:
%   M - frequency bins
%   T - convolution depth
%   R - sources i.e. bases
%   N - mixture length

[~,T,~] = size(W);

V_tilde = estimateV(W,H); 

lambda_1 = 0;
lambda_2 = 0;
E = zeros(I,1); % allocate memory for KL divergence error values 
for i=1:I
    H_top = zeros(size(H));
    H_bot = zeros(size(H));
    OnesMN = ones(size(V)); 
    OnesRN = ones(size(H)); 
    
    if flagUpdateBases==1
        for t=1:T
            Wt = permute(W(:,t,:),[1 3 2]); % take basis t 
            Wt = Wt.*(V./(V_tilde+eps)*shift(H,t-1)')./(OnesMN*shift(H,t-1)'+eps);
            W(:,t,:) = permute(Wt, [1 3 2]);
        end
    end
         
    V_tilde = estimateV(W,H); % update V_tilde for every i
    
    for t=1:T
        Wt = permute(W(:,t,:),[1 3 2]); % take basis t 
        H_top = H_top + Wt'*shift(V./(V_tilde+eps),-t+1);
        H_bot = H_bot + Wt'*OnesMN + 2*lambda_2*H + lambda_1*OnesRN;
    end
    
    H = H.*(H_top./(H_bot+eps)); % update H for every i
    
    % normalize
    max_H = max(max(H));
    H = H./(max_H + eps);
    W = W.*max_H;
    
    V_tilde = estimateV(W,H); % update V_tilde for every i

    % find KL divergence error
    E(i) = errorFrobenius(V, V_tilde);
end