npmax = 1;
numruns = 1;
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

end