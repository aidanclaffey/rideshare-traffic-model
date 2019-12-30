%insert all of the ubers into the system

for u = 1:nu
    b = 1 + floor(rand*nb);	%block
    p(u) = rand*Lmax;			%place on block
    while p(u) >= L(b)
        b = 1 + floor(rand*nb);
        p(u) = rand*Lmax;
    end
    xu(u) = xi(i1(b)) + p(u) * ux(b);
    yu(u) = yi(i1(b)) + p(u) * uy(b);
    bu(u) = b;
    onroad(u) = 1;
    insertnewcar
    nextb(u) = b;
    isuber(u) = 1;
end

%insert other cars into system
for u = nu+1:nu+nrandomcars
    b = 1 + floor(rand*nb);	%block
    p(u) = rand*Lmax;			%place on block
    while p(u) >= L(b)
        b = 1 + floor(rand*nb);
        p(u) = rand*Lmax;
    end
    xu(u) = xi(i1(b)) + p(u) * ux(b);
    yu(u) = yi(i1(b)) + p(u) * uy(b);
    bu(u) = b;
    onroad(u) = 1;
    insertnewcar
    nextb(u) = b;
    isuber(u) = 0;
end
