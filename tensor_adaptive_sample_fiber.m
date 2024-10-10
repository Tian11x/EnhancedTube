function [T_recover,IDX,Time_sample,Time_rec]=tensor_adaptive_sample_fiber(Tensor,M,sigma,R)
%================================张量Fiber采样================================%
%输入：Tensor 原始数据张量； M 采样个数； sigma 随机采样比例； maxIter 迭代次数
%输出：T_recover 重构数据张量； IDX 采样位置矩阵
%=============================================================================%
[I,J,K]=size(Tensor); %获得张量的大小
IDX=zeros(I,J,K);     %初始化采样张量为零张量
U=zeros(I,I,K);
%先计算出 随机采样的数目 
number1=M*sigma;    
%剩下的是 调度采样的数目
% maxIter=max(1,R-floor(number1/I)); %随机采样的数目
number2=M-number1;%调度采样的数目
zzz = 10;
maxIter = number2/(I*zzz);
SET=[];                 %初始化张量slice的集合为空集
T_recover=zeros(size(Tensor));%初始化重构张量
%=========== 第1阶段~随机采样部分 ==================%
tic;
IDX=tensor_random_sample_tube(IDX,number1);     %对 fiber 随机采样
time_pre=toc; %预先采样部分 的 时间
%========== 第2阶段~调度采样 =======================%
EYE=tensor_eye(I,I,K);
tic;
for iter=1:maxIter  
    
    Tensor_sample=Tensor.*IDX;          % 获得采样张量 
    %-------------计算投影空间Pu_inv-------------%
    if max(max(U))==0                     
        Pu_inv=EYE;                       % 第一次迭代，投影空间为单位张量
    else                                  % 如果U不是空集
        UT=tensor_transpose(U);           % 张量U的转置
        tmp1=tensor_product_Fourier(UT,U);   % 张量 傅里叶 乘法 
        tmp2=tensor_inverse_Fourier(tmp1);   % 张量 傅里叶 求逆   
        tmp3=tensor_product_Fourier(U,tmp2); % 张量 傅里叶 乘法
        Pu=tensor_product_Fourier(tmp3,UT);  % 张量 傅里叶 乘法
        Pu_inv=EYE-Pu;                     %投影
    end
    
    %-----------求每列的采样概率-------------------%
    P=zeros(1,J);                         %初始化列的概率为全0的
    for j = 1 : J                         %计算每一列的概率
        P(1,j)= sum(sum(sum( (  tensor_product_Fourier(Pu_inv,Tensor_sample(:,j,:)) ).^2 ))) / sum(sum(sum( ( tensor_product_Fourier(Pu_inv,Tensor_sample) ).^2  )));%计算概率
    end
    
    %----------按找概率进行采样-------------------%
    s = zzz;     %选择  整列采样的个数
    %s = (1*sigma)*M/(J*maxIter);
    ii=1;
    while (ii<=s && sum(sum(P))~=0)     %若仍有未采样的列，且没达到采样列数s，继续   
        [~,col]=find( P==max(max(P)) ); %找到最大的概率
        pos=col(1);                     %返回最大的列号，但是重复的会一起返回，这里取第一个
        P(pos)=0;                       %将相应的概率置为0
        
        if ( IDX(:,pos,:) == 1)      %判断当前的列是否已经整列采样
            continue;                %如果已经采样，那么直接跳过后面的程序
        else
           IDX(:,pos,:)=1;            %整列采样
           SET=[SET,Tensor(:,pos,:)]; %将整列采样的slice放入集合中
           ii=ii+1;
        end    
    end
    %-------------更新空间U----------------------%
    [U,~,~]=t_SVD(SET); %对张量做tsvd，获得相应的空间 U
    U=U(:,1:R,:);
end
Time_sample=toc;  %子空间更新部分  -- 》 还是采样
Time_sample=Time_sample+time_pre;
%=================3.张量重构部分==========================%
tic;
for j=1:J
    
    [row,~,~]=find(IDX(:,j,1)~=0); %slice上采样点的位置
    Uj=U(row,:,:);                  %空间上，对应的Uj
    UjT=tensor_transpose(Uj);       %Uj的转置
    tmp1=tensor_inverse_Fourier( tensor_product_Fourier( UjT,Uj) );%
    tmp2=tensor_product_Fourier(U,tmp1);
    Pu=tensor_product_Fourier(tmp2,UjT);
    Tensor_j=Tensor(row,j,:);
    T_recover(:,j,:)=tensor_product_Fourier(Pu,Tensor_j); % 重构张量
end
Time_rec=toc;
