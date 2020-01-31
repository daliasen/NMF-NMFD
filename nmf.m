function [W,H,E] = nmf(V,W,H,I,flagUpdateBases)

% Input:
%   1) V - magnitude of STFT of mixture (single-sided)
%       MxN
%   2) W - magnitude 2D array containing STFTs of bases (single-sided)
%       MxR
%   3) H - activation matrix
%       RxN
%   4) I - number of iterations
%   5) flagUpdateBases - update W if 1
% 
% Output:
%   1) W - estimated magnitude 2D array containing STFTs of bases (single-sided)
%       MxR
%   2) H - estimated activation matrix
%       RxN
%   3) E - vector containing error for each iteration
% 
% Dimensions:
%   M - frequency bins
%	R - sources i.e. bases
%	N - mixture length

V_tilde = estimateV(W,H); 

E = zeros(I,1); % allocate memory for KL divergence error values 
for i=1:I
    OnesMN = ones(size(V)); 
    
    if flagUpdateBases==1
        W = W.*(V./(V_tilde+eps)*H')./(OnesMN*H'+eps);
    end
         
    V_tilde = estimateV(W,H); % update V_tilde
    
    H = H.*(W'*(V./(V_tilde+eps))./(W'*OnesMN+eps)); % update H 
    
    max_H = max(max(H));
    H = H./(max_H + eps);
    W = W.*max_H;
   
    V_tilde = estimateV(W,H); % update V_tilde 

    % find KL divergence error
    E(i) = errorFrobenius(V,V_tilde); 
end
    