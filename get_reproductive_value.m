% Get the reproductive value
function[pi] = get_reproductive_value(weight_vector, death_vector)
    pi = weight_vector ./ death_vector; 
    pi = pi / sum(pi);
end