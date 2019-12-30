%decidenextblock.m
%only do this if the decision is not already made
if nextb(c) == b
	i = i2(b);  %i is intersection that is relevant
	%look at unit vector from block towards destination and pick the block closet to it
	%but also make it random, so cars aren't stuck in random loop
	
    %if uber has noone in queue, drive randomly
    if isuber(c) == 0 || uberqueuesize(c) == 0
        prchoice = 1;
    else
        prchoice = 0;
    end
    
    if (rand < prchoice) %prchoice is probability
		jnext = 1 + floor(rand*nbout(i));
		nextb(c) = bout(i, jnext);
    else
		nextb(c) = path{c}(turnnumber(c));  %local to global block
    end
end
