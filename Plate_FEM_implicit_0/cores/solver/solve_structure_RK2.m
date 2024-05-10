%% [3-0] �ϐ����o
X_vec = h_X_vec(:,i_time);
q_vec = X_vec(1:N_q_all,1);

%% [3-1] �����s��̑g��
flag_output = 1;                                                            %% �����s��Z�o�̗L����
generate_stiff_matrices;
Qe_global = Qe_global + Qk_global;

%% [3-2] ���Ԕ��W (Euler�̗\���q�C���q�@)
f_sys = F_sys( X_vec, M_global, Qf_global, Qe_global, var_param);
if i_time == 1
   old_fsys = f_sys;
end

%% [3-2-0] �\���q�̌v�Z
X_vec_p = X_vec + d_t*( 3/2*f_sys - 1/2*old_fsys );
old_fsys = f_sys;

q_vec = X_vec_p(1:N_q_all,1);

%% [3-2-1] �����s��̑g��
flag_output = 1;                                                            %% �����s��Z�o�̗L����
generate_stiff_matrices;
Qe_global = Qe_global + Qk_global;

fsys_np1 = F_sys( X_vec_p, M_global, Qf_global, Qe_global, var_param);
new_X_vec = X_vec + d_t/2*(fsys_np1 + f_sys);


h_X_vec(:,i_time+1) = new_X_vec;


%% ���U�������͉�͂��~
if sum( isnan( X_vec))

    warndlg( 'Divergence!!') 
%     break;
end

