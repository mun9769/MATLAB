%������ ������ �̿��� ��Ľ� ��� M-����(mydet.m)
function d=mydet(A)        % �Լ��� ����
[m,n]=size(A);              % ��� ũ�� ���
if m~=n                      % ���簢������� Ȯ��
    error('Matrix must be square')
end
a=A(1,:);                   % ����� 1���� ���ͷ� ����
c=[];                        % ����� 1�࿡ ���� �����ڷ� �����ͻ���
for l=1:n
    c1l=cofactor(A,1,l);
    c=[c;c1l];
end
d=a*c;                        %���� a�� c�� �������� ��Ľ� ���