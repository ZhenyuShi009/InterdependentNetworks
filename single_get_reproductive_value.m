% Get the reproductive value for independent cases
function[pi] = single_get_reproductive_value(weight_vector)
    pi = weight_vector / sum(weight_vector);
end