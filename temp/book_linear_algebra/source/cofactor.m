% �����ڸ� ����ϴ� M-����(cofactor.m)
function ckl=cofactor(A,k,l)       % �Լ� ����
[m,n]=size(A);                        % ����� ũ�� ���
if m~=n                                % ���簢������� Ȯ��
    error('Matrix must be square')
end
B=A([1:k-1,k+1:n],[1:l-1,l+1:n]);  %����Ľ� ���
ckl=(-1)^(k+l)*det(B);               %������ ���