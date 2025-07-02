%여인자 전개를 이용한 행렬식 계산 M-파일(mydet.m)
function d=mydet(A)        % 함수명 지정
[m,n]=size(A);              % 행렬 크기 계산
if m~=n                      % 정사각행렬인지 확인
    error('Matrix must be square')
end
a=A(1,:);                   % 행렬의 1행을 벡터로 지정
c=[];                        % 행렬의 1행에 관한 여인자로 열벡터생성
for l=1:n
    c1l=cofactor(A,1,l);
    c=[c;c1l];
end
d=a*c;                        %벡터 a와 c의 내적으로 행렬식 계산