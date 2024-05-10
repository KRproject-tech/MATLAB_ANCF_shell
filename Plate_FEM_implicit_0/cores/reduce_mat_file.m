clc
clear all
close all hidden

%% delete
delete( '*.asv')


%% compute original size

%%[0] オリジナルサイズ
mat_variables = whos('-file','./save/NUM_DATA.mat');

original_Byte = 0;
for ii = 1:length( mat_variables)
    original_Byte = original_Byte + mat_variables(ii).bytes;
end
original_GByte = original_Byte*1e-9;                                        %% オリジナルサイズ [GB] (未圧縮の時のmatファイルのサイズ)


%% load
disp( 'Now loading ...')
N_variable = length( mat_variables);
for i_num = 1:N_variable
    
    mat_variables_name = mat_variables(i_num,1).name;
    mat_variables_class = mat_variables(i_num,1).class;
    
    %%[*] 大きいmatファイルでは，関数読み込み時にmatlabが落ちる．
    if ~strcmp( mat_variables_class, 'function_handle') && ~strcmp( mat_variables_name, 'original_GByte')
        
        load( './save/NUM_DATA', mat_variables_name)
        disp( mat_variables_name)
    end
    
end
clear i_num N_variable mat_variables mat_variables_name mat_variables_class original_Byte


%%[1] 不要な変数の削減
clear dx_n_Sc_struct  
%%[2] 単精度浮動小数点に変更
h_X_vec = single( h_X_vec);
h_X_vec(N_q_all+1:end,:) = [];                                              %% 速度成分削除


%% save
save ./save/NUM_DATA


%% 削減後のデータサイズ
mat_variables = whos('-file','./save/NUM_DATA.mat');

reduced_Byte = 0;
for ii = 1:length( mat_variables)
    reduced_Byte = reduced_Byte + mat_variables(ii).bytes;
end
reduced_GByte = reduced_Byte*1e-9;                                        %% 削減後のサイズ [GB] (未圧縮の時のmatファイルのサイズ)


%% 表示
disp( [ 'Reduced size : ', num2str( reduced_GByte/original_GByte*100, '%0.1f'), ' [%]'])