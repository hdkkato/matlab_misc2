function [ outputNum, outputAnearB ] = getNearNum( a, b )
%GETNEARNUM �w�肵���x�N�g���̒��ŁA�w�肵���l�Ɉ�ԋ߂��l�̔ԍ����o�͂���
%�y�g�p��z
%  a = [1 4 6 8 10 12 14];
%  b = 5.2;
%  [outputNum, outputAnearB] = getNearNum(a,b)
%    outputNum =
%         3
%    outputAnearB =
%        6
% �� �Ȃ��A���������̐��l��������������A�����o�͂��܂��B

maxNum = find(a>b, 1 );
minNum = find(a<b, 1, 'last' );
% a(maxNum) ���Aa(minNum) �̂ǂ��炩�� b �Ɉ�ԋ߂��l

if ( a(maxNum) - b ) > ( b - a(minNum) )
    outputNum = minNum;
    outputAnearB = a(minNum);
elseif ( a(maxNum) - b ) < ( b - a(minNum) )
    outputNum = maxNum;
    outputAnearB = a(maxNum);
else
    % �ł��߂��l�������������Ƃ�
    outputNum = [minNum maxNum];
    outputAnearB = [a(minNum) a(maxNum)];
end

end

