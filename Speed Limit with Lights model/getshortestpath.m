%function that returns shortest path using matlab built in function
function y = getshortestpath(graph, currentvertex, endvertex)
    i1 = [1 2 3 4 5 7 2 9 4  11 6  8 9 10 11 12 13 8  15 10 17 12 13 14 15 16 17 19 14 21 16 23 18];
    i2 = [2 3 4 5 6 1 8 3 10 5  12 7 8 9  10 11 7  14 9  16 11 18 14 15 16 17 18 13 20 15 22 17 24];

    i1(34:55) = [20 21 22 23 24 25 20 27 22 29 24 25 26 27 28 29 31 26 33 28 35 30];
    i2(34:55) = [19 20 21 22 23 19 26 21 28 23 30 26 27 28 29 30 25 32 27 34 29 36];

    i1(56:60) = [32 33 34 35 36];
    i2(56:60) = [31 32 33 34 35];

    i1(61:68) = [37 6  38 36 39 31 40 1];
    i2(61:68) = [6  38 36 39 31 40 1  37];

    nb = length(i1);
    
    i1i2toblock = sparse(i1,i2,1:nb);
    [~, path, ~] = graphshortestpath(graph, currentvertex, endvertex);
    lengthp = length(path);
    y = nonzeros(i1i2toblock(path(1:lengthp-1), path(2:lengthp)))';
end