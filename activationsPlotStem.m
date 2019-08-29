function[ax] = activationsPlotStem(H,w,overlap,fs,plot_title)

% Input:
%   1) H - activation matrix
%       RxN
%   2) w - window size that was used in stft function (for one
%       of the axis)
%   3) overlap - percentage of overlap that was used in stft function (for 
%       one of the axis)
%   4) fs - sampling frequency
%   5) plot_title - title of the plot in single quotes
%
% Output: 
%   Amplitude aligned with spectrogram (an impulse train)

hop = hopSize(w,overlap);
[~,columns] = size(H);
X = (((1:columns)-1)*hop+w/2)/fs; % time, segment index to seconds (columns)

h = stem(X,H);
h.Marker = '.';
grid on;
axis([0 X(end) -inf 1.1]);
title(plot_title, 'FontSize', 14.5)
xlabel('Time, s', 'FontSize', 14.5)
ylabel('Amplitude', 'FontSize', 14.5)
set(gca,'fontsize',12.5)

ax = gca;
