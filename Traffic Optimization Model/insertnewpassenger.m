%insertnewpassenger.m
p = firstcar(b);
if ((c==0)||p(nc) > p(c)) %no car on block or new car is ahead of first car
	nextcar(nc) = c;
	firstcar(b) = nc
	if(c==0)
		lastcar(b) = nc
	end
elseif (p(nc) <= p(lastcar(b))) %new car is behind last car
	nextcar(lastcar(b)) = nc;
	lastcar(b) = nc
else
	ca = c   %ca will be trailing pointer
	c = nextcar(c)
	while p(nc) <= p(c) %find proper point
		ca = c
		c = nextcar(c)
	end
	nextcar(ca) = nc;
	nextcar(nc) = c;
end