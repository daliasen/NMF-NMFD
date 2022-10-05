function plotExportActivations(H_updated, R, paramsSTFT, fs, flags, nameHP, paramsExport, expNum)
    folder = paramsExport.folder;
    t = paramsExport.t;
    filePrefix = paramsExport.filePrefix;

    if flags.DispFigs==1 || max(flags.ExportFigs)==1 
        if R > 6 
            R = 6;
            warning(['only the first ' R ' sources will be plotted'])
        end
        newFig(flags.DispFigs);
        for r=1:R-1
            subplot(R,1,r)
            
            plotTitle = ['Estimated Activations, Source ', num2str(r) ' (' nameHP ')'];
            ax = activationsPlotStem(H_updated(r,:),paramsSTFT.w,paramsSTFT.overlap,fs,...
                                     plotTitle);
            
            ax.YLabel.String = '';
            ax.XLabel.String = '';
            ax.XTickLabel = '';
        end
        subplot(R,1,r+1)
        
        plotTitle = ['Estimated Activations, Source ', num2str(r+1) ' (' nameHP ')'];
        activationsPlotStem(H_updated(r+1,:),paramsSTFT.w,paramsSTFT.overlap,fs,...
                            plotTitle);

        h = gcf;
        
        fileName = [filePrefix '_' nameHP '_Activations_' t '_e' expNum];
        exportFig(h, [folder fileName], flags.ExportFigs)
        
        if flags.DispFigs==0
            delete(h);
        end
    end
end