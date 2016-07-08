function path = createPath(s, vS, vE)
    l = length(s);
    path = zeros(2, l+2);
    path(1, :) = linspace(vS(1), vE(1), l+2);
    path(2, :) = vS(2);
    path(2, 2:end-1) = path(2, 2:end-1)-s;
    path(2, end) = vE(2);
end
