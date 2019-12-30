%plotcars.m
if (nu > 0) && (sum(onroad) > 0)
	set(hubers, 'xdata', xu(find(isuber)), 'ydata', yu(find(isuber)))
    %set(hcars, 'xdata', xu(find(isuber == 0)), 'ydata', yu(find(isuber == 0)))
    set(hdestinations, 'xdata', xdp(find(showdestination)), 'ydata', ydp(find(showdestination)))
    set(hpickupspot, 'xdata', xp(find(pickedup)), 'ydata', yp(find(pickedup)))
end
drawnow;
pause(.01)