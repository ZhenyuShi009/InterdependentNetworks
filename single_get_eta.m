% Get the eta for independent cases
function[eta] = single_get_eta(N, number_state, weight_matrix, weight_vector)
    coefficient_matrix = zeros(number_state, number_state);
    coefficient_vector = ones(number_state, 1);
    for index_target = 1:number_state
        [i, j] =  get_location(index_target, N);
        coefficient_vector(index_target) = 1 / 2;
        % Fill in the coefficients for each element according to the definition
        for k = 1:N
            if i ~= k
                index_new = get_index(i, k, N);
                coefficient_matrix(index_target, index_new) = weight_matrix(j, k) / weight_vector(j) / 2;
            end
            if j ~= k
                index_new = get_index(j, k, N);
                coefficient_matrix(index_target, index_new) = weight_matrix(i, k) / weight_vector(i) / 2;
            end          
        end        
    end
    coefficient_matrix = coefficient_matrix - eye(number_state);    
    eta = coefficient_matrix \ -coefficient_vector;
    eta(end + 1) = 0;
end