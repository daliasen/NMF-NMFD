function plotExportBasesNMF(W_updated, paramsSTFT, fs, flags, nameHP, paramsExport, expNum)
    folder = paramsExport.folder;
    t = paramsExport.t;
    filePrefix = paramsExport.filePrefix;
    
    if flags.DispFigs==1 || max(flags.ExportFigs)==1 
        newFig(flags.DispFigs);
        
        plotTitle = ['NMF bases' ' (' nameHP ')'];
        [ax, ~] = stftPlot(W_updated,paramsSTFT.w,paramsSTFT.overlap,fs, ...
                           plotTitle);
        
        ax.XLabel.String = 'Bases';
        ax.XTickLabel = '';
        
        h = gcf;
        
        fileName = [filePrefix '_' nameHP '_' 'Bases_NMF_' t '_e' expNum];
        exportFig(h, [folder fileName], flags.ExportFigs)
        
        if flags.DispFigs==0
            delete(h);
        end
    end
end