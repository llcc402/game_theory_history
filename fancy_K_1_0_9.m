

N = 40;
r = 0.5;
T = 1 + r; R = 1; P = 0; S = 0;
K = 0.1; % the param in Femi
K1 = 0.9; % the weight for contribution
neigRadius = 1;
iter_num = 200;

% 初始化策略矩�?
StrasMatrix = zeros(N);
% StrasMatrix(18 : 22, 18 : 22) = 1;
StrasMatrix = initStrasMatrix( N );
figure(1)
DrawStraMatrix(StrasMatrix)
% pause(0.01)


% 博弈支付矩阵
PayoffMatr = [R, S; T, P];

% 邻居间博弈矩�?
PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );

CumPaysMat = zeros(N);

for i = 1:iter_num
    tic
    
    CumPaysMat = CumPayoff(CumPaysMat, PaysMatrix);
    AvePaysMat = CumPaysMat / i;
    
    [StrasMatrix, ~] = Evolution( StrasMatrix, PaysMatrix, ...
        neigRadius, AvePaysMat, K, K1);  % �?��演化，更新各节点的策�?
    
    PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );
    
    if mod(i, 20) == 0
        figure(i / 20 + 1)
        DrawStraMatrix(StrasMatrix)
    end
end







