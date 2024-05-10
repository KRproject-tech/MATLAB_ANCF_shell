%% エネルギ・仕事率の評価 
%%[*] 変数抽出
q_vec = X_vec(1:N_q_all,1);
dt_q_vec = X_vec(N_q_all+1:end,1);





%% [0] 運動エネルギ [J]
h_E_inertia(i_time) = 1/2*dt_q_vec.'*M_global*dt_q_vec;


%% [1] 膜ひずみ [J]
sum_e_Dp_e = 0;
sum_dt_e_Dp_dt_e = 0;
sum_dt_e_Dp_e = 0;
for ii = 1:N_element
    
    %% 1ノード当たり9成分 ( q_i = [ rx_i ry_i rz_i : dx_rx_i dx_ry_i dx_rz_i : dy_rx_i dy_ry_i dy_rz_i]^T ∈ R^9 )
    %% 1要素当たり36成分　( q := [ q_i1^T q_i2^T q_i3^T q_i4^T]^T ∈ R^36 )
    i_vec = i_vec_v{ii};
    q_i_vec = q_vec(i_vec);
    dt_q_i_vec = dt_q_vec(i_vec);

    
    int_e_Dp_e = int_e_Dp_e_vec(ii);
    int_dq_e_Dp_e = Qe_eps_vec_i(:,ii);

     
 
    sum_e_Dp_e = sum_e_Dp_e + int_e_Dp_e;

    int_dt_e_Dp_e = dt_q_i_vec.'*int_dq_e_Dp_e; 
    sum_dt_e_Dp_e = sum_dt_e_Dp_e + int_dt_e_Dp_e;
    
    
    if theta ~= 0  
        int_dq_e_Dp_dq_e = Qd_eps_mat_i(:,:,ii);    
        
        int_dt_e_Dp_dt_e = dt_q_i_vec.'*int_dq_e_Dp_dq_e*dt_q_i_vec;     
        sum_dt_e_Dp_dt_e = sum_dt_e_Dp_dt_e + int_dt_e_Dp_dt_e;
    end
end

%%[*] 膜ひずみエネルギ [J]
h_E_em(i_time) = 1/2*sum_e_Dp_e;
%%[*] 膜ひずみ仕事率 (dt_E_em) [J/s]
h_W_em2(i_time) = sum_dt_e_Dp_e; 

%%[*] 膜ひずみ速度の散逸
h_W_dm(i_time) = theta*sum_dt_e_Dp_dt_e;





%% [2] 曲げひずみ [J]
sum_k_Dp_k = 0;
sum_dt_k_Dp_dt_k = 0;
sum_dt_k_Dp_k = 0;
for ii = 1:N_element
    
    %% 1ノード当たり9成分 ( q_i = [ rx_i ry_i rz_i : dx_rx_i dx_ry_i dx_rz_i : dy_rx_i dy_ry_i dy_rz_i]^T ∈ R^9 )
    %% 1要素当たり36成分　( q := [ q_i1^T q_i2^T q_i3^T q_i4^T]^T ∈ R^36 )
    i_vec = i_vec_v{ii};
    q_i_vec = q_vec(i_vec);
    dt_q_i_vec = dt_q_vec(i_vec);

    
    int_k_Dp_k = int_k_Dp_k_vec(ii);
    int_dq_k_Dp_k = Qe_k_vec_i(:,ii);

     
 
    sum_k_Dp_k = sum_k_Dp_k + int_k_Dp_k;

    int_dt_k_Dp_k = dt_q_i_vec.'*int_dq_k_Dp_k; 
    sum_dt_k_Dp_k = sum_dt_k_Dp_k + int_dt_k_Dp_k;
    
    
    if theta ~= 0  
        int_dq_k_Dp_dq_k = Qd_k_mat_i(:,:,ii);    
        
        int_dt_k_Dp_dt_k = dt_q_i_vec.'*int_dq_k_Dp_dq_k*dt_q_i_vec;     
        sum_dt_k_Dp_dt_k = sum_dt_k_Dp_dt_k + int_dt_k_Dp_dt_k;
    end
end
%%[*] 曲げひずみエネルギ [J]
h_E_ek(i_time) = 1/2*sum_k_Dp_k;    
%%[*] 曲げひずみ仕事率 (dt_E_ek) [J/s]
h_W_ek2(i_time) = sum_dt_k_Dp_k;   

%%[*] 曲げひずみ速度の散逸
h_W_dk(i_time) = theta*sum_dt_k_Dp_dt_k; 





%% [3] 位置エネルギ [J]


h_U(i_time) = -q_vec.'*Qf_global;



