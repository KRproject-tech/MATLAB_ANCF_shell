clc
clear all
close all hidden

%% delete
delete( '*.asv')


%% compute original size

%%[0] �I���W�i���T�C�Y
mat_variables = whos('-file','./save/NUM_DATA.mat');

original_Byte = 0;
for ii = 1:length( mat_variables)
    original_Byte = original_Byte + mat_variables(ii).bytes;
end
original_GByte = original_Byte*1e-9;                                        %% �I���W�i���T�C�Y [GB] (�����k�̎���mat�t�@�C���̃T�C�Y)


%% load
disp( 'Now loading ...')
N_variable = length( mat_variables);
for i_num = 1:N_variable
    
    mat_variables_name = mat_variables(i_num,1).name;
    mat_variables_class = mat_variables(i_num,1).class;
    
    %%[*] �傫��mat�t�@�C���ł́C�֐��ǂݍ��ݎ���matlab��������D
    if ~strcmp( mat_variables_class, 'function_handle') && ~strcmp( mat_variables_name, 'original_GByte')
        
        load( './save/NUM_DATA', mat_variables_name)
        disp( mat_variables_name)
    end
    
end
clear i_num N_variable mat_variables mat_variables_name mat_variables_class original_Byte


%%[1] �s�v�ȕϐ��̍팸
clear dx_n_Sc_struct  
%%[2] �P���x���������_�ɕύX
h_X_vec = single( h_X_vec);
h_X_vec(N_q_all+1:end,:) = [];                                              %% ���x�����폜


%% save
save ./save/NUM_DATA


%% �팸��̃f�[�^�T�C�Y
mat_variables = whos('-file','./save/NUM_DATA.mat');

reduced_Byte = 0;
for ii = 1:length( mat_variables)
    reduced_Byte = reduced_Byte + mat_variables(ii).bytes;
end
reduced_GByte = reduced_Byte*1e-9;                                        %% �팸��̃T�C�Y [GB] (�����k�̎���mat�t�@�C���̃T�C�Y)


%% �\��
disp( [ 'Reduced size : ', num2str( reduced_GByte/original_GByte*100, '%0.1f'), ' [%]'])