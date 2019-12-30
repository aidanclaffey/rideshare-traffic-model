%insertnewcar.m
c = firstcar(b)
if ((c==0)||p(u) > p(c)) %no car on block or new car is ahead of first car
	nextcar(u) = c;
	firstcar(b) = u
	if(c==0)
		lastcar(b) = u
	end
elseif (p(u) <= p(lastcar(b))) %new car is behind last car
	nextcar(lastcar(b)) = u;
	lastcar(b) = u
else
	ca = c   %ca will be trailing pointer
	c = nextcar(c)
	while p(u) <= p(c) %find proper point
		ca = c
		c = nextcar(c)
	end
	nextcar(ca) = u;
	nextcar(u) = c;
end