function [sampleRange1,sampleRange2] = AreaDivision(I, J, u)
%A �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

% ���ð����������֣�ֱ�Ӱ��Ȼ����Ƿ���ԣ�
rangeRow = u;
rangeCol = u;

% 2. ������ͬ����Ĳ���λ�÷�Χ����������
sampleRange1 = [];
sampleRange2 = [];
for i = 1:I
    for j = 1:J
        if (i <= rangeRow) || (j <= rangeCol)
            sampleRange1(end+1) = sub2ind([I,J], i, j);
        else
            sampleRange2(end+1) = sub2ind([I,J], i, j);
        end
    end
end
end

