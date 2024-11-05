% Get the eta
function[eta] = get_eta(N, number_state, weight_matrix, weight_vector, death_vector)
    coefficient_matrix = zeros(number_state, number_state);
    coefficient_vector = ones(number_state, 1);
    for index_target = 1:number_state
        [i, j] =  get_location(index_target, N);
        coefficient_vector(index_target) = 1 / N / (death_vector(i) + death_vector(j));
        for k = 1:N
            if i ~= k
                index_new = get_index(i, k, N);
                coefficient_matrix(index_target, index_new) = death_vector(j) * weight_matrix(j, k) / weight_vector(j) / (death_vector(i) + death_vector(j));
            end
            if j ~= k
                index_new = get_index(j, k, N);
                coefficient_matrix(index_target, index_new) = death_vector(i) * weight_matrix(i, k) / weight_vector(i) / (death_vector(i) + death_vector(j));
            end          
        end        
    end
    coefficient_matrix = coefficient_matrix - eye(number_state);    
    eta = coefficient_matrix \ -coefficient_vector;
    eta(end + 1) = 0;
end