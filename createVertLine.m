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
