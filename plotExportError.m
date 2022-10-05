function plotExportError(E, E_new, flags, nameHP, paramsExport, expNum)
    folder = paramsExport.folder;
    t = paramsExport.t;
    filePrefix = paramsExport.filePrefix;

    if flags.DispFigs==1 || max(flags.ExportFigs)==1 
        newFig(flags.DispFigs);
        
        plot(E); 
        hold on
        
        plot(E_new)
        hold off
        
        grid on;
        ylabel('Error')
        xlabel('Iterations')
        
        plotTitle = ['Error (' nameHP ')']; 
        title(plotTitle)
        
        h = gcf;
        
        fileName = [filePrefix '_' nameHP '_Error_', t '_e' expNum];
        exportFig(h, [folder fileName], flags.ExportFigs)
        
        if flags.DispFigs==0
            delete(h);
        end
    end
end