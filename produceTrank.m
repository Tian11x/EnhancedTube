 function [trank] = produceTrank(s1)
%PRODUCETRANK �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

len = length(s1);
tol = 0;

for i=1:len
    tol = tol + s1(i);
end

trank = 1;
num = 0;
while true
    num = num + s1(trank);
    if num/tol > 0.6
        break;
    end
    trank = trank + 1;
end

end

