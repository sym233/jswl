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
