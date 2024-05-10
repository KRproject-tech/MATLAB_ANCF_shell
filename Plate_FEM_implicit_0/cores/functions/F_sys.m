function f_sys = F_sys( X_vec, M_global, Qf_global, Qe_global, var_param)


%% [0] �ϐ����o
node_r_0 = var_param.node_r_0;
node_dxr_0 = var_param.node_dxr_0;
node_dyr_0 = var_param.node_dyr_0;
coordinates = var_param.coordinates;

N_qi = var_param.N_qi; 
N_q_all = var_param.N_q_all;
dt_q_vec = X_vec(N_q_all+1:end);





%% [1] ���E����
%%[1-0] �ψʋ��E����
if ~isempty( node_r_0)
    i_r = repmat( ( N_qi*(node_r_0 - 1)+1 ).', [ 1 3]) + repmat( 0:2, [ length( node_r_0) 1]);        %% �ψʍS����������m�[�h�ɑΉ�����x,y�ψʐ����ԍ�(z=0 [m])
    i_r = reshape(i_r.',1,[]);
else
    i_r = [];
end

%%[1-1] ���z���E���� (x����)
if ~isempty( node_dxr_0)
    i_dx_r = repmat( ( N_qi*(node_dxr_0 - 1)+4 ).', [ 1 3]) + repmat( 0:2, [ length( node_dxr_0) 1]);	%% dx_r = [1 0 0]^T�D
    i_dx_r = reshape(i_dx_r.',1,[]);
else
    i_dx_r = [];
end

%%[1-2] ���z���E���� (y����)
if ~isempty( node_dyr_0)
    i_dy_r = repmat( ( N_qi*(node_dyr_0 - 1)+7 ).', [ 1 3]) + repmat( 0:2, [ length( node_dyr_0) 1]);	%% dy_r = [0 1 0]^T�D
    i_dy_r = reshape(i_dy_r.',1,[]);
else
    i_dy_r = [];
end

i_vec = [ i_r i_dx_r i_dy_r];

%% [2] �����xdtt_q�Z�o

Q_global = (Qf_global - Qe_global);                                                                     %% ���́{�O�͍�


M_global(i_vec,:) = [];
M_global(:,i_vec) = [];
Q_global(i_vec) = []; 


%%[2-0] �Œ蕔�̃m�[�h�ł� dt_q = 0, dtt_q = 0
dt_q_vec(i_vec) = zeros(length( i_vec),1);

dtt_q_vec = zeros(N_q_all,1);
n_i_vec = (1:N_q_all);
n_i_vec(i_vec) = [];
dtt_q_vec(n_i_vec) = M_global\Q_global;

%% [3] ��ԕ������E��
f_sys = [ dt_q_vec;
          dtt_q_vec];

end