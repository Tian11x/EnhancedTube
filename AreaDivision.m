function [sampleRange1,sampleRange2] = AreaDivision(I, J, u)
%A 此处显示有关此函数的摘要
%   此处显示详细说明

% 不用按照能量划分，直接按秩划分是否可以？
rangeRow = u;
rangeCol = u;

% 2. 两个不同区域的采样位置范围及采样个数
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

