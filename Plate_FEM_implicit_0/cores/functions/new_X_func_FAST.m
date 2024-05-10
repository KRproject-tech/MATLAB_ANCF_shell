function [ out, out1] = new_X_func_FAST( X_vec, m_global_struct, qf_global_struct, dq_qe_global_struct, qe_global_struct, qd_global_struct, var_param, stage, out1)


%% [0] 変数抽出
node_r_0 = var_param.node_r_0;
node_dxr_0 = var_param.node_dxr_0;
node_dyr_0 = var_param.node_dyr_0;
coordinates = var_param.coordinates;

d_t = var_param.d_t;
alpha_v = var_param.alpha_v;
theta= var_param.theta;

N_qi = var_param.N_qi; 
N_q_all = var_param.N_q_all;


%%[*] parameters
M_global = m_global_struct.M_global;                                        %% 質量行列     : M (質量＋自身のシートからの付加質量効果 [ Madd_1 Madd_2]*d_t^2[ q_1^T q_2^T]^T -> Madd_1*d_t^2 q_1)
Qf_global = qf_global_struct.Qf_global;                                     %% 体積力       : Q_f
dq_Qe_global = dq_qe_global_struct.dq_Qe_global;                            %% dq_Qe(q(n))
Qe_global = qe_global_struct.Qe_global;                                     %% 剛性力       : Q_e
Qd_global = qd_global_struct.Qd_global;                                     %% 減衰力       : Q_d




%% [1] 境界条件

%%[*] 0値固定
%%[1-0] 変位境界条件
if ~isempty( node_r_0)
    i_r = repmat( ( N_qi*(node_r_0 - 1)+1 ).', [ 1 3]) + repmat( 0:2, [ length( node_r_0) 1]);                  %% 変位拘束をかけるノードに対応するx,y変位成分番号(z=0 [m])
    i_r = reshape(i_r.',1,[]);
else
    i_r = [];
end

%%[1-1] 勾配境界条件 (x方向)
if ~isempty( node_dxr_0)
    i_dx_r = repmat( ( N_qi*(node_dxr_0 - 1)+4 ).', [ 1 3]) + repmat( 0:2, [ length( node_dxr_0) 1]);           %% dx_r = [1 0 0]^T．
    i_dx_r = reshape(i_dx_r.',1,[]);
else
    i_dx_r = [];
end

%%[1-2] 勾配境界条件 (y方向)
if ~isempty( node_dyr_0)
    i_dy_r = repmat( ( N_qi*(node_dyr_0 - 1)+7 ).', [ 1 3]) + repmat( 0:2, [ length( node_dyr_0) 1]);           %% dy_r = [0 1 0]^T．
    i_dy_r = reshape(i_dy_r.',1,[]);
else
    i_dy_r = [];
end



%%[*] 同一値に拘束    
Fmat = speye( N_q_all); 



i_vec = [ i_r i_dx_r i_dy_r];

%% [2] 加速度dtt_q算出

Q_global = (Qf_global - Qe_global);                                                                     %% 内力＋外力項

M_global = M_global*Fmat;

M_global(i_vec,:) = [];
M_global(:,i_vec) = [];

Q_global(i_vec) = []; 

Qd_global = Qd_global*Fmat;

Qd_global(i_vec,:) = [];
Qd_global(:,i_vec) = [];
dq_Qe_global = dq_Qe_global*Fmat;

dq_Qe_global(i_vec,:) = [];
dq_Qe_global(:,i_vec) = [];


eye_mat = speye( N_q_all);
eye_mat(i_vec,:) = [];
eye_mat(:,i_vec) = [];
zero_mat = sparse( N_q_all-length( i_vec),  N_q_all-length( i_vec));
if stage == 0                                                                                           %% 1回目の計算値を使いまわす．
    C_damp = (theta == 0)*2 + ~(theta == 0)*1;                                                          %% 減衰があるときは半陰解法
%     C_damp = 1;                                                                                         %% 減半陰解法
    D_matrix = [ eye_mat                                    zero_mat;
                 (Qd_global + C_damp*d_t/2*dq_Qe_global)  	M_global];                                  %% 減衰0で単位行列になる．
     out1.D_matrix = D_matrix;
else
    D_matrix = out1.D_matrix;
end
X2_matrix = [ zero_mat      eye_mat;
              zero_mat      zero_mat];
A_mat1 = D_matrix - alpha_v*d_t*X2_matrix;
A_mat2 = D_matrix + (1 - alpha_v)*d_t*X2_matrix;




%%[2-0] 固定部のノードでは dt_q = 0, dtt_q = 0
not_i_vec = (1:N_q_all);
not_i_vec(i_vec) = [];


%% [3] 状態ベクトル更新

if stage == 0                                                                                           %% 1回目の計算値を使いまわす．
    out1.A1_A2_Xn = A_mat1\( A_mat2*X_vec([ not_i_vec N_q_all+not_i_vec]) );
end
out_0 = out1.A1_A2_Xn + A_mat1\( d_t*[ zero_mat(:,1);
                                       Q_global]);
                    
out = X_vec;
out([ not_i_vec N_q_all+not_i_vec]) = out_0;
out = blkdiag( Fmat, Fmat)*out;

end