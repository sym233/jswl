clear all;
close all;

vS = [0, 0];
vE = [20, -20];

f = @(s)cal_time(s, [0, 0], [20, -20]);
nvar = 10;

A = [...
    eye(nvar);
    -eye(nvar);
    ];
b = [...
    -vE(2)*ones(nvar,1);
    vS(2)*ones(nvar,1);
    ];
mint = 99999;
mins = [];
for i = 1: 10
    s = ga(f, nvar, A, b); 
    t = f(s);
    if t < mint
        mint = t;
        mins = s;
    end
end

fprintf('min time: %f\n', mint);

l = length(mins);
path = zeros(2, l+2);
path(1, :) = linspace(vS(1), vE(1), l+2);
path(2, :) = vS(2);
path(2, 2:end-1) = path(2, 2:end-1)-mins;
path(2, end) = vE(2);
plot(path(1, :), path(2, :), '-r');
hold on;

n = 100;
t = linspace(0, pi, n);
r = (vS(2) - vE(2))/2;
path2(1, :) = r*(t - sin(t))*(vE(1) - vS(1))/r/pi;
path2(2, :) = -r*(1 - cos(t));
plot(path2(1, :), path2(2, :), '-b');

legend('遗传算法计算所得曲线', '摆线');
