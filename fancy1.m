clc
clear

N = 40;
r = 0.5;
T = 1 + r; R = 1; P = 0; S = 0;
K = 0.1; % the param in Femi
K1 = 0.9; % the param in circumProb
neigRadius = 1;
iter_num = 100;

% 初始化策略矩�?
StrasMatrix = zeros(N);
StrasMatrix(18 : 22, 18 : 22) = 1;
figure(1)
DrawStraMatrix(StrasMatrix)
% pause(0.01)
CumPaysMat = zeros(N);

% 博弈支付矩阵
PayoffMatr = [R, S; T, P];

% 邻居间博弈矩�?
PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );


for i = 1:iter_num

    CumPaysMat = CumPayoff(CumPaysMat, PaysMatrix);
    AvePaysMat = CumPaysMat / i;
    
     [StrasMatrix, ~] = Evolution( StrasMatrix, PaysMatrix, ...
        neigRadius, AvePaysMat, K, K1);% �?��演化，更新各节点的策�?
    
    PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );
    
    if mod(i, 10) == 0
        figure(i / 10 + 1)
        DrawStraMatrix(StrasMatrix)
    end
end


