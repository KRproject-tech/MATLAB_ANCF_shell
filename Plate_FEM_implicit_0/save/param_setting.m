%% parameters


%% 解析条件
End_Time = 0.3;             %% 解析時間 [s]
d_t = 5e-4;                 %% 刻み時間 [s]
core_num = 6;               %% CPU数 [-]
movie_format = 'wmv';     %% 動画保存形式 [-]
% movie_format = 'mpeg';     %% 動画保存形式 [-]
% movie_format = 'avi';
alpha_v = 0.5;              %% 1:陰解法，0:陽解法 [-]
speed_check = 0;            %% 計算速度確認：1:ON, 0:OFF [-]
explicit_flag = 0;          %% 膜弾性力の陰解法無効化フラグ（陽解法）[-]



%% 平板パラメータ

rho_m = 7810;           	%% 平板密度 [kg/m^3]
Eelastic = 1e+5;        	%% ヤング率 [Pa]
nu = 0.3;                   %% ポアソン比 [-]
theta = 0;                  %% 構造減衰パラメータ [s]

Length = 300e-3;          	%% 全長 [m]
Width = 300e-3;             	%% 幅 [m]
thick = 10e-3;           	%% 肉厚 [m]
Nx = 15;                   	%% x方向要素数 [-]
Ny = 15;                   	%% y方向要素数 [-]
N_gauss = 5;                %% Gauss-Legendre求積の次数 [-]

g = 9.81;                   %% 重力加速度 [m/s^2]
F_in = -rho_m*g*[ 0 0 1].';	%% 重力(体積力) [N/m^3]

x_vec = (0:Nx)/Nx*Length;   %% ノードのx座標(要素座標系)の刻み範囲 [m]
y_vec = (0:Ny)/Ny*Width;    %% ノードのy座標(要素座標系)の刻み範囲 [m]
N_element = Nx*Ny;          %% 全要素数 [-]

Dm_mat = Eelastic/(1 - nu^2)*[  1   nu  0;
                                nu  1   0;
                                0   0   (1 - nu)/2];
Dk_mat = thick^3/12*Dm_mat;


%% 平板境界条件

node_r_0 = [ 1];          	%% 変位拘束を与えるノード番号 [-]
node_dxr_0 = [ ];        	%% x方向勾配拘束を与えるノード番号 [-]
node_dyr_0 = [ ];       	%% y方向勾配拘束を与えるノード番号 [-]


%% スナップショット条件

i_snapshot = 200;               %% スナップショットplot刻み
Snapshot_tmax = 0.3;            %% スナップショットplot時間 [s]



%% global 変数
global var_param

var_param.node_r_0 = node_r_0;
var_param.node_dxr_0 = node_dxr_0;
var_param.node_dyr_0 = node_dyr_0;

var_param.d_t = d_t;
var_param.alpha_v = alpha_v;
var_param.theta = theta;