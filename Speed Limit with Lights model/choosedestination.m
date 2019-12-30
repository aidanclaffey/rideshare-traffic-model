%choosedestination.m
bdp(np) = 22;	%block destination
pdp(np) = rand*L(22);			%place on block destination

xdp(np) = xi(i1(bdp(np))) + pdp(np) * ux(bdp(np));
ydp(np) = yi(i1(bdp(np))) + pdp(np) * uy(bdp(np));