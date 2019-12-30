%createpassengers.m
%R is prob per unit time per unit length of car being created
R = 50000;

for b = 56:56
	if(nptot < npmax && rand < dt * R * L(b))
		np = np + 1;
        nptot = nptot + 1;
		pp(np) = rand * L(b);
		xp(np) = xi(i1(b)) + pp(np) * ux(b);
		yp(np) = yi(i1(b)) + pp(np) * uy(b);
		
		%insertnewcar is not necessary
        
		%for output purposes:
		tenter(np) = t; %time when car entered
		benter(np) = b;%block entered
		penter(np) = pp(np); %place on block entered
        
        %choose destination and which uber to take
        choosedestination
		finduber
        pickedup(np) = 1;
		
	end
end