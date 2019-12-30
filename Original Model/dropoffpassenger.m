%dropoffpassenger.m
%simulates dropping off a passenger

showdestination(passenger(c)) = 0;
passenger(c) = 0;
uberqueuesize(c) = uberqueuesize(c) - 1;
for person = 1:uberqueuesize(u)
    uberqueue(c, person) = uberqueue(c, person+1);
end
uberqueue(c, uberqueuesize(c) + 1) = 0;

%if there is someone else in the queue, add them to car's destination
%else, don't do anything
if(uberqueuesize(c) > 0)
    pd(c) = pp(uberqueue(c, 1));
    xd(c) = xp(uberqueue(c,1));
    yd(c) = yp(uberqueue(c,1));
    bd(c) = benter(uberqueue(c,1));
    
    path{c} = [getshortestpath(graph, i2(bu(c)), i1(bd(c))) bd(c)];
    
    turnnumber(c) = 1;
    nextb(uber(np)) = bu(uber(np));
else
    bd(c) = 0;
end
