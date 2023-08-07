function plotExportActivations(H_updated, ...
                               paramsSTFT, ...
                               fs, ...
                               flags, ...
                               nameHP, ...
                               paramsExport, ...
                               expNum)
% Input:
%   1) H_updated - A 2D matrix containing activations,
%       number of sources x mixture length
%   2) paramsSTFT - a structure with the following fields:
%       w - window size that was used in the stft function (for 
%           the time axis)
%       overlap - percentage of window overlap that was used in 
%           the stft function (for the time axis)
%   3) fs - sampling frequency
%   4) flags - a strcuture with the following fields:
%           DispFigs - display figures flag
%           ExportFigs - export figures, an array of flags: [pdf jpeg fig]
%   5) nameHP - a char, 'P' for percussive, 'H' for harmonic
%   6) paramsExport - a structure containing parameters for exporting files:
%       t - timestamp
%       folder - output folder
%   7) expNum - experiment number
    
    folder = paramsExport.folder;
    t = paramsExport.t;
    filePrefix = paramsExport.filePrefix;

    if flags.DispFigs==1 || max(flags.ExportFigs)==1 
        
        [R, ~] = size(H_updated);
        if R > 6
            num_subplots = 6;
            warning('only the first 6 signals will be plotted')
        else
            num_subplots = R;
        end
        
        newFig(flags.DispFigs);
        for r=1:num_subplots-1
            subplot(num_subplots, 1, r)
            
            plot_title = ['Estimated Activations (' nameHP ')'];
            ax = activationsPlotStem(H_updated(r,:), ...
                                     paramsSTFT.w, ...
                                     paramsSTFT.overlap, ...
                                     fs, ...
                                     [plot_title ' (' num2str(r) ' out of ' num2str(R) ')']);
            
            ax.YLabel.String = '';
            ax.XLabel.String = '';
            ax.XTickLabel = '';
        end
        
        subplot(num_subplots, 1, r+1)
        
        plot_title = ['Estimated Activations (' nameHP ')'];
        activationsPlotStem(H_updated(r+1,:), ...
                            paramsSTFT.w, ...
                            paramsSTFT.overlap, ...
                            fs,...
                            [plot_title ' (' num2str(r+1) ' out of ' num2str(R) ')']);

        h = gcf;
        
        fileName = [filePrefix '_' nameHP '_Activations_' t '_e' expNum];
        exportFig(h, [folder fileName], flags.ExportFigs)
        
        if flags.DispFigs==0
            delete(h);
        end
    end
end