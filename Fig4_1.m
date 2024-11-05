% Create a matrix to save the results
out = zeros(112, 2);
% Set the interdepent network size, each layer with 6 nodes
N1 = 6;
N2 = 6;
N = N1 + N2;
% The number of (i, j) pairs
number_state = N * (N - 1) / 2;
number_state_single = N1 * (N1 - 1) / 2;
% Coupling intensity alpha and layer updating rate beta
alpha = 0.1;
beta = 0.5;
% Map layer updating rate into individual updating rate
q1 = beta * 1 / N1;
q2 = (1 - beta) * 1 / N2;
% Load all 112 single-layer networks with size N=6
all_N6_network = importdata("adjN6.txt");
% Traverse all 112 cases.
for k = 1:112
    % Load the single-layer network
    edge_vector = all_N6_network(6*k-5:6*k, 1:6);
    % Convert it to corresponding symmetric interdependent network
    [connection_matrix, layer_vector] = get_network(edge_vector, N1, N);
    % Get all information needed
    [degree_vector, weight_matrix, weight_vector, layer_matrix_same, weight_matrix_same, weight_vector_same, weight_matrix_diff, weight_vector_diff, death_vector] = get_information(connection_matrix, layer_vector, alpha, q1, q2);
    % Get the reproductive value
    pi = get_reproductive_value(weight_vector, death_vector);
    % Get the eta
    eta = get_eta(N, number_state, weight_matrix, weight_vector, death_vector);
    % Get the (b/c)^*
    threshold = get_threshold(N, alpha, pi, weight_matrix, weight_vector, layer_matrix_same, weight_vector_same, weight_vector_diff, death_vector, eta);
    % Log-transform the results and save them
    out(k, 1) = get_lg10(threshold);

    % Do the same things on independent networks

    weight_matrix = edge_vector;
    weight_vector = single_get_information(weight_matrix);
    pi = single_get_reproductive_value(weight_vector);
    eta = single_get_eta(N1, number_state_single, weight_matrix, weight_vector);
    threshold = single_get_threshold(N1, pi, weight_matrix, weight_vector, eta);
    out(k, 2) = get_lg10(threshold);
end
% Save the results
csvwrite("N6.csv", out);


