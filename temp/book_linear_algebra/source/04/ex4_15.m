P=[2 -1 0];Q=[1 2 1];R=[-1 0 3]; % 점 입력
PQ=Q-P,PR=R-P                    % 벡터 생성
SC=cross(PQ,PR)                  % 벡터의 외적 계산
S=1/2*norm(SC)                   % 삼각형의 넓이 계산