function path = createCycloid(vS, vE, n)
    t = linspace(0, pi, n);
    r = (vS(2) - vE(2))/2;
    path(1, :) = r*(t - sin(t))*(vE(1) - vS(1))/r/pi;
    path(2, :) = -r*(1 - cos(t));
end
