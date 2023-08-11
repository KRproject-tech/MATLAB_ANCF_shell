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


%% global 変数

var_param.coordinates = coordinates;
var_param.N_qi = N_qi; 
var_param.N_q_all = N_q_all;
