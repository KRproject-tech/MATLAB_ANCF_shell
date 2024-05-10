%% Mesh generation

%%[0] 各要素のノード，ノードの座標を取得
[ coordinates, nodes] = MeshRectanglularPlate_ununiform( x_vec, y_vec); 

%%[1] 各要素の長さ・幅の取得 [m]
dL_vec = zeros(1,N_element);
dW_vec = dL_vec;
for ii = 1:N_element
    
    x_2 = coordinates(nodes(ii,2),1);
    x_1 = coordinates(nodes(ii,1),1);
    dL_vec(ii) = x_2 - x_1;
    
    y_4 = coordinates(nodes(ii,4),2);
    y_1 = coordinates(nodes(ii,1),2);
    dW_vec(ii) = y_4 - y_1;
end



N_q = size( Sc_mat( 0, 0, 0, 0), 2);        %% ノード座標成分数 [-]
N_qi = N_q/4;                               %% 1ノード当たりの成分数 [-]

%%[2] ノード総数 [-]
N_node = size( coordinates, 1);

%%[3] ノード座標の成分総数 [-]
N_q_all = N_node*N_qi;


%%[4] 各要素内の成分番号
I_vec = [];
J_vec = [];
for ii = 1:N_element
    
    %% 1ノード当たり9成分 ( q_i = [ rx_i ry_i rz_i : dx_rx_i dx_ry_i dx_rz_i : dy_rx_i dy_ry_i dy_rz_i]^T ∈ R^9 )
    %% 1要素当たり36成分　( q := [ q_i1^T q_i2^T q_i3^T q_i4^T]^T ∈ R^36 )
    i_vec = repmat( ( N_qi*(nodes(ii,:) - 1)+1 ).', [ 1 N_qi]).' + repmat( 0:N_qi-1, [ length( nodes(ii,:)) 1]).';
    i_vec_v(ii) = { i_vec(:).' };
    
    I_vec = [ I_vec repmat( i_vec_v{ii}, [ 1 N_q])];
    J_vec = [ J_vec kron( i_vec_v{ii}, ones(1,N_q))];
end

%% global 変数

var_param.coordinates = coordinates;
var_param.N_qi = N_qi; 
var_param.N_q_all = N_q_all;
