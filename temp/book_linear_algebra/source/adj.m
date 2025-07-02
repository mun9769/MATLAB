function B=adj(A)
[m,n]=size(A);
if m~=n
    error('Matrix must be square')
end
B=[];
for k=1:n
    for l=1:n
        B=[B;cofactor(A,k,l)];
    end
end
B=reshape(B,n,n);