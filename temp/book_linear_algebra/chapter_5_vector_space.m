%% 추이행렬. transition matrix

% 집합 S = {x1, x2, ...} T = {y1, y2, ...}은 n차원을 span 가능하다.
% 두 집합은 벡터공간 V의 서로 다른 기저.
% 임의의 벡터 x ∈ V 가 있을 때 S의 x와 T의 x

S = [
    1 1 3; 
    2 -1 5; 
    0 -2 -1]';
T = [
    1 2 0;
    1 1 1;
    2 0 1;]';

ST = [S T]; % 확대 행렬

P = rref(ST) % T -> S로 가는 추이 행렬 transition matrix

tx = [1 2 3]';

bx = T*tx;

sx = inv(S)*bx;

inv(S)*T


% [L, U] = lu(T)

%% T -> S로 가기 위해서
% bx = T * tx;
% sx = S' * bx;
% sx = S' * T * tx;

% 여기서 추이행렬 P = S'*T 이다.
%%
S=[1 2 1 -2; 
    0 1 1 0; 
    0 2 3 1; 
    1 0 -1 2]';
T=[-1 1 0 0;
    1 1 0 0;
    0 0 -1 0;
    0 0 0 2]';

S2T = inv(T)*S;
T2S = inv(S)*T;
Q = S2T

xs = [2 -2 4 0]';
xt = S2T * xs





