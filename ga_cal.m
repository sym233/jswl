<<<<<<< HEAD
clear all;
close all;

vS = [0, 0];
vE = [20, -20];

f = @(s)cal_time(s, [0, 0], [20, -20]);
nvar = 7;

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

path = createPath(mins, vS, vE);
plot(path(1, :), path(2, :), '-ro');
hold on;

path2 = createCycloid(vS, vE, 100);
plot(path2(1, :), path2(2, :), '-b');

legend('遗传算法计算所得曲线', '摆线');
=======
clear all;
close all;

vS = [0, 0];
vE = [20, -20];

f = @(s)cal_time(s, [0, 0], [20, -20]);
nvar = 7;

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

path = createPath(mins, vS, vE);
plot(path(1, :), path(2, :), '-ro');
hold on;

path2 = createCycloid(vS, vE, 100);
plot(path2(1, :), path2(2, :), '-b');

legend('遗传算法计算所得曲线', '摆线');
>>>>>>> origin/master
