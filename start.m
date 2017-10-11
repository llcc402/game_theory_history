

N = 40;
r = 0.5;
T = 1 + r; R = 1; P = 0; S = 0;
K = 0.1; % the param in Femi
K1 = 0.1; % the weight for contribution
neigRadius = 1;
iter_num = 300;

% 初始化策略矩�?
StrasMatrix = initStrasMatrix( N );
figure(1)
DrawStraMatrix(StrasMatrix)
title('Initial StrasMatrix')
% pause(0.01)


% 博弈支付矩阵
PayoffMatr = [R, S; T, P];

% 邻居间博弈矩�?
PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );

CumPaysMat = zeros(N);

% accept
accept_rate = zeros(1, iter_num);

fq_coop = zeros(1, iter_num);

for i = 1:iter_num
    tic
    
    CumPaysMat = CumPayoff(CumPaysMat, PaysMatrix);
    AvePaysMat = CumPaysMat / i;
    
    [StrasMatrix, accept_rate(i)] = Evolution( StrasMatrix, PaysMatrix, ...
        neigRadius, AvePaysMat, K, K1);  % �?��演化，更新各节点的策�?
    
    PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );
    
    fq_coop(i) = sum(sum(StrasMatrix));
    
    toc
    fprintf(['iter ', num2str(i), ' done\n'])
end


fq_coop = fq_coop / (N * N);
figure(2)
plot(fq_coop, 'LineWidth', 2)
title('Proportion of cooperators in each iteration')

figure(3)
DrawStraMatrix(StrasMatrix)
title(['StrasMatrix after ', num2str(iter_num), ' iterations'])


