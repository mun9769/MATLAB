format rat
x=[-2 -3 1];y=[2 -1 4];     % 벡터 입력
u=1/norm(y)*y;              % 벡터의 정규화
projx=dot(x,u)*u            % 정사영 계산
v2=x-projx                  % y에 수직인 x의 벡터성분 계산