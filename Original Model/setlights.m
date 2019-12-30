%this is a simple implementation of setting the lights, you can do a more complicated version as well
%file setlights.m
if t > tlc     %tlc is time for lights to change, updated each step
	for i = 1:ni
		%changes the light that is green for each intersection to the next
		jgreen(i) = jgreen(i) + 1;

		%if jgreen has past the nbin, change jgreen to 1
		if jgreen(i) > nbin(i);
			jgreen(i) = 1;
		end
	end
	tlc = tlc + tlcstep;
end
%update lights' states to be green if they are supposed to be
S = zeros(1,nb);
for i = 1:ni
	b = bin(i, jgreen(i));
	S(b) = i;
end