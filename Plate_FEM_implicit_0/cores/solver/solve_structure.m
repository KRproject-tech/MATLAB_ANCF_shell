%% �ϐ����o
X_vec = h_X_vec(:,i_time);
q_vec = X_vec(1:N_q_all,1);
dt_q_vec = X_vec(N_q_all+1:end,1);


%% �\���q�v�Z (�V���������̏�Ԃ����߂�)


%%[0] �S�e���x�N�g���̑g�� Qe^(n)
flag_output = 1;                                                            %% �����s��Z�o�̗L����
generate_stiff_matrices;

Qk_global_n = Qk_global;
Qe_global_n = Qe_global;
dq_Qe_global_n = dq_Qe_global;
Qd_global_n = Qd_global;



%%[1] �\���q�v�Z
%%[1-0] ���ʍs��     : M
m_global_struct.M_global = M_global;
%%[1-1] �̐ϗ�       : Q_f
qf_global_struct.Qf_global = Qf_global;
%%[1-2] dq_Qe(q(n))
dq_qe_global_struct.dq_Qe_global = dq_Qe_global_n;
%%[1-3] ������       : Q_e
qe_global_struct.Qe_global = Qe_global_n + Qk_global_n;
%%[1-4] ������       : Q_d
qd_global_struct.Qd_global = Qd_global_n;


[ X_vec_p, out1] = new_X_func_FAST( X_vec, m_global_struct, qf_global_struct, dq_qe_global_struct, qe_global_struct, qd_global_struct, var_param, 0, []);

         


%% �C���q�v�Z (�V���������̍����� Qe^(n+1) �̌��ŉ���)

q_vec = X_vec_p(1:N_q_all,1);
dt_q_vec = X_vec_p(N_q_all+1:end,1);



%%[0] �S�e���x�N�g���̑g�� Qe^(n+1)
flag_output = 0;                                                            %% �����s��Z�o�̖�����
generate_stiff_matrices;
Qk_global_np1 = Qk_global;



%%[1-0] ���ʍs��     : M
m_global_struct.M_global = M_global;

%%%(�C���O) Ma=1, Ua25, Nx=18, Ny=10 �ŃJ�I�X�U��������
%%[1-1] �̐ϗ�       : Q_f
qf_global_struct.Qf_global = Qf_global;
%%[1-2] dq_Qe(q(n))
dq_qe_global_struct.dq_Qe_global = dq_Qe_global_n;
%%[1-3] ������       : Q_e
%%[*] Qe(q(n+1)) = Qe(q(n)) + ��t*dq_Qe(q(n))*dt_q(n+1)
qe_global_struct.Qe_global = Qe_global_n + (Qk_global_n + Qk_global_np1)/2;
%%[1-4] ������       : Q_d
qd_global_struct.Qd_global = Qd_global_n;


%%[*] Qe(q(n+1)) = Qe(q(n)) + ��t*dq_Qe(q(n))*dt_q(n+1)
new_X_vec = new_X_func_FAST( X_vec, m_global_struct, qf_global_struct, dq_qe_global_struct, qe_global_struct, qd_global_struct, var_param, 1, out1);

h_X_vec(:,i_time+1) = new_X_vec;                                            %% (Qe^(n)+Qe^(n+1))/2�̌��ŉ����� X(n+1) 


%% ���U�������͉�͂��~
if sum( isnan( X_vec))

    warndlg( 'Divergence!!') 
%     break;
end

