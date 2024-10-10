function [samp_Tensor, samp_Omega, tube_list] = MACDschedule( Tensor, p, R, Beta, opt, u, alpha, beta)
% ==========================
% 1. ���룺�����������ʡ������ȡ�����������
% �����������£�
%           ��1����ʼ��ͳ��ָ�����ȫ�ֱ���ϵ��
%           ��2��ÿ����һ�����������ݲ���ֵ����ܸ�ֵ�Ĺ��ƣ����ڸ���ָ��
%           ��3������ͳ��ָ����󡢱���ϵ��
% 2. �����������������������
% ==========================
[I,J,K] = size(Tensor);         %��������Ĵ�С
samp_Tensor = zeros(I,J,K);     %��ʼ����������
samp_Omega = zeros(I,J,K);      %��ʼ������λ������Ϊȫ0����
Number_each = floor( I*J*p );   %����ÿ����Ĳ�������
K1 = floor( K*Beta );           %ǰK1��������������
tube_list = 0;                 %���ڼ�¼tube���ȱ仯

round = 'false'; % �Ƿ���ÿ��round�������������
if strcmp(round, 'true')
   rec_Tensor = zeros(I,J,K);
end

% ========== �׶�һ������������� ==============
for i = 1:K1
   tube_list = tube_list + 1;
   tmp_Omega = matrix_random_sample_entry( Tensor(:,:,i), Number_each );
   samp_Omega(:,:,i) = tmp_Omega(:,:,1);                    %���²�������
   samp_Tensor(:,:,i) = Tensor(:,:,i).*tmp_Omega(:,:,1);    %���²�������
end

% ÿһ�β���֮�����������Ȼ���ٽ�����һ�׶�
if strcmp(round, 'true')
   Recovered = tensor_ADMM(Tensor(:,:,1:K1), samp_Omega(:,:,1:K1)); 
   rec_Tensor(:,:,1:K1) = Recovered(:,:,:);
   tmp_LSpattern = LS_pattern(rec_Tensor(:,:,1:K1), R);
else
   tmp_LSpattern = LS_pattern(samp_Tensor(:,:,1:K1), R);     %���㵽ĿǰΪֹ���������ĸܸ�ֵ
end



% ���򻮷֣�ֻ��Ҫ����һ�Σ�������ÿ�β�����һ����任
[area1, area2] = AreaDivision(I,J,u);

% ========== �׶ζ����ܸ�ֵ�������� ==============
i = K1 + 1;
tube_length = 1;      %��ʼtube��������
while i<=K
   if (i+tube_length-1)>K
      tube_length = K-i+1;
   end
   tube_list = tube_list + 1;
   
   [ tmp_Omega ] = AreaSample( tmp_LSpattern(:,:,i-1), p, area1, area2, alpha ); % ����
   
   tmp_Omega_tube = repmat(tmp_Omega,[1,1,tube_length]);    %������չΪtube_length�Ĳ�������
   samp_Omega(:,:,i:i+(tube_length-1)) = tmp_Omega_tube;    %���²�������
   samp_Tensor(:,:,i:i+(tube_length-1)) = Tensor(:,:,i:i+(tube_length-1)).*tmp_Omega_tube;     %���²�������
   
   % �������
   
   if strcmp(round, 'true')
       Recovered = tensor_ADMM(Tensor(:,:,i:i+(tube_length-1)), tmp_Omega_tube);
       rec_Tensor(:,:,i:i+(tube_length-1)) = Recovered(:,:,:);
       tmp_LSpattern = LS_pattern(rec_Tensor(:,:,1:i+(tube_length-1)), R);
    else
       tmp_LSpattern = LS_pattern(samp_Tensor(:,:,1:i+(tube_length-1)), R);     %���㵽ĿǰΪֹ���������ĸܸ�ֵ
    end

   i = i + tube_length;                                     %����ѭ������
   % ========== ���⣺������������ƶȾ�����һ����tube_length ============
   if strcmp(opt, 'tubeOn-cos') % �� cos �����������ȶ���
       [stability] = CosVar(tmp_LSpattern(:,:,end-1), tmp_LSpattern(:,:,end));
       if stability>=beta
         tube_length = tube_length + 1;
      elseif stability < beta
         tube_length = max( 1, floor(tube_length/2) );
      end
   end
end

if strcmp(round, 'true')
   samp_Tensor = rec_Tensor; 
end

end

