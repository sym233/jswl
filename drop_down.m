function drop_down
    close all;
    
    vS = [0, 0]; %starting point
    vE = [20, -20]; %ending point
    
    LINE_STEP = 2000;
    TIME_MAX = 10;
    TIME_TOL = 0.01;
    LINES = 5;
    
    line{1} = createLine(vS, vE, LINE_STEP);
    line{2} = createParabola(vS, vE, LINE_STEP);
    line{3} = createCycloid(vS, vE, LINE_STEP);
    line{4} = createOval(vS, vE, LINE_STEP);
    line{5} = createVertLine(vS, vE, LINE_STEP);
    name = {'直线', '抛物线', '摆线', '椭圆', '折线'};
    
    TIME_AXIS = 0: TIME_TOL :TIME_MAX;
    % patht(1, :) x coordinate 
    % patht(2, :) y coordinate 
    figure;
    
    hold on;
    xlim([vS(1)-1, vE(1)+1]);
    ylim([vE(2)-1, vS(2)+1]);
    
    LINES_COLORS = 'brmck';
    patht = cell(1, LINES);
    pointH = zeros(1, LINES);
    lineH = zeros(1, LINES);
    tEnd = zeros(1, LINES);
    
    for i = 1: LINES
        [patht{i}, tEnd(i)] = drop(line{i}, TIME_AXIS);
        fprintf('line %d: %s ends at %fs.\n', i, name{i}, tEnd(i));
        lineH(i) = plot(line{i}(1,:), line{i}(2,:),...
            ['-', LINES_COLORS(i)]);
        pointH(i) = plot(patht{i}(1, 1), patht{i}(2, 1),...
            ['o', LINES_COLORS(i)],...
            'MarkerFaceColor', LINES_COLORS(i));
      
    end
    
    legend(lineH, name);
    set(gca, 'LegendColorbarListeners', []); 
	setappdata(gca, 'LegendColorbarManualSpace', 1);
	setappdata(gca, 'LegendColorbarReclaimSpace', 1);
    
    for t = 1: length(TIME_AXIS)
        for i = 1: LINES
            set(pointH(i), 'xdata', patht{i}(1, t), 'ydata', patht{i}(2, t));
        end
        drawnow;
        %pause(TIME_TOL);
    end
end

function path = createLine(vS, vE, n)
    path(1, :) = linspace(vS(1), vE(1), n); 
    path(2, :) = linspace(vS(2), vE(2), n); 
end

function path = createParabola(vS, vE, n)
    path(1, :) = linspace(vS(1), vE(1), n); 
    k = (vE(2)-vS(2))/sqrt(vE(1)-vS(1));
    path(2, :) = k*sqrt(path(1, :));
end

function path = createVertLine(vS, vE, n)
    %vM = [vS(1), vE(2)];
    n1 = round(n*(vS(2)-vE(2))/(vS(2)-vE(2)+vE(1)-vS(1)));
    path1(2, :) = linspace(vS(2), vE(2), n1);
    path1(1, :) = vS(1) * ones(size(path1(2, :))); 
    path1 = path1(:, 1: end-1);
    path2(1, :) = linspace(vS(1), vE(1), n-n1);
    path2(2, :) = vE(2) * ones(size(path2(1, :)));
    path = [path1, path2];
end

function path = createOval(vS, vE, n)
    path(1, :) = linspace(vS(1), vE(1), n);
    a = vE(1) - vS(1);
    b = vE(2) - vS(2);
    path(2, :) = b*sqrt(1 - (path(1, :)-vE(1)).^2./a^2);
end

function path = createCycloid(vS, vE, n)
    t = linspace(0, pi, n);
    r = (vS(2) - vE(2))/2;
    path(1, :) = r*(t - sin(t))*(vE(1) - vS(1))/r/pi;
    path(2, :) = -r*(1 - cos(t));
end

function [patht, tp] = drop(path, time)
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
    t(end) = tp;
    patht(1, :) = interp1([t, time(end)], [path(1, :), path(1, end)], time);
    patht(2, :) = interp1([t, time(end)], [path(2, :), path(2, end)], time);
end
%     %  v0->
%     %   .
%     %   |\_  ^_
%     %   |  \_  \_s
%     %   ^    \_  v
%     %  h|      \_     theta in [0, pi/2]
%     %   v  theta/\_
%     %   |______|___\_  v1->
