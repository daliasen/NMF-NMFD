function [e] = errorFrobenius(V, V_tilde)

% Calculates KL divergence error based on Frobenius norm
%
% Input:
%   1) V - magnitude of an STFT of a mixture (single-sided)
%       MxN
%   2) V_tilde - magnitude of an STFT of an estimate of the mixture 
%       (single-sided)
%       MxN
% Output:
%   1) e - Frobenius norm of KL divergence

e = sqrt(sum(sum((V.*log(V./(V_tilde+eps)+eps) - V + V_tilde).^2)));