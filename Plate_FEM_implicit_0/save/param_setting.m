%% parameters


%% ðÍð
End_Time = 0.3;             %% ðÍÔ [s]
d_t = 5e-4;                 %% ÝÔ [s]
core_num = 6;               %% CPU [-]
movie_format = 'wmv';     %% ®æÛ¶`® [-]
% movie_format = 'mpeg';     %% ®æÛ¶`® [-]
% movie_format = 'avi';
alpha_v = 0.5;              %% 1:Að@C0:zð@ [-]
speed_check = 0;            %% vZ¬xmFF1:ON, 0:OFF [-]
explicit_flag = 0;          %% e«ÍÌAð@³ø»tOizð@j[-]



%% ½Âp[^

rho_m = 7810;           	%% ½Â§x [kg/m^3]
Eelastic = 1e+5;        	%% O¦ [Pa]
nu = 0.3;                   %% |A\ä [-]
theta = 0;                  %% \¢¸p[^ [s]

Length = 300e-3;          	%% S· [m]
Width = 300e-3;             	%%  [m]
thick = 10e-3;           	%% ÷ú [m]
Nx = 15;                   	%% xûüvf [-]
Ny = 15;                   	%% yûüvf [-]
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

i_snapshot = 200;               %% XibvVbgplotÝ
Snapshot_tmax = 0.3;            %% XibvVbgplotÔ [s]



%% global Ï
global var_param

var_param.node_r_0 = node_r_0;
var_param.node_dxr_0 = node_dxr_0;
var_param.node_dyr_0 = node_dyr_0;

var_param.d_t = d_t;
var_param.alpha_v = alpha_v;
var_param.theta = theta;