i=[1 0 0];j=[0 1 0];k=[0 0 1];  % 단위벡터 입력
v=[1 2 3];                      % 벡터 v 입력
cosalpha=dot(i,v)/norm(v)       % 방향여현 계산
cosbeta=dot(j,v)/norm(v)
cosgamma=dot(k,v)/norm(v)