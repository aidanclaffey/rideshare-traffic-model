%pickuppassenger.m
%simulates picking up a passenger

passenger(c) = uberqueue(c, 1);
pd(c) = pdp(passenger(c));
bd(c) = bdp(passenger(c));
xd(c) = xdp(passenger(c));
yd(c) = ydp(passenger(c));

graph = sparse(i1, i2, distance./currentvel);
path{c} = [getshortestpath(graph, i2(bu(c)), i1(bd(c))) bd(c)];
showshortestpath
pause(15)

turnnumber(c) = 1;
nextb(c) = bu(c);
pickedup(passenger(c)) = 0;
showdestination(passenger(c)) = 1;
tpickedup(passenger(c)) = t; %time when passenger was picked up