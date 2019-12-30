%cartonextblock.m
%updates linked list of car
firstcar(b) = nextcar(c);
%get rid of car on last block
if(c == lastcar(b))
	lastcar(b) = 0;
end
%add car to next block
if(lastcar(nextb(c)) == 0) %next block is empty
	firstcar(nextb(c)) = c;
else
	nextcar(lastcar(nextb(c))) = c;
end
%car is always last car
lastcar(nextb(c)) = c;
nextcar(c) = 0;
%update car position on block
xu(c) = xi(i1(nextb(c))) + p(c) * ux(nextb(c));
yu(c) = yi(i1(nextb(c))) + p(c) * uy(nextb(c));
bu(c) = nextb(c);
if(isuber(c) == 1)
    turnnumber(c) = turnnumber(c) + 1;
end