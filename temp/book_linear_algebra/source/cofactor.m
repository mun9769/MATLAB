% 여인자를 계산하는 M-파일(cofactor.m)
function ckl=cofactor(A,k,l)       % 함수 지정
[m,n]=size(A);                        % 행렬의 크기 계산
if m~=n                                % 정사각행렬인지 확인
    error('Matrix must be square')
end
B=A([1:k-1,k+1:n],[1:l-1,l+1:n]);  %소행렬식 계산
ckl=(-1)^(k+l)*det(B);               %여인자 계산