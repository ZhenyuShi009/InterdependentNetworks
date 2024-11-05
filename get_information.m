% Get all information needed from the connection matrix and layer vector
function[degree_vector, weight_matrix, weight_vector, layer_matrix_same, weight_matrix_same, weight_vector_same, weight_matrix_diff, weight_vector_diff, death_vector] = get_information(connection_matrix, layer_vector, alpha, q1, q2)
    % Each node's degree
    degree_vector = sum(connection_matrix, 2);
    % whether i and j are in the same layer
    layer_matrix = layer_vector * layer_vector.';
    % convert 1 and 0 into 1-alpha and alpha
    alpha_layer_matrix = (0.5 - alpha) * layer_matrix  + 0.5;
    % get the coupling weight x_ij and degree x_i
    weight_matrix = alpha_layer_matrix .* connection_matrix;
    weight_vector = sum(weight_matrix, 2);
    % Convert 1 and -1 into 1 and 0
    layer_matrix_same = 0.5 * layer_matrix + 0.5;
    % get the information about the same layer 
    weight_matrix_same = layer_matrix_same .* weight_matrix;
    weight_vector_same = sum(weight_matrix_same, 2);
    layer_matrix_diff = -0.5 * layer_matrix + 0.5;
    % get the information about the different layer 
    weight_matrix_diff = layer_matrix_diff .* weight_matrix;
    weight_vector_diff = sum(weight_matrix_diff, 2);
    % Each node's death probability
    death_vector = 0.5 * (q1 - q2) * layer_vector + 0.5 * (q1 + q2);
end