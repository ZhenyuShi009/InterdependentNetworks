function[lg10] = get_lg10(num)
    if num > 0
        lg10 = log10(num);
    end
    if  num < 0
        lg10 = - log10(-num);
    end
end