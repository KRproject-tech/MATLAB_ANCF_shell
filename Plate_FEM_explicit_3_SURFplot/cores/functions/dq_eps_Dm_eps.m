function out = dq_eps_Dm_eps( q_i_vec, Dm_mat, dx_n_Sc_struct, p_vec)

N_q = length( q_i_vec);                                              	%% 1要素当たりのノードの成分数

%% 変数抽出
dx_Sc_dx_Sc_mat = dx_n_Sc_struct.dx_Sc_dx_Sc_mat;                       %% 対称行列
dy_Sc_dy_Sc_mat = dx_n_Sc_struct.dy_Sc_dy_Sc_mat;                       %% 対称行列
dxSc_dySc_p_dySc_dxSc_mat = dx_n_Sc_struct.dxSc_dySc_p_dySc_dxSc_mat;



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


out = mntimes2( mntimes2( permute( dq_eps_v, [ 2 1 3 4]), Dm_mat), eps_v);  

end