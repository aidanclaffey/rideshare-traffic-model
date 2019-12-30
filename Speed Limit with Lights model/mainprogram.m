npmax = 1;
numruns = 1;
average_timepickedup = zeros(1, npmax);

for run = 1:numruns
    %main program:
    initialize %this is where you initialize the state
    insertubers
    plotcars
    
    for clock = 1:clockmax
        if(npdroppedoff <= npmax)
            t = clock * dt;
            setlights
            createpassengers
            movecars
            plotcars
            round = clock;
        end
    end

    average_timepickedup = average_timepickedup + tpickedup - tenter;
end
bar(average_timepickedup / numruns)