close all
clear all
Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ';
str = ' WE HOLD THESE TRUTHS TO BE SELFEVIDENT THAT ALL MEN ARE CREATED EQUAL THAT THEY ARE ENDOWED BY THEIR CREATOR WITH CERTAIN UNALIENABLE RIGHTS THAT AMONG THESE ARE LIFE LIBERTY AND THE PURSUIT OF HAPPINESS ';
strlength(Alphabet);
counts = zeros(1,27);
alp = categorical(num2cell(Alphabet));
multiplier = ceil(10000/strlength(str));
x = repmat(str,1,multiplier);
for i = 1:27
    counts(i) = count(x,Alphabet(i));
end
counts = counts/strlength(x);



p = counts;
labels = Alphabet;

[sorted_p, I] = sort(p);
sorted_labels = labels(I);

cells = {};
for i = 1:length(labels)
    cells{end +1} = {i, i, ''};
end

a = 0;
while(a < 1)
[s, I] = sort(sorted_p);
a = sorted_p(I(1)) + sorted_p(I(2));
sorted_p(end + 1) = sorted_p(I(1)) + sorted_p(I(2));
cells{I(1)}{3} = '0';
cells{I(2)}{3} = '1';

sorted_p(I(1)) = 1;
sorted_p(I(2)) = 1;
cells{end +1} = {I(1),I(2),''};

end
cw = {};
a = codeword(cells, length(cells), '', cw)
en = encyript(a, sorted_labels, str);
decyript(a, sorted_labels, en)
function bin = codeword(cells, index, code, bin)
    temp = cells{index};
    left = temp{1};
    right = temp{2};
    code = [code, temp{3}];
    
    if  left == right
        bin{left} = code;
    else
        bin = codeword(cells, left, code, bin);
        bin = codeword(cells, right, code, bin);
    end
        
end

function encyripted = encyript(cwords, sorted_labels, signal)
    len_sig = length(signal);
    encyripted = '';
    for i = 1:len_sig
        encyripted = [encyripted, cwords{sorted_labels == signal(i)}];
    end
end

function decyripted = decyript(cwords, sorted_labels, cy_signal)
    len_cysig = length(cy_signal);
    decyripted = '';
    temp = '';
    for i = 1:len_cysig
        temp = [temp,cy_signal(i)];
        a = strcmp(cwords, temp);        
        if any(a)
            decyripted = [decyripted, sorted_labels(a)];
            temp = '';
        end
    end
end




