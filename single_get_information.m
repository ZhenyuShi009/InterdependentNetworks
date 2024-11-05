% For independent networks, we only need to know the degrees
function[weight_vector] = single_get_information(weight_matrix)
    weight_vector = sum(weight_matrix, 2);
end