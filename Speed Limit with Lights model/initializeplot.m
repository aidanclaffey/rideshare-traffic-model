for i = 1:nb
    plot([xi(i1(i)) xi(i2(i))], [yi(i1(i)) yi(i2(i))])
end

hubers = plot(0, 0, 'o', 'MarkerFaceColor', 'b');
hcars = plot(0, 0, 'o', 'MarkerFaceColor', 'c');
hdestinations = plot(0, 0, 'o', 'MarkerFaceColor', 'g');
hpickupspot = plot(0, 0, 'o', 'MarkerFaceColor', 'r');