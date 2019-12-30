%creategrid
for q = 1:((nb-3)/7)
    i = 4*q-3
    j = 7*(q-1) + 1
    if mod(j,2) == 1
        i1(j:j+6) = [i i+1 i+2 i+4 i+1 i+6 i+3];
        i2(j:j+6) = [i+1 i+2 i+3 i i+5 i+2 i+7];
    else
        i1(j:j+6) = [i+1 i+2 i+3 i+4 i+1 i+6 i+3];
        i2(j:j+6) = [i i+1 i+2 i i+5 i+2 i+7];
    end  
end

i1(50:52) = [32 31 30];
i2(50:52) = [31 30 29];
