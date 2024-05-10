%% Matrix generation

%% [0] 形状関数の計算
[ p_vec, w_vec] = Gauss( N_gauss);          %% Gauss-Legendre求積の分点と重みの算出


Sc_mat_v = zeros(3,N_q,length( p_vec),length( p_vec),N_element);
dx_Sc_mat_v = Sc_mat_v;
dy_Sc_mat_v = Sc_mat_v;
dx2_Sc_mat_v = Sc_mat_v;
dy2_Sc_mat_v = Sc_mat_v;
dxy_Sc_mat_v = Sc_mat_v;
dx_Sc_mat_v_x0 = Sc_mat_v(:,:,1,:,:);
dy_Sc_mat_v_x0 = Sc_mat_v(:,:,1,:,:);
for ii = 1:N_element
    
    disp( [ 'Node number:', int2str( ii), '/', int2str( N_element)]);
    
    dL = dL_vec(ii);                        %% ii要素の長さ [-]
    dW = dW_vec(ii);                        %% ii要素の幅 [-]
            
    i_xi_a = 1;
    for xi_a = p_vec                        %% Gauss-Legendre求積
        i_eta_a = 1;
        for eta_a = p_vec
            
            x_i = dL*(xi_a + 1)/2;
            y_i = dW*(eta_a + 1)/2;
            
            Sc_mat_v(:,:,i_xi_a,i_eta_a,ii) = Sc_mat( x_i, y_i, dL, dW);
            dx_Sc_mat_v(:,:,i_xi_a,i_eta_a,ii) = dx_Sc_mat( x_i, y_i, dL, dW);
            dy_Sc_mat_v(:,:,i_xi_a,i_eta_a,ii) = dy_Sc_mat( x_i, y_i, dL, dW);
            dx2_Sc_mat_v(:,:,i_xi_a,i_eta_a,ii) = dx2_Sc_mat( x_i, y_i, dL, dW);
            dy2_Sc_mat_v(:,:,i_xi_a,i_eta_a,ii) = dy2_Sc_mat( x_i, y_i, dL, dW);
            dxy_Sc_mat_v(:,:,i_xi_a,i_eta_a,ii) = dxy_Sc_mat( x_i, y_i, dL, dW);
            
            i_eta_a = i_eta_a+1;
        end
        i_xi_a = i_xi_a+1;
    end
    
    dx_n_Sc_struct(ii).dx_Sc_mat_v_o = dx_Sc_mat_v(:,:,:,:,ii);                   
    dx_n_Sc_struct(ii).dy_Sc_mat_v_o = dy_Sc_mat_v(:,:,:,:,ii);
    dx_n_Sc_struct(ii).dx2_Sc_mat_v_o = dx2_Sc_mat_v(:,:,:,:,ii);
    dx_n_Sc_struct(ii).dy2_Sc_mat_v_o = dy2_Sc_mat_v(:,:,:,:,ii);
    dx_n_Sc_struct(ii).dxy_Sc_mat_v_o = dxy_Sc_mat_v(:,:,:,:,ii);
        
    %%[*] 0成分は除く (Sc*q = [ S1*I S2*I ... S12*I]*q = S1*q1_r + S2*q1_dx_r + ... + S12*q4_dy_r, I∈R^3*3, qi_r,qi_dx_r,qi_dy_r∈R^3)
    dx_n_Sc_struct(ii).dx_Sc_mat_v = repmat( dx_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1]);                   
    dx_n_Sc_struct(ii).dy_Sc_mat_v = repmat( dy_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1]);
    dx_n_Sc_struct(ii).dx2_Sc_mat_v = repmat( dx2_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1]);
    dx_n_Sc_struct(ii).dy2_Sc_mat_v = repmat( dy2_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1]);
    dx_n_Sc_struct(ii).dxy_Sc_mat_v = repmat( dxy_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1]);  
    
    %%[*] 0成分は除く (Sc*q = [ S1*I S2*I ... S12*I]*q = S1*q1_r + S2*q1_dx_r + ... + S12*q4_dy_r, I∈R^3*3, qi_r,qi_dx_r,qi_dy_r∈R^3)
    dx_n_Sc_struct(ii).dx_Sc_mat_v2 = repmat( dx_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1 N_q]);                   
    dx_n_Sc_struct(ii).dy_Sc_mat_v2 = repmat( dy_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1 N_q]);
    dx_n_Sc_struct(ii).dx2_Sc_mat_v2 = repmat( dx2_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1 N_q]);
    dx_n_Sc_struct(ii).dy2_Sc_mat_v2 = repmat( dy2_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1 N_q]);
    dx_n_Sc_struct(ii).dxy_Sc_mat_v2 = repmat( dxy_Sc_mat_v(1,1:3:end,:,:,ii), [ 3 1 1 1 N_q]);
    
    dx_n_Sc_struct(ii).dx_Sc_dx_Sc_mat = mntimes( permute( dx_Sc_mat_v(:,:,:,:,ii), [ 2 1 3 4]), dx_Sc_mat_v(:,:,:,:,ii), 1, 2);
    dx_n_Sc_struct(ii).dy_Sc_dy_Sc_mat = mntimes( permute( dy_Sc_mat_v(:,:,:,:,ii), [ 2 1 3 4]), dy_Sc_mat_v(:,:,:,:,ii), 1, 2);
    dx_n_Sc_struct(ii).dx_Sc_dy_Sc_mat = mntimes( permute( dx_Sc_mat_v(:,:,:,:,ii), [ 2 1 3 4]), dy_Sc_mat_v(:,:,:,:,ii), 1, 2);
    dx_n_Sc_struct(ii).dy_Sc_dx_Sc_mat = mntimes( permute( dy_Sc_mat_v(:,:,:,:,ii), [ 2 1 3 4]), dx_Sc_mat_v(:,:,:,:,ii), 1, 2);
    dx_n_Sc_struct(ii).dxSc_dySc_p_dySc_dxSc_mat = dx_n_Sc_struct(ii).dx_Sc_dy_Sc_mat + dx_n_Sc_struct(ii).dy_Sc_dx_Sc_mat;
    
    
    dqdq_eps_v = zeros( N_q, 3, length( p_vec), length( p_vec), N_q); 
    dqdq_eps_v(:,1,:,:,:) = permute( dx_n_Sc_struct(ii).dx_Sc_dx_Sc_mat, [ 1 3 4 2]);
    dqdq_eps_v(:,2,:,:,:) = permute( dx_n_Sc_struct(ii).dy_Sc_dy_Sc_mat, [ 1 3 4 2]);
    dqdq_eps_v(:,3,:,:,:) = permute( dx_n_Sc_struct(ii).dxSc_dySc_p_dySc_dxSc_mat, [ 1 3 4 2]);
    dx_n_Sc_struct(ii).dqdq_eps_v = dqdq_eps_v;
end


%% [1] Mass matrix (M_mat = ∬_A S(x,y)^t*S(x,y) dA)


M_mat_i = zeros(N_q,N_q,N_element);
for ii = 1:N_element
    
    disp( [ 'Node number:', int2str( ii), '/', int2str( N_element)]);
    
    dL = dL_vec(ii);                        %% ii要素の長さ [-]
    dW = dW_vec(ii);                        %% ii要素の幅 [-]

            
    int_StS = zeros(N_q);
    i_xi_a = 1;
    for xi_a = p_vec                        %% Gauss-Legendre求積
        i_eta_a = 1;
        for eta_a = p_vec
            
            StS = Sc_mat_v(:,:,i_xi_a,i_eta_a,ii).'*Sc_mat_v(:,:,i_xi_a,i_eta_a,ii);
            int_StS = int_StS + dL*dW/4*w_vec(i_xi_a)*w_vec(i_eta_a)*StS;
            i_eta_a = i_eta_a+1;
        end
        i_xi_a = i_xi_a+1;
    end
    M_mat_i(:,:,ii) = rho_m*thick*int_StS;  %% ii要素の質量行列
end



%% [2] 重力 (Qf = ∫_A S(x,y)^t*F dA, F ∈ R^3)

Qf_vec_i = zeros(N_q,N_element);
for ii = 1:N_element
    
    disp( [ 'Node number:', int2str( ii), '/', int2str( N_element)]);

    dL = dL_vec(ii);                        %% ii要素の長さ [-]
    dW = dW_vec(ii);                        %% ii要素の幅 [-]
            
    int_StF = zeros(N_q,1);
    i_xi_a = 1;
    for xi_a = p_vec                        %% Gauss-Legendre求積
        i_eta_a = 1;
        for eta_a = p_vec
            
            StF = Sc_mat_v(:,:,i_xi_a,i_eta_a,ii).'*F_in;
            int_StF = int_StF + dL*dW/4*w_vec(i_xi_a)*w_vec(i_eta_a)*StF;
            i_eta_a = i_eta_a+1;
        end
        i_xi_a = i_xi_a+1;
    end
    Qf_vec_i(:,ii) = thick*int_StF;         %% ii要素の外力行列
end


%% [3] グローバル行列組立

M_global = sparse(N_q_all,N_q_all);
Qf_global = zeros(N_q_all,1);
for ii = 1:N_element

    %% 1ノード当たり9成分 ( q_i = [ rx_i ry_i rz_i : dx_rx_i dx_ry_i dx_rz_i : dy_rx_i dy_ry_i dy_rz_i]^T ∈ R^9 )
    %% 1要素当たり36成分　( q := [ q_i1^T q_i2^T q_i3^T q_i4^T]^T ∈ R^36 )    
    i_vec = i_vec_v{ii};
    
    M_global(i_vec,i_vec) = M_global(i_vec,i_vec) + squeeze( M_mat_i(:,:,ii));
    Qf_global(i_vec,1) = Qf_global(i_vec,1) + Qf_vec_i(:,ii);
end

