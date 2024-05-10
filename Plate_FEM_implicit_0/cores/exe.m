clc
clear all
close all

%% delete
delete( '*.asv')

%% path
add_pathes

%% parameter
param_setting

%% multi threading
maxNumCompThreads( core_num);


%% exe

%%[0] Definition of shape functions
generate_shape_function;

%%[1] Mesh generation
generate_elements;

%%[2] Matrix generation
generate_matrices;



%%[3] ���Ԕ��W [s]

time_m = 0:d_t:End_Time;
h_X_vec = zeros(2*N_q_all,length( time_m));

idx_r = reshape( [1:N_qi:N_q_all; 2:N_qi:N_q_all], 1, []);                      %% �����`��ł̃m�[�h���W���� [m]
h_X_vec(idx_r,1) = reshape( coordinates.',[],1);
idx_dx_r = reshape( [4:N_qi:N_q_all; 5:N_qi:N_q_all; 6:N_qi:N_q_all], 1, []); 	% �����`��ł�x�����̌��z���� (dx_r = [1 0 0]^T [-])
h_X_vec(idx_dx_r,1) = repmat( [1 0 0].', [ N_node 1]);
idx_dy_r = reshape( [7:N_qi:N_q_all; 8:N_qi:N_q_all; 9:N_qi:N_q_all], 1, []); 	% �����`��ł�y�����̌��z���� (dy_r = [0 1 0]^T [-])
h_X_vec(idx_dy_r,1) = repmat( [0 1 0].', [ N_node 1]);


%%[*] �v�Z���x�m�F
if speed_check == 1
    time_m = time_m(1:30);
    profile on;
end

tic
i_time = 1;
for time = time_m
    
    disp( [ 'Time = ', num2str( time, '%0.4f'), ' [s]'])


    if explicit_flag
        %%[1] �\�����(���e���͂ɂ��ėz��@�ŉ���)
        solve_structure_explicit;  
    else        
        %%[1] �\�����(���e���͂ɂ��ĉA��@�ŉ���)
        solve_structure; 
    end
    
    %%[2] �G�l���M�v�Z [W]
    solve_energy;
    
    
    %%[3-3] ���U�������͉�͂��~
    if sum( isnan( X_vec))

        time_m = 0:d_t:time;
        h_X_vec = h_X_vec(:,1:length( time_m));
        h_X_vec = h_X_vec(:,abs( sum( h_X_vec, 1)) < 1e+3);
        warndlg( 'Divergence!!') 
        break;
    end
   
    i_time = i_time + 1;
end
toc

%% save 

%%[*] �v�Z���x�m�F
if speed_check == 1
    profile viewer;
else
    save ./save/NUM_DATA
end