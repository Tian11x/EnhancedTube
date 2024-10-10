function [T_recover,IDX,Time_sample,Time_rec]=tensor_adaptive_sample_fiber(Tensor,M,sigma,R)
%================================����Fiber����================================%
%���룺Tensor ԭʼ���������� M ���������� sigma ������������� maxIter ��������
%�����T_recover �ع����������� IDX ����λ�þ���
%=============================================================================%
[I,J,K]=size(Tensor); %��������Ĵ�С
IDX=zeros(I,J,K);     %��ʼ����������Ϊ������
U=zeros(I,I,K);
%�ȼ���� �����������Ŀ 
number1=M*sigma;    
%ʣ�µ��� ���Ȳ�������Ŀ
% maxIter=max(1,R-floor(number1/I)); %�����������Ŀ
number2=M-number1;%���Ȳ�������Ŀ
zzz = 10;
maxIter = number2/(I*zzz);
SET=[];                 %��ʼ������slice�ļ���Ϊ�ռ�
T_recover=zeros(size(Tensor));%��ʼ���ع�����
%=========== ��1�׶�~����������� ==================%
tic;
IDX=tensor_random_sample_tube(IDX,number1);     %�� fiber �������
time_pre=toc; %Ԥ�Ȳ������� �� ʱ��
%========== ��2�׶�~���Ȳ��� =======================%
EYE=tensor_eye(I,I,K);
tic;
for iter=1:maxIter  
    
    Tensor_sample=Tensor.*IDX;          % ��ò������� 
    %-------------����ͶӰ�ռ�Pu_inv-------------%
    if max(max(U))==0                     
        Pu_inv=EYE;                       % ��һ�ε�����ͶӰ�ռ�Ϊ��λ����
    else                                  % ���U���ǿռ�
        UT=tensor_transpose(U);           % ����U��ת��
        tmp1=tensor_product_Fourier(UT,U);   % ���� ����Ҷ �˷� 
        tmp2=tensor_inverse_Fourier(tmp1);   % ���� ����Ҷ ����   
        tmp3=tensor_product_Fourier(U,tmp2); % ���� ����Ҷ �˷�
        Pu=tensor_product_Fourier(tmp3,UT);  % ���� ����Ҷ �˷�
        Pu_inv=EYE-Pu;                     %ͶӰ
    end
    
    %-----------��ÿ�еĲ�������-------------------%
    P=zeros(1,J);                         %��ʼ���еĸ���Ϊȫ0��
    for j = 1 : J                         %����ÿһ�еĸ���
        P(1,j)= sum(sum(sum( (  tensor_product_Fourier(Pu_inv,Tensor_sample(:,j,:)) ).^2 ))) / sum(sum(sum( ( tensor_product_Fourier(Pu_inv,Tensor_sample) ).^2  )));%�������
    end
    
    %----------���Ҹ��ʽ��в���-------------------%
    s = zzz;     %ѡ��  ���в����ĸ���
    %s = (1*sigma)*M/(J*maxIter);
    ii=1;
    while (ii<=s && sum(sum(P))~=0)     %������δ�������У���û�ﵽ��������s������   
        [~,col]=find( P==max(max(P)) ); %�ҵ����ĸ���
        pos=col(1);                     %���������кţ������ظ��Ļ�һ�𷵻أ�����ȡ��һ��
        P(pos)=0;                       %����Ӧ�ĸ�����Ϊ0
        
        if ( IDX(:,pos,:) == 1)      %�жϵ�ǰ�����Ƿ��Ѿ����в���
            continue;                %����Ѿ���������ôֱ����������ĳ���
        else
           IDX(:,pos,:)=1;            %���в���
           SET=[SET,Tensor(:,pos,:)]; %�����в�����slice���뼯����
           ii=ii+1;
        end    
    end
    %-------------���¿ռ�U----------------------%
    [U,~,~]=t_SVD(SET); %��������tsvd�������Ӧ�Ŀռ� U
    U=U(:,1:R,:);
end
Time_sample=toc;  %�ӿռ���²���  -- �� ���ǲ���
Time_sample=Time_sample+time_pre;
%=================3.�����ع�����==========================%
tic;
for j=1:J
    
    [row,~,~]=find(IDX(:,j,1)~=0); %slice�ϲ������λ��
    Uj=U(row,:,:);                  %�ռ��ϣ���Ӧ��Uj
    UjT=tensor_transpose(Uj);       %Uj��ת��
    tmp1=tensor_inverse_Fourier( tensor_product_Fourier( UjT,Uj) );%
    tmp2=tensor_product_Fourier(U,tmp1);
    Pu=tensor_product_Fourier(tmp2,UjT);
    Tensor_j=Tensor(row,j,:);
    T_recover(:,j,:)=tensor_product_Fourier(Pu,Tensor_j); % �ع�����
end
Time_rec=toc;
