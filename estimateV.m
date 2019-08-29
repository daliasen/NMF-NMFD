function [V] = estimateV(W,H)

% Input:
%   1) W - a 3D array containing bases  
%       (freq bins x convolution depth x sources) in the case of NMFD
%       or 2D containing bases in the case of NMF
%       MxTxR or MxR
%   2) H - activations
%       RxN
%
% Output:
%   1) V_tilde - the sum of bases convolved with activations
%       MxN
% 
% Dimensions:
%   M - frequency bins
%   T - convolution depth
%   R - sources i.e. bases
%   N - mixture length

if length(size(W)) == 3 
    [M,T,~] = size(W); 
    [~,N] = size(H);
    
    V = zeros(M,N);
    for t=0:T-1 
        V = V + permute(W(:,t+1,:),[1 3 2])*H; 
        H = shift(H,1);
    end
else
    V = W*H;
end
