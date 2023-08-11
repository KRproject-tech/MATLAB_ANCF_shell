%% parameters


%% ��͏���
End_Time = 1.0;             %% ��͎��� [s]
d_t = 1e-4;                 %% ���ݎ��� [s]
core_num = 6;               %% CPU�� [-]
movie_format = 'mpeg';     %% ����ۑ��`�� [-]
% movie_format = 'avi';
speed_check = 0;            %% �v�Z���x�m�F�F1:ON, 0:OFF [-]

%% ���p�����[�^

rho_m = 1000;           	%% �����x [kg/m^3]
Eelastic = 1e+3;        	%% �����O�� [Pa]
nu = 0.3;                   %% �|�A�\���� [-]

Length = 100e-3;          	%% �S�� [m]
Width = 100e-3;             	%% �� [m]
thick = 10e-3;           	%% ���� [m]
Nx = 8;                   	%% x�����v�f�� [-]
Ny = 8;                   	%% y�����v�f�� [-]
N_gauss = 5;                %% Gauss-Legendre���ς̎��� [-]

g = 9.81;                   %% �d�͉����x [m/s^2]
F_in = -rho_m*g*[ 0 0 1].';	%% �d��(�̐ϗ�) [N/m^3]

x_vec = (0:Nx)/Nx*Length;   %% �m�[�h��x���W(�v�f���W�n)�̍��ݔ͈� [m]
y_vec = (0:Ny)/Ny*Width;    %% �m�[�h��y���W(�v�f���W�n)�̍��ݔ͈� [m]
N_element = Nx*Ny;          %% �S�v�f�� [-]

Dm_mat = Eelastic/(1 - nu^2)*[  1   nu  0;
                                nu  1   0;
                                0   0   (1 - nu)/2];
Dk_mat = thick^3/12*Dm_mat;


%% �����E����

node_r_0 = [ 1];          	%% �ψʍS����^����m�[�h�ԍ� [-]
node_dxr_0 = [ ];        	%% x�������z�S����^����m�[�h�ԍ� [-]
node_dyr_0 = [ ];       	%% y�������z�S����^����m�[�h�ԍ� [-]


%% �X�i�b�v�V���b�g����

i_snapshot = 500;               %% �X�i�b�v�V���b�gplot����
Snapshot_tmax = 0.4;            %% �X�i�b�v�V���b�gplot���� [s]



%% global �ϐ�
global var_param

var_param.node_r_0 = node_r_0;
var_param.node_dxr_0 = node_dxr_0;
var_param.node_dyr_0 = node_dyr_0;