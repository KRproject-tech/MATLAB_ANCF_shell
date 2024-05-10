function [ out, out1, out2] = dq_eps_Dm_eps_explicit( q_i_vec, Dm_mat, dx_n_Sc_struct, p_vec)

N_q = length( q_i_vec);                                              	%% 1要素当たりのノードの成分数

%% 変数抽出
dx_Sc_dx_Sc_mat = dx_n_Sc_struct.dx_Sc_dx_Sc_mat;                       %% 対称行列
dy_Sc_dy_Sc_mat = dx_n_Sc_struct.dy_Sc_dy_Sc_mat;                       %% 対称行列
dxSc_dySc_p_dySc_dxSc_mat = dx_n_Sc_struct.dxSc_dySc_p_dySc_dxSc_mat;
dqdq_eps_v = dx_n_Sc_struct.dqdq_eps_v;


%% 剛性行列計算
lgth_p = length( p_vec);

q_i_vec = q_i_vec(:,1,ones(1,lgth_p),ones(1,lgth_p));
q_i_vec2 = permute( q_i_vec, [2 1 3 4]);
q_i_vec3 = q_i_vec2(ones(1,N_q),:,:,:);


q_dxStdxS = permute( mntimes2_fast( dx_Sc_dx_Sc_mat, q_i_vec3), [ 2 1 3 4]);
q_dyStdyS = permute( mntimes2_fast( dy_Sc_dy_Sc_mat, q_i_vec3), [ 2 1 3 4]);
q_dxStdyS_dyStdxS = permute( mntimes2_fast( dxSc_dySc_p_dySc_dxSc_mat, q_i_vec3), [ 2 1 3 4]);




dq_eps_v = [ q_dxStdxS;
             q_dyStdyS;
             q_dxStdyS_dyStdxS];

eps_v = [   1/2*( mntimes2_fast( q_dxStdxS, q_i_vec2) - 1 );
            1/2*( mntimes2_fast( q_dyStdyS, q_i_vec2) - 1 );
            mntimes2_fast( q_dxStdyS_dyStdxS/2, q_i_vec2) 	];          %% q^t*dx_S^t*dy_S*q = 1/2(q^t*dx_S^t*dy_S + q^t*dy_S^t*dx_S)*q　より計算高速のため計算済みの配列を使いまわす．

dq_eps_v_Dm_mat = mntimes2( permute( dq_eps_v, [ 2 1 3 4]), Dm_mat);

out = mntimes2( dq_eps_v_Dm_mat, eps_v); 
out1 = mntimes2( dq_eps_v_Dm_mat, dq_eps_v);  


% Dm_eps = repmat( permute( mntimes2( Dm_mat, eps_v), [2 1 3 4]), [ 1 1 1 1 N_q]);
% dqdq_eps_v_Dm_eps = sum( dqdq_eps_v.*Dm_eps(ones(1,N_q),:,:,:,:), 2);
% dqdq_eps_v_Dm_eps = permute( dqdq_eps_v_Dm_eps, [ 1 5 3 4 2]);
% 
% out2 = dqdq_eps_v_Dm_eps + out1;

eps_v_Dm_mat = mntimes2( permute( eps_v, [ 2 1 3 4]), Dm_mat);
out2 = mntimes2( eps_v_Dm_mat, eps_v); 

end