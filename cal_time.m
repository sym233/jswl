function t = cal_time(s, vS, vE)
    t = time(createPath(s, vS, vE));
end

function path = createPath(s, vS, vE)
    l = length(s);
    path = zeros(2, l+2);
    path(1, :) = linspace(vS(1), vE(1), l+2);
    path(2, :) = vS(2);
    path(2, 2:end-1) = path(2, 2:end-1)-s;
    path(2, end) = vE(2);
end

function tp = time(path)
    v0 = 0;
    tp = 0;
    t = zeros(1, length(path));
    G = 4; % Gravitational acceleration
    for i = 1: length(path)-1
        t(i) = tp;
        h = path(2, i) - path(2, i+1);
        s = sqrt((path(1, i+1)-path(1, i))^2 + h^2);
        v1 = sqrt(v0^2 + 2*G*h);
        tp = tp + 2*s/(v0 + v1);
        v0 = v1;
    end
end
