% Get the (b/c)^* for the independent cases
function[threshold] = single_get_threshold(N, pi, weight_matrix, weight_vector, eta)
    v0 = 0;
    v2 = 0;
    for i = 1:N
        for j = 1:N
            for k = 1:N
                index = get_index(j, k, N);
                v2 = v2 + pi(i) / N * eta(index) * weight_matrix(i, j) * weight_matrix(i, k) / weight_vector(i) / weight_vector(i);
            end
        end
    end
    u0 = 0;
    for i = 1:N
        for a = 1:N
            index = get_index(i, a, N);
            u0 = u0 + pi(i) / N * eta(index) * weight_matrix(i, a) / weight_vector(i);
        end
    end
    u2 = 0;
    for i = 1:N
        for j = 1:N
            for k = 1:N
                for t = 1:N
                    index = get_index(j, t, N);                   
                    u2 = u2 + pi(i) / N * eta(index) * weight_matrix(i, j) * weight_matrix(i, k) * weight_matrix(k, t) / weight_vector(i) / weight_vector(i) / weight_vector(k);
                end
            end
        end
    end
    threshold =  (v0 - v2) / (u0 - u2);
end