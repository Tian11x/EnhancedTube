clear;
clc;

% step1�����Ȼ�����ʷ���ݵ�ÿ��slice��leverageScore֮���Ƿ������ϵ
% 1.1 ��PingsData�ϲ���
% load('experiment_leverage/result/PingsDataLSLpattern');
% for s = 1:6
%    subplot(2,3,s); imagesc(LSpattern(:,:,s)); 
% end
% 1.2 ��PlanetLab �Ͻ��в���
load('experiment_leverage/result/PlanetLabLSLpattern');
% for s = 1:9
%    subplot(2,3,s); imagesc(LSpattern(:,:,s)); 
% end
% 1.3 ��Seattle�Ͻ��в���


% step2 ѡ����һ�����������򣬵õ����б任����Ȼ�����ں�������
period = 6;
slice = 6;
index = 1;
for s = 1:slice
    % �ȸ��ݵ�slice����׼�湹�����о���
    [rowTrans,colTrans] = LS_rowcolTrans(LSpattern(:,:,s));
    subplot(slice,period+1,index); imagesc(LSpattern(:,:,s)); index = index + 1;
    for p = 1:period
        X = rowTrans*LSpattern(:,:,s+p-1)*colTrans;
        subplot(slice,period+1,index); imagesc(X); index = index + 1;
    end
end

% step3 ʵ����֤
% �� Pingsdata ���ݼ��ϲ��� ,�Ȳ��� period=4
% load('experiment_leverage/data/Pingsdata');
% PriTensor = data(:,:,1:6);
% Tensor = data(:,:,7:12);
% [n1,n2,n3] = size(Tensor);
% R = 13; % ������
% p = 0.2;
% % �ܶȲ���
% [Omega, ~] = LS_uniform_sample_tubes(PriTensor, R, Tensor, p);
% % leverage score ����
% [IDX_L]=tensor_leverage_sample_entry(Tensor,n1*n2*n3*p,0.5,R); 
% % ��ʵ���
% [True_Pattern] = LS_pattern(data(:,:,1:12), R);
% % ���Ʋ���ģʽ
% for i = 1:n3
%    subplot(3,n3,i); imagesc(Omega(:,:,i)); 
% end
% for i = 1:n3
%    subplot(3,n3,n3+i); imagesc(True_Pattern(:,:,6+i)); 
% end
% for i = 1:n3
%    subplot(3,n3,2*n3+i); imagesc(IDX_L(:,:,i)); 
% end



