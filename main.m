

N = 40;
r = 0.5;
T = 1 + r; R = 1; P = 0; S = 0;
K = 0.1; % the param in Femi
K1 = [0.1, 0.3, 0.5, 0.7, 0.9]; % the weight for contribution
neigRadius = 1;
iter_num = 300;


% 博弈支付矩阵
PayoffMatr = [R, S; T, P];

for kk = 1:length(K1)
    % 初始化策略矩�?
    StrasMatrix = initStrasMatrix( N );

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
            neigRadius, AvePaysMat, K, K1(kk));  % �?��演化，更新各节点的策�?

        PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );

        fq_coop(i) = sum(sum(StrasMatrix));

        toc
        fprintf(['iter ', num2str(i), ' done\n'])
    end

    fq_coop = fq_coop / (N * N);

    hold on
    plot(fq_coop, 'LineWidth', 2)
end
legend('K1=0.1', 'K1=0.3','K1=0.5','K1=0.7','K1=0.9')