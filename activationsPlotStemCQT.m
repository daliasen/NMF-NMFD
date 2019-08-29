function[ax] = activationsPlotStemCQT(H,Xcq,fs,plot_title)

% Input:
%   1) H - activation matrix
%       RxN
%   2) Xcq - Xcq of the mixture/source obtained with CQT_toolbox_2013
%   3) fs - sampling frequency
%   4) plot_title - title of the plot in single quotes
%
% Output: 
%   Amplitude aligned with spectrogram (an impulse train)

hop = Xcq.xlen/size(Xcq.c,2);
[~,columns] = size(Xcq.c);
X = (((1:columns)-1)*hop+hop)/fs;

h = stem(X,H);
h.Marker = '.';
grid on;
axis([0 X(end) -inf 1.1]);
title(plot_title, 'FontSize', 14.5)
xlabel('Time, s', 'FontSize', 14.5)
ylabel('Amplitude', 'FontSize', 14.5)
set(gca,'fontsize',12.5)

ax = gca;
