%movecars.m
%we need to pay attention to the first car most importantly
for b = 1:nb
    currentvel(b) = vmax(b);
	c = firstcar(b);
	while(c > 0)
		if(c == firstcar(b)) %car is first car 
			if(isuber(c) == 1 && uberqueuesize(c) ~= 0 && bd(c) == b) && (pd(c) > p(c)) %destination is ahead of the car
				d = pd(c) - p(c) + dmin + .000001; %EDIT
			elseif (S(b) == 0) %light is red
				d = L(b) - p(c);  %finds distance from car to light
			else
				decidenextblock
				if lastcar(nextb(c)) > 0  %if next block you turn on has a last car
					d = L(b) - p(c) + p(lastcar(nextb(c))); %adjust as if you can see that car
				else
					d = dmax; %adjust as if there is no car ahead
				end
			end
        else
            %if destination is on block and closer than car ahead
            if (isuber(c) == 1 && uberqueuesize(c) ~= 0 && bd(c) == b) && (pd(c) > p(c)) &&...
                    pd(c) < p(ca)
                d = pd(c) + dmin + .000001 - p(c); %EDIT
            else
                d = p(ca) - p(c);
            end
		end
		pz = p(c);
        nextc = nextcar(c);
        if(t < startmovingtime(c))
            vel = 0;   
        else
            vel = v(d, dmax, dmin, vmax(b));
        end
        currentvel(b) = vel;
		p(c) = p(c) + dt * vel; %new position of car
		if (isuber(c) == 1 && uberqueuesize(c) ~= 0 && b == bd(c) && pz < pd(c) && ...
                pd(c) <= p(c)) %if destination reached
            startmovingtime(c) = t + 20*dt;
            if(passenger(c) == 0)
                pickuppassenger
            else
                dropoffpassenger
            end
		elseif(L(b) <= p(c))
			p(c) = p(c) - L(b);
			if(isuber(c) ==1 && nextb(c) == bd(c)) && (pd(c) <= p(c))
                if(passenger(c) == 0)
                    pickuppassenger
                else
                    dropoffpassenger
                end
			else
				cartonextblock
			end
		else
			xu(c) = xi(i1(b)) + p(c)*ux(b);
            yu(c) = yi(i1(b)) + p(c)*uy(b);
			ca = c;
		end
		c = nextc;
	end
end