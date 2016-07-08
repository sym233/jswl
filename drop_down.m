function drop_down
    close all;
    
    vS = [0, 0]; %starting point
    vE = [20, -20]; %ending point
    
    LINE_STEP = 2000;
    TIME_MAX = 50;
    TIME_TOL = 0.01;
    LINES = 5;
    
    line{1} = createLine(vS, vE, LINE_STEP);
    line{2} = createParabola(vS, vE, LINE_STEP);
    line{3} = createCycloid(vS, vE, LINE_STEP);
    line{4} = createOval(vS, vE, LINE_STEP);
    line{5} = createVertLine(vS, vE, LINE_STEP);
    name = {...
        '直线/ straight line',...
        '抛物线/ parabola',...
        '摆线/ cycloid',...
        '椭圆/ oval',...
        '折线/ vertical line'...
        };
    
    TIME_AXIS = 0: TIME_TOL :TIME_MAX;
    % patht(1, :) x coordinate 
    % patht(2, :) y coordinate 
    figure;
    
    hold on;
    findxymin = @(xy)@(ma)min(ma(xy, :));
    findxymax = @(xy)@(ma)max(ma(xy, :));
    
    xmin = min(cellfun(findxymin(1), line));
    xmax = max(cellfun(findxymax(1), line));
    ymin = min(cellfun(findxymin(2), line));
    ymax = max(cellfun(findxymax(2), line));
    xlim([xmin-1, xmax+1]);
    ylim([ymin-1, ymax+1]);
    
    LINES_COLORS = 'brmck';
    patht = cell(1, LINES);
    pointH = zeros(1, LINES);
    lineH = zeros(1, LINES);
    tEnd = zeros(1, LINES);
    
    fprintf('drop time:\n');
    for i = 1: LINES
        [patht{i}, tEnd(i)] = drop(line{i}, TIME_AXIS);
        fprintf('\tthe line %d: %s ends at %fs.\n', i, name{i}, tEnd(i));
        lineH(i) = plot(line{i}(1,:), line{i}(2,:),...
            ['-', LINES_COLORS(i)]);
        pointH(i) = plot(patht{i}(1, 1), patht{i}(2, 1),...
            ['o', LINES_COLORS(i)],...
            'MarkerFaceColor', LINES_COLORS(i));
    end
    hold off;
    
    legend(lineH, name);
    set(gca, 'LegendColorbarListeners', []); 
	setappdata(gca, 'LegendColorbarManualSpace', 1);
	setappdata(gca, 'LegendColorbarReclaimSpace', 1);
    
    lt = length(TIME_AXIS);
    %frames(lt) = struct('cdata',[],'colormap',[]);
    %set(gca, 'position', [0,0,1,1]);
    %set(gcf,'outerposition', [100,100,1000,400]);
    for t = 1: lt
        for i = 1: LINES
            set(pointH(i), 'xdata', patht{i}(1, t), 'ydata', patht{i}(2, t));
        end
        drawnow;
        %pause(TIME_TOL);
        %frames(t) = getframe;
    end
    %movie(frames, 1, 1/TIME_TOL);
    %movie2avi(frames, 'drop.avi', 'compression', 'None', 'fps', 100);
end
