function path = createCycloid(vS, vE, n)
%     t = linspace(0, pi, n);
%     r = (vS(2) - vE(2))/2;
%     path(1, :) = r*(t - sin(t))*(vE(1) - vS(1))/r/pi;
%     path(2, :) = -r*(1 - cos(t));

    dx = vE(1) - vS(1);
    dy = vS(2) - vE(2);
    %dx, dy > 0
    f = @(x, y)@(rt)[
        rt(1)*(rt(2)-sin(rt(2))) - x;
        rt(1)*(1-cos(rt(2))) - y;
    ];
    [rt, ~]= fsolve(f(dx, dy), [dx/2, 1]);
    r = rt(1);
    tm = rt(2);
    t = linspace(0, tm, n);
    path(1, :) = r.*(t - sin(t)) + vS(1);
    path(2, :) = -r.*(1 - cos(t)) + vS(2);
end
