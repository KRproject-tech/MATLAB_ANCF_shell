function [ out, out1, out2] = dq_k_Dk_k_FAST( q_i_vec, Dk_mat, dx_n_Sc_struct, p_vec, theta_a)


N_q = length( q_i_vec);                                             %% 1要素当たりのノードの成分数
lgth_p = length( p_vec);


%% 勾配計算

%%[*] 0成分は除く (Sc*q = [ S1*I S2*I ... S12*I]*q = S1*q1_r + S2*q1_dx_r + ... + S12*q4_dy_r, I∈R^3*3, qi_r,qi_dx_r,qi_dy_r∈R^3)
q_i_vec = q_i_vec(:,1,ones(1,lgth_p),ones(1,lgth_p));
q_i_vec = reshape( q_i_vec, 3, [], lgth_p, lgth_p);                 %% 形状関数の行数に合わせる(積の計算のため)．1方向:座標成分(x,y,z)に対応，2:方向(r,dx_r,dy_r)に対応，3,4方向:ガウス求積点


[ n_vec_norm_n, n_vec, norm_n] = n_vec_norm_n_f( q_i_vec, dx_n_Sc_struct);


k_v_vec = k_v( q_i_vec, n_vec_norm_n, dx_n_Sc_struct);
dq_k_v = dq_k_v_f( q_i_vec, n_vec_norm_n, dx_n_Sc_struct, N_q, norm_n);


dq_k_v_Dk_mat = mntimes2( permute( dq_k_v, [ 2 1 3 4]), Dk_mat);
out = mntimes2( dq_k_v_Dk_mat, k_v_vec);  

if theta_a ~= 0                                                     %% 構造減衰が存在する場合のみ計算 (計算コスト削減)
    out1 = mntimes2( dq_k_v_Dk_mat, dq_k_v);  
else
    out1 = 0;
end

k_v_Dk_mat = mntimes2( permute( k_v_vec, [ 2 1 3 4]), Dk_mat);
out2 = mntimes2( k_v_Dk_mat, k_v_vec); 

end


%% 法線ベクトル (n = dx_r×dy_r)
function out = n_vec_f( q_vec, dx_n_Sc_struct)

dx_Sc_mat_v = dx_n_Sc_struct.dx_Sc_mat_v;
dy_Sc_mat_v = dx_n_Sc_struct.dy_Sc_mat_v;


  
dx_r = mntimes2_fast( dx_Sc_mat_v, q_vec);
dy_r = mntimes2_fast( dy_Sc_mat_v, q_vec);

    
out =  cross_fast( dx_r, dy_r);

end

%% n/||n||^1
function [ out, n_vec, norm_n_3] = n_vec_norm_n_f( q_vec, dx_n_Sc_struct)


n_vec = n_vec_f( q_vec, dx_n_Sc_struct);

%%[*] n/||n||^3は誤り？
%%% (Hui Wan et al., Study of Strain Energy in Deformed Insect Wings, Dynamic Behavior of Materials, 
%%%  Proceedings of the 2011 AnnualConference on Experimental and Applied
%%%  Mechanics, Vol. 1, 6 pages.)
norm_n_3 = norm2( n_vec).^1;

out = n_vec./norm_n_3(ones(3,1),:,:,:);

end


%% norm
function out = norm2( a)

out = sqrt( sum( a.^2, 1));

end

%% 曲率 κxx, κyy, κxy
function out = k_v( q_vec, n_vec_norm_n, dx_n_Sc_struct)


dx2_Sc_mat_v = dx_n_Sc_struct.dx2_Sc_mat_v;
dy2_Sc_mat_v = dx_n_Sc_struct.dy2_Sc_mat_v;
dxy_Sc_mat_v = dx_n_Sc_struct.dxy_Sc_mat_v;

            

out = [	sum( mntimes2_fast( dx2_Sc_mat_v, q_vec).*n_vec_norm_n, 1);
        sum( mntimes2_fast( dy2_Sc_mat_v, q_vec).*n_vec_norm_n, 1);
        2*sum( mntimes2_fast( dxy_Sc_mat_v, q_vec).*n_vec_norm_n, 1)];

end


%% 曲率増分 dqj_κxx, dqj_κyy, dqj_κxy
function out = dq_k_v_f( q_vec, n_vec_norm_n, dx_n_Sc_struct, N_q, norm_n)

%%[*] 0成分を含んだもの
dx_Sc_mat_v_o = dx_n_Sc_struct.dx_Sc_mat_v_o;
dy_Sc_mat_v_o = dx_n_Sc_struct.dy_Sc_mat_v_o;
dx2_Sc_mat_v_o = dx_n_Sc_struct.dx2_Sc_mat_v_o;
dy2_Sc_mat_v_o = dx_n_Sc_struct.dy2_Sc_mat_v_o;
dxy_Sc_mat_v_o = dx_n_Sc_struct.dxy_Sc_mat_v_o;

%%[*] 行列の積演算の高速化のために0成分を除いたもの
dx_Sc_mat_v = dx_n_Sc_struct.dx_Sc_mat_v;
dy_Sc_mat_v = dx_n_Sc_struct.dy_Sc_mat_v;
dx2_Sc_mat_v = dx_n_Sc_struct.dx2_Sc_mat_v;
dy2_Sc_mat_v = dx_n_Sc_struct.dy2_Sc_mat_v;
dxy_Sc_mat_v = dx_n_Sc_struct.dxy_Sc_mat_v;

dx_r = mntimes2_fast( dx_Sc_mat_v, q_vec);
dy_r = mntimes2_fast( dy_Sc_mat_v, q_vec);
dx2_r = mntimes2_fast( dx2_Sc_mat_v, q_vec);
dy2_r = mntimes2_fast( dy2_Sc_mat_v, q_vec);
dxy_r = mntimes2_fast( dxy_Sc_mat_v, q_vec);



n_vec_norm_n_mat = n_vec_norm_n(:,ones(1,N_q),:,:);

% dq_n = cross_fast( dx_Sc_mat_v_o, dy_r(:,ones(1,N_q),:,:)) + cross_fast( dx_r(:,ones(1,N_q),:,:), dy_Sc_mat_v_o);
dq_n_tmp = cross_fast( dx_Sc_mat_v, dy_r(:,ones(1,N_q/3),:,:)) + cross_fast( dx_r(:,ones(1,N_q/3),:,:), dy_Sc_mat_v);
dq_n = 0*dx_Sc_mat_v_o;
dq_n(1,1:3:end,:,:) = dq_n_tmp(1,:,:,:);
dq_n(2,2:3:end,:,:) = dq_n_tmp(2,:,:,:);
dq_n(3,3:3:end,:,:) = dq_n_tmp(3,:,:,:);

nT_dq_n = sum( n_vec_norm_n_mat.*dq_n, 1);

dq_n_per_norm_n = ( dq_n - n_vec_norm_n_mat.*nT_dq_n(ones(1,3),:,:,:) )./norm_n(ones(1,3),ones(1,N_q),:,:);


nT_dx2_Sc = sum( n_vec_norm_n_mat.*dx2_Sc_mat_v_o, 1);
nT_dy2_Sc = sum( n_vec_norm_n_mat.*dy2_Sc_mat_v_o, 1);
nT_dxy_Sc = sum( n_vec_norm_n_mat.*dxy_Sc_mat_v_o, 1);


out = [	nT_dx2_Sc + sum( dx2_r(:,ones(1,N_q),:,:).*dq_n_per_norm_n, 1);
        nT_dy2_Sc + sum( dy2_r(:,ones(1,N_q),:,:).*dq_n_per_norm_n, 1);
        2*( nT_dxy_Sc + sum( dxy_r(:,ones(1,N_q),:,:).*dq_n_per_norm_n, 1) )];


end


%% 外積
function out = cross_fast( a, b)


out = a([2 3 1],:,:,:).*b([3 1 2],:,:,:) - a([3 1 2],:,:,:).*b([2 3 1],:,:,:);

end






