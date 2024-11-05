% Get the (b/c)^*
function[threshold] = get_threshold(N, alpha, pi, weight_matrix, weight_vector, layer_matrix_same, weight_vector_same, weight_vector_diff, death_vector, eta)
    v0 = 0;
    for i = 1:N
        for a = 1:N
            index = get_index(i, a, N);
            [pi(i), death_vector(i), eta(index), alpha, 1 - layer_matrix_same(i, a), weight_matrix(i, a), weight_vector_diff(i)];
            v0 = v0 + pi(i) * death_vector(i) * eta(index) * alpha * (1 - layer_matrix_same(i, a)) * weight_matrix(i, a) / weight_vector_diff(i);
        end
    end
    v2 = 0;
    for i = 1:N
        for j = 1:N
            for k = 1:N
                index = get_index(j, k, N);
                v2 = v2 + pi(i) * death_vector(i) * eta(index) * (1 - alpha) * weight_matrix(i, j) * weight_matrix(i, k) / weight_vector(i) / weight_vector(i);
                for t = 1:N
                    v2 = v2 + pi(i) * death_vector(i) * eta(index) * alpha * (1 - layer_matrix_same(k, t)) * weight_matrix(i, j) * weight_matrix(i, t) * weight_matrix(k, t) / weight_vector(i) / weight_vector(i) / weight_vector_diff(t);
                end
            end
        end
    end
    u0 = 0;
    for i = 1:N
        for a = 1:N
            index = get_index(i, a, N);
            u0 = u0 + pi(i) * death_vector(i) * eta(index) * (1 - alpha) * layer_matrix_same(i, a) * weight_matrix(i, a) / weight_vector_same(i);
            for k = 1:N
                index = get_index(i, k, N);
                u0 = u0 + pi(i) * death_vector(i) * eta(index) * alpha * layer_matrix_same(k, a) * (1 - layer_matrix_same(i, a)) * weight_matrix(k, a) * weight_matrix(i, a) / weight_vector_same(a) / weight_vector_diff(i);   
            end
        end
    end
    u2 = 0;
    for i = 1:N
        for j = 1:N
            for k = 1:N
                for t = 1:N
                    index = get_index(j, t, N);
                    u2 = u2 + pi(i) * death_vector(i) * eta(index) * (1 - alpha) * layer_matrix_same(k, t) * weight_matrix(i, j) * weight_matrix(i, k) * weight_matrix(k, t) / weight_vector(i) / weight_vector(i) / weight_vector_same(k);
                    for a = 1:N
                        u2 = u2 + pi(i) * death_vector(i) * eta(index) * alpha * layer_matrix_same(t, a) * (1 - layer_matrix_same(k, a)) * weight_matrix(i, j) * weight_matrix(i, k) * weight_matrix(a, k) * weight_matrix(a, t) / weight_vector(i) / weight_vector(i) / weight_vector_same(a) / weight_vector_diff(k); 

                    end
                end
            end
        end
    end
    threshold = (v0 - v2) / (u0 - u2);
end