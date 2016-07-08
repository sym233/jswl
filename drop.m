function [patht, tp] = drop(path, time)
    v0 = 0;
    tp = 0;
    t = zeros(1, length(path));
    G = 5; % Gravitational acceleration
    for i = 1: length(path)-1
        t(i) = tp;
        h = path(2, i) - path(2, i+1);
        s = sqrt((path(1, i+1)-path(1, i))^2 + h^2);
        v1 = sqrt(v0^2 + 2*G*h);
        tp = tp + 2*s/(v0 + v1);
        v0 = v1;
    end
    t(end) = tp;
    if exist('time', 'var')
        patht(1, :) = interp1([t, time(end)], [path(1, :), path(1, end)], time);
        patht(2, :) = interp1([t, time(end)], [path(2, :), path(2, end)], time);
    else
        patht = [];
    end
end
%     %  v0->
%     %   .
%     %   |\_  ^_
%     %   |  \_  \_s
%     %   ^    \_  v
%     %  h|      \_     theta in [0, pi/2]
%     %   v  theta/\_
%     %   |______|___\_  v1->
