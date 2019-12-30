%finduber.m
%finds an uber for the passenger
%rules are: first check for closest uber with no passengers
%if all ubers have a passenger, choose uber with lowest # of passengers
%in queue who's distance from the destination to the new passenger is the
%smallest
minqueuesize = min(uberqueuesize);

distancetopassenger = zeros(1, nu);
%if queue is 0, find closest uber
if minqueuesize == 0
    for u = 1:nu
        if (uberqueuesize(u) > minqueuesize)
            distancetopassenger(u) = Inf;
        else
            distancetopassenger(u) = (xu(u) - xp(np))^2 + (yu(u) - yp(np))^2;
        end
    end
else
    for u = 1:nu
        if uberqueuesize(u) > minqueuesize
            distancetopassenger(u) = inf;
        else
            distancetopassenger(u) = (xdp(uberqueue(u,minqueuesize)) - xp(np))^2 + ...
                (ydp(uberqueue(u,minqueuesize)) - yp(np))^2;
        end 
    end
end

[mindistance, uber(np)] = min(distancetopassenger);

%now, either give uber new passenger or add to queue

if minqueuesize == 0
    xd(uber(np)) = xp(np); yd(uber(np)) = yp(np); bd(uber(np)) = benter(np); pd(uber(np)) = pp(np);
    %if it is a new customer, uber needs a new path
    %two cases for whether destination is on the same block as uber or not
    %this is becuase the getshortestpath matlab function, when given the
    %same point, twice, gives as the shortest path the point
    
    %if same block
    graph = sparse(i1, i2, distance./currentvel);
    path{uber(np)} = [getshortestpath(graph, i2(bu(uber(np))),... 
                                            i1(benter(np))) bd(uber(np))];
    turnnumber(uber(np)) = 1;
    nextb(uber(np)) = bu(uber(np));
end

uberqueuesize(uber(np)) = uberqueuesize(uber(np)) + 1;
uberqueue(uber(np), minqueuesize + 1) = np;
