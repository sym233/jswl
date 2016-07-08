function path = createOval(vS, vE, n)
    path(1, :) = linspace(vS(1), vE(1), n);
    a = vE(1) - vS(1);
    b = vE(2) - vS(2);
    path(2, :) = b*sqrt(1 - (path(1, :)-vE(1)).^2./a^2);
end
