% Sort the node pairs (i,j) in lexicographic order and output each corresponding position
function[index] = get_index(i, j, N)
    index = 0;
    if i > j
        t = i;
        i = j;
        j = t;
    end
    space = N - 1;
    for t = 1:(i - 1)
        index = index + space;
        space = space - 1;
    end
    index = index + j - i; 
    if i == j
        index = N * (N - 1) / 2 + 1;
    end
end