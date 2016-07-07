function path = createParabola(vS, vE, n)
    path(1, :) = linspace(vS(1), vE(1), n); 
    k = (vE(2)-vS(2))/sqrt(vE(1)-vS(1));
    path(2, :) = k*sqrt(path(1, :));
end
