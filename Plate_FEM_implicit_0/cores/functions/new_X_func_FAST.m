function [ out, out1] = new_X_func_FAST( X_vec, m_global_struct, qf_global_struct, dq_qe_global_struct, qe_global_struct, qd_global_struct, var_param, stage, out1)


%% [0] �ϐ����o
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
M_global = m_global_struct.M_global;                                        %% ���ʍs��     : M (���ʁ{���g�̃V�[�g����̕t�����ʌ��� [ Madd_1 Madd_2]*d_t^2[ q_1^T q_2^T]^T -> Madd_1*d_t^2 q_1)
Qf_global = qf_global_struct.Qf_global;                                     %% �̐ϗ�       : Q_f
dq_Qe_global = dq_qe_global_struct.dq_Qe_global;                            %% dq_Qe(q(n))
Qe_global = qe_global_struct.Qe_global;                                     %% ������       : Q_e
Qd_global = qd_global_struct.Qd_global;                                     %% ������       : Q_d




%% [1] ���E����

%%[*] 0�l�Œ�
%%[1-0] �ψʋ��E����
if ~isempty( node_r_0)
    i_r = repmat( ( N_qi*(node_r_0 - 1)+1 ).', [ 1 3]) + repmat( 0:2, [ length( node_r_0) 1]);                  %% �ψʍS����������m�[�h�ɑΉ�����x,y�ψʐ����ԍ�(z=0 [m])
    i_r = reshape(i_r.',1,[]);
else
    i_r = [];
end

%%[1-1] ���z���E���� (x����)
if ~isempty( node_dxr_0)
    i_dx_r = repmat( ( N_qi*(node_dxr_0 - 1)+4 ).', [ 1 3]) + repmat( 0:2, [ length( node_dxr_0) 1]);           %% dx_r = [1 0 0]^T�D
    i_dx_r = reshape(i_dx_r.',1,[]);
else
    i_dx_r = [];
end

%%[1-2] ���z���E���� (y����)
if ~isempty( node_dyr_0)
    i_dy_r = repmat( ( N_qi*(node_dyr_0 - 1)+7 ).', [ 1 3]) + repmat( 0:2, [ length( node_dyr_0) 1]);           %% dy_r = [0 1 0]^T�D
    i_dy_r = reshape(i_dy_r.',1,[]);
else
    i_dy_r = [];
end



%%[*] ����l�ɍS��    
Fmat = speye( N_q_all); 



i_vec = [ i_r i_dx_r i_dy_r];

%% [2] �����xdtt_q�Z�o

Q_global = (Qf_global - Qe_global);                                                                     %% ���́{�O�͍�

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
if stage == 0                                                                                           %% 1��ڂ̌v�Z�l���g���܂킷�D
    C_damp = (theta == 0)*2 + ~(theta == 0)*1;                                                          %% ����������Ƃ��͔��A��@
%     C_damp = 1;                                                                                         %% �����A��@
    D_matrix = [ eye_mat                                    zero_mat;
                 (Qd_global + C_damp*d_t/2*dq_Qe_global)  	M_global];                                  %% ����0�ŒP�ʍs��ɂȂ�D
     out1.D_matrix = D_matrix;
else
    D_matrix = out1.D_matrix;
end
X2_matrix = [ zero_mat      eye_mat;
              zero_mat      zero_mat];
A_mat1 = D_matrix - alpha_v*d_t*X2_matrix;
A_mat2 = D_matrix + (1 - alpha_v)*d_t*X2_matrix;




%%[2-0] �Œ蕔�̃m�[�h�ł� dt_q = 0, dtt_q = 0
not_i_vec = (1:N_q_all);
not_i_vec(i_vec) = [];


%% [3] ��ԃx�N�g���X�V

if stage == 0                                                                                           %% 1��ڂ̌v�Z�l���g���܂킷�D
    out1.A1_A2_Xn = A_mat1\( A_mat2*X_vec([ not_i_vec N_q_all+not_i_vec]) );
end
out_0 = out1.A1_A2_Xn + A_mat1\( d_t*[ zero_mat(:,1);
                                       Q_global]);
                    
out = X_vec;
out([ not_i_vec N_q_all+not_i_vec]) = out_0;
out = blkdiag( Fmat, Fmat)*out;

end