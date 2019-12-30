%velocity function
function y = v(distance, dmax, dmin, vmax)
    if distance >= dmax
        y = vmax;
    elseif distance <= dmin
        y = 0;
    else
        y = vmax * (log(distance/dmin)/log(dmax/dmin));
    end
end