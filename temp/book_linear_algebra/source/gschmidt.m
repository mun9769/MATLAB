% Q-R분해를 계산하는 M-파일(gschmidt.m)
function [Q,R]=gschmidt(V)
[m,n]=size(V);     %행렬 V의 크기 계산
R=zeros(n);         %행렬 R을 n차 영행렬로 지정
R(1,1)=norm(V(:,1)); %행렬 R의 (1,1)성분을 지정
Q(:,1)=V(:,1)/R(1,1); %행렬 Q의 1번째 열벡터 계산
for k=2:n
R(1:k-1,k)=Q(:,1:k-1)'*V(:,k);
Q(:,k)=V(:,k)-Q(:,1:k-1)*R(1:k-1,k);
R(k,k)=norm(Q(:,k));
Q(:,k)=Q(:,k)/R(k,k);
end