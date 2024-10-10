function [U,S,V]=t_SVD(Tensor)
%================== ����tSVD�ֽ� ===================%
%���룺Tensor ��������
%�����U V �����ռ� S�Խ�
%==================================================%
[I,J,K]=size(Tensor);
T=fft(Tensor,[],3); %����Ҷ�任
U=zeros(I,I,K);  S=zeros(I,J,K); V=zeros(J,J,K);
for k=1:K
    [u,s,v]=svd(T(:,:,k)); %�Ե�k������svd�ֽ�
    U(:,:,k)=u;
    S(:,:,k)=s;
    V(:,:,k)=v;
end
U=ifft(U,[],3); % ����ֿ�õ���Ӧ���Ӿ��� A1,A2
S=ifft(S,[],3); % 
V=ifft(V,[],3);