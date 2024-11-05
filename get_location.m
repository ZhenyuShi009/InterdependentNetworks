% Map a position into its original (i, j) 
function[i, j] = get_location(index, N)
    i = 1;
    space = N - 1;
    for t = 1:N + 1
        if index <= space
            j = index + i;
            break
        end
        index = index - space;
        space = space - 1;
        i = i + 1;
    end
end