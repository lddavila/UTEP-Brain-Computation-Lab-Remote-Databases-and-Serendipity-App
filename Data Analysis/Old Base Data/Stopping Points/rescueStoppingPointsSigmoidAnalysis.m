function rescueStoppingPointsSigmoidAnalysis
    function[] = createSigmoidFigures(results)
        for i = 1:height(results)
            x = results{i,[3,4,5,6]};
            y = results{i,[7,8,9,10]};



%             if averageOfFirstTwo > averageOfLastTwo
                y = [y(2),y(3),y(4)];
                x = [x(2),x(3),x(4)];
%                 display(y.')




                figure
                [fitobject2, gof2] = fit(x.', y.', '1 / (1 + (b*exp(-c * x)))');
                figure2 = plot(fitobject2, x.', y.');
                ylabel("Choice")
                xlabel("Reward")
                title(strcat("2 Param Sigmoid: ",string(results{i,1}), " ", strrep(string(results{i,2}),"/", "-")))
                fighandle2 = gcf;

                figure
                [fitobject3, gof3] = fit(x.',y.','(a/(1+b*exp(-c*(x))))');
                %           display(fitobject)
                figure3 = plot(fitobject3,x.',y.');
                ylabel("Choice")
                xlabel("Reward")
                title(strcat("3 Param. Sigmoid: ", string(results{i,1})," ", strrep(string(results{i,2}),"/","-")))
                fighandle3 = gcf;



                dynamicName = "C:\Users\ldd77\OneDrive\Desktop\UTEP-Brain-Computation-Lab\Data Analysis\Stopping Points\";


                if gof3.rsquare >= .5
                    saveas(fighandle3,strcat(dynamicName,"Stopping Points Rescued Sigmoid\",string(results{i,1})," ", strrep(string(results{i,2}),"/","-"),".fig"))
                    save(strcat(dynamicName,'Stopping Points Rescued Sigmoid Data\',string(results{i,1})," ", strrep(string(results{i,2}),"/","-"),'.mat'),'fitobject3')
                    delete(strcat(dynamicName,"Stopping Points Parabolas - Copy\",string(results{i,1})," ", strrep(string(results{i,2}),"/","-"),".fig"))

                elseif gof2.rsquare >= .5
                    saveas(fighandle3,strcat(dynamicName,"Stopping Points Rescued Sigmoid\",string(results{i,1})," ", strrep(string(results{i,2}),"/","-"),".fig"))
                    save(strcat(dynamicName,'Stopping Points Rescued Sigmoid Data\',string(results{i,1})," ", strrep(string(results{i,2}),"/","-"),'.mat'),'fitobject3')
                    delete(strcat(dynamicName,"Stopping Points Parabolas - Copy\",string(results{i,1})," ", strrep(string(results{i,2}),"/","-"),".fig"))
                    %                     delete(strcat(dynamicName,'Travel Pixel Parabola Data - Copy\',string(results{i,1})," ", strrep(string(results{i,2}),"/","-"),'.mat'))

                end


                close all





        end
    end
    function[results] = createDataTable()
        subjectid=[];
        date=[];
        x1 =[];
        x2 =[];
        x3 =[];
        x4 =[];
        y1 =[];
        y2 =[];
        y3=[];
        y4=[];
        results = table(subjectid,date,x1,x2,x3,x4,y1,y2,y3,y4);
        ParabolaFilePath = "C:\Users\ldd77\OneDrive\Desktop\UTEP-Brain-Computation-Lab\Data Analysis\Stopping Points\Stopping Points Parabolas - Copy";
        myFiles = dir(fullfile(ParabolaFilePath,'*.fig'));
        for k = 1: length(myFiles)
            baseFileName = myFiles(k).name;
            pieces =split(baseFileName, " ");
            name = strrep(pieces{1,1},".fig","");
            dates = strrep(pieces{2,1},".fig","");

            fullFileName = fullfile(ParabolaFilePath,baseFileName);
            fprintf(1, 'Now reading %s\n', fullFileName);
            open(fullFileName);
            a = get(gca,'Children');
            xdata = get(a,'XData');
            %display(xdata)
            xdata = xdata{2,1};
            ydata = get(a,'YData');
            ydata = ydata{2,1};
            C = {name,dates,xdata(1),xdata(2),xdata(3),xdata(4), ydata(1),ydata(2),ydata(3),ydata(4)};
            searchResults = cell2table(C,'VariableNames',{'subjectid','date','x1','x2','x3','x4','y1','y2','y3','y4'});
            results = [results;searchResults];
            close all
        end
    end

%display(results)
results = createDataTable();
display(results);
createSigmoidFigures(results)
end