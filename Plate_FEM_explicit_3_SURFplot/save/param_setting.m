%% parameters


%% ðÍð
End_Time = 1.0;             %% ðÍÔ [s]
d_t = 1e-4;                 %% ÝÔ [s]
core_num = 6;               %% CPU [-]
movie_format = 'mpeg';     %% ®æÛ¶`® [-]
% movie_format = 'avi';
speed_check = 0;            %% vZ¬xmFF1:ON, 0:OFF [-]

%% ½Âp[^

rho_m = 1000;           	%% ½Â§x [kg/m^3]
Eelastic = 1e+3;        	%% O¦ [Pa]
nu = 0.3;                   %% |A\ä [-]

Length = 100e-3;          	%% S· [m]
Width = 100e-3;             	%%  [m]
thick = 10e-3;           	%% ÷ú [m]
Nx = 8;                   	%% xûüvf [-]
Ny = 8;                   	%% yûüvf [-]
N_gauss = 5;                %% Gauss-LegendreÏÌ [-]

g = 9.81;                   %% dÍÁ¬x [m/s^2]
F_in = -rho_m*g*[ 0 0 1].';	%% dÍ(ÌÏÍ) [N/m^3]

x_vec = (0:Nx)/Nx*Length;   %% m[hÌxÀW(vfÀWn)ÌÝÍÍ [m]
y_vec = (0:Ny)/Ny*Width;    %% m[hÌyÀW(vfÀWn)ÌÝÍÍ [m]
N_element = Nx*Ny;          %% Svf [-]

Dm_mat = Eelastic/(1 - nu^2)*[  1   nu  0;
                                nu  1   0;
                                0   0   (1 - nu)/2];
Dk_mat = thick^3/12*Dm_mat;


%% ½Â«Eð

node_r_0 = [ 1];          	%% ÏÊS©ð^¦ém[hÔ [-]
node_dxr_0 = [ ];        	%% xûüùzS©ð^¦ém[hÔ [-]
node_dyr_0 = [ ];       	%% yûüùzS©ð^¦ém[hÔ [-]


%% XibvVbgð

i_snapshot = 500;               %% XibvVbgplotÝ
Snapshot_tmax = 0.4;            %% XibvVbgplotÔ [s]



%% global Ï
global var_param

var_param.node_r_0 = node_r_0;
var_param.node_dxr_0 = node_dxr_0;
var_param.node_dyr_0 = node_dyr_0;