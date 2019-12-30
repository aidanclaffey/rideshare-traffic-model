% # of ubers, constant
nu = 1;
% # of random cars
nrandomcars = 1;

%Number of passengers, initially
np = 0;

%uber that the passenger will take
uber = zeros(1, np);
%passenger that is in the uber
passenger = zeros(1, nu);

% # of max passengers allowed
nptot = 0;
npdroppedoff = 0;
% # of intersections
ni = 40;
% # of blocks
nb = 68;
%distance behind next car such that car will go 0 or max speed
dmin = 20/5280; %20 feet in miles
dmax = 200/5280; % 200 feet
vmax = zeros(1, nb); %speed limit of 40
vmax(1:60) = 25;
vmax(61:68) = 60;

%block array indices:
%block array indices:
i1 = [1 2 3 4 5 7 2 9 4  11 6  8 9 10 11 12 13 8  15 10 17 12 13 14 15 16 17 19 14 21 16 23 18];
i2 = [2 3 4 5 6 1 8 3 10 5  12 7 8 9  10 11 7  14 9  16 11 18 14 15 16 17 18 13 20 15 22 17 24];

i1(34:55) = [20 21 22 23 24 25 20 27 22 29 24 25 26 27 28 29 31 26 33 28 35 30];
i2(34:55) = [19 20 21 22 23 19 26 21 28 23 30 26 27 28 29 30 25 32 27 34 29 36];

i1(56:60) = [32 33 34 35 36];
i2(56:60) = [31 32 33 34 35];

i1(61:68) = [37 6  38 36 39 31 40 1];
i2(61:68) = [6  38 36 39 31 40 1  37];
%creategrid
%for mapping an (i1, i2) pair to its vector
i1i2toblock = sparse(i1,i2,1:nb);

nbin = zeros(1, ni);
nbout = zeros(1, ni);

%initialize all blocks
for i = 1:ni
	nbin(i) = sum(i2 == i);
	nbout(i) = sum(i1 == i);
end

nbinmax = max(nbin);
nboutmax = max(nbout);

bin = ones(ni, nbinmax);
bout = ones(ni, nboutmax);

for i = 1:ni
	bin(i, 1:nbin(i)) = find(i2 == i); %where find(i2 == i) makes a list of all i2 that equal i
	bout(i, 1:nbout(i)) = find(i1 == i); 
end

%initialize all traffic lights
jgreen = ones(1, ni);
S = zeros(1, nb);
for i = 1:ni
	b = bin(i,jgreen(i));
    S(b) = 1;
end

%initialize geometric positions of traffic lights
%xi = zeros(ni); yi = zeros(ni)
i=1;
while i <= ni - 4 
    xi(i:i+5) = [0 .2 .4 .6 .8 1];
    yi(i:i+5) = (i-1)/6 * 0.4;
    i = i+6;
end
xi(37:40) = [0.5 1.5 0.5 -0.5];
yi(37:40) = [-0.5 1 2.5 1];

%unit vectors for each block
ux = zeros(1, nb); uy = zeros(1, nb);L = zeros(1, nb);
for b = 1:nb
    ux(b) = xi(i2(b)) - xi(i1(b));
	uy(b) = yi(i2(b)) - yi(i1(b));
	L(b) = sqrt(ux(b)^2 + uy(b)^2);
	ux(b) = ux(b)/L(b);
	uy(b) = uy(b)/L(b);
end
Lmax = max(L);

%position of cars
xu = zeros(1, nu + nrandomcars);
yu = zeros(1, nu + nrandomcars);
bu = zeros(1, nu + nrandomcars);
%position of passengers in beginning
xp = zeros(1, npmax);
yp = zeros(1, npmax);
%queue size and queue array
uberqueuesize = zeros(1, nu);
uberqueue = zeros(nu, npmax);

%TODO
%Implement initializations of ubers


hold on
% plot(xplotperim, yplotperim);
% plot(xplotmid1, yplotmid1);
% plot(xplotmid2, yplotmid2);

for i = 1:nb
    plot([xi(i1(i)) xi(i2(i))], [yi(i1(i)) yi(i2(i))])
end

hubers = plot(0, 0, 'o', 'MarkerFaceColor', 'b');
%hcars = plot(0, 0, 'o', 'MarkerFaceColor', 'c');
hdestinations = plot(0, 0, 'o', 'MarkerFaceColor', 'g');
hpickupspot = plot(0, 0, 'o', 'MarkerFaceColor', 'r');

hold off
axis equal

showdestination(1) = 0;
pickedup(1) = 0;

%set max for clock
clockmax = 3600; %1 hour
dt = 1/3600; %one second

%set time for lights to change
tlcstep = 1/120;
tlc = tlcstep;

%initialize linked list system for cars
firstcar = zeros(1, nb);
lastcar = zeros(1, nb);
nextcar = zeros(1, nu + nrandomcars);
%position of car on block
p = zeros(1, nu);

%passengers on the road
onroad = zeros(1, npmax);

%initialize a probabilty under which a car will make a random turn
prchoice = 0.9;

%destination initialization for passengers
bdp = zeros(1, npmax);
pdp = zeros(1, npmax);
xdp = zeros(1, npmax);
ydp = zeros(1, npmax);

%destination initialization for cars
bd = zeros(1, nu);
pd = zeros(1, nu);
xd = zeros(1, nu);
yd = zeros(1, nu);

%for shortest path optimization
distance = zeros(1, length(i1));
for j = 1:length(i1)
    distance(j) = sqrt((xi(i2(j)) - xi(i1(j)))^2 + (yi(i2(j)) - yi(i1(j)))^2);
end
graph = sparse(i1, i2, distance/vmax);


%path will contain the path (in an array of indices), that the car is
%supposed to take
%turn number is the turn that the car is on
path = cell(1, nu);
turnnumber = zeros(1, nu);

startmovingtime = zeros(1, nu + nrandomcars);