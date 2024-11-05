% Convert a sing-layer network to corresponding symmetric interdependent network
function[connection_matrix, layer_vector] = get_network(edge_vector, N1, N)
    connection_matrix = zeros(N, N);
    layer_vector = -ones(N, 1);
    connection_matrix(1:N1, 1:N1) = edge_vector;
    connection_matrix(N1 + 1:N, N1 + 1:N) = edge_vector;
    connection_matrix(1:N1, N1 + 1:N) = eye(N1);
    connection_matrix(N1 + 1:N, 1:N1) = eye(N1);
    layer_vector(1:N1) = ones(N1, 1);
end