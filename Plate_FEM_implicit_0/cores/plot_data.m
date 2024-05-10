clc
clear all
close all

%% delete
delete( '*.asv')


%% path
add_pathes

%% parameter
param_setting
tmp_movie_format = movie_format;
tmp_Snapshot_tmax = Snapshot_tmax;
tmp_i_snapshot = i_snapshot;

%% multi threading
maxNumCompThreads( core_num);

%% load
load ./save/NUM_DATA
movie_format = tmp_movie_format;
Snapshot_tmax = tmp_Snapshot_tmax;
i_snapshot = tmp_i_snapshot;

%% plot

i_ax = 1;


%% [0] Plotting the Finite Element Mesh
X = zeros(4,N_element) ;
Y = zeros(4,N_element) ;

for ii = 1:N_element
    X(:,ii) = coordinates(nodes(ii,:),1) ;
    Y(:,ii) = coordinates(nodes(ii,:),2) ;
end



h_fig(1) = figure(1);
set( h_fig(1), 'Position', [100 100 600 300])
h_ax(i_ax) = axes( 'Parent', h_fig(1), 'FontSize', 15);

patch( X, Y, 'w', 'Parent', h_ax(i_ax))
axis( h_ax(i_ax), 'equal')
xlabel( h_ax(i_ax), '{\itx} position [m]', 'FontName', 'Times New Roman', 'FontSize', 15)
ylabel( h_ax(i_ax), '{\ity} position [m]', 'FontName', 'Times New Roman', 'FontSize', 15)

set( h_ax(i_ax), 'FontName', 'Times New Roman')

i_ax = i_ax + 1;





%% [1] Plotting the nodes

h_fig(2) = figure(2);
set( h_fig(2), 'Position', [700 100 700 500], 'render', 'zbuffer')
h_ax(i_ax) = axes( 'Parent', h_fig(2), 'FontSize', 15);



h_txt(1) = text( 0, Width, 0, [ 'Time = ', num2str( 0, '%0.3f'), ' [s]'],...
                'FontSize', 12, 'FontName', 'Times New Roman', 'BackgroundColor', 'g');
hold( h_ax(i_ax), 'on')

            
idx_r = reshape( [1:N_qi:N_q_all; 2:N_qi:N_q_all; 3:N_qi:N_q_all], 1, []);                

r_vec = reshape( h_X_vec(idx_r,1), 3, []);

X = reshape( r_vec(1:3:end).', Ny+1, []).';
Y = reshape( r_vec(2:3:end).', Ny+1, []).';
Z = reshape( r_vec(3:3:end).', Ny+1, []).';                        

h_plot(1) = surf( X, Y, Z, 'Parent', h_ax(i_ax), 'FaceColor', 'r');
% h_plot(1) = patch( 0, 0, 0, 'r', 'Parent', h_ax(i_ax));

% light
% lighting gouraud 
view( h_ax(i_ax), [1 2 1])
axis( h_ax(i_ax), 'equal')
grid( h_ax(i_ax), 'on')
xlim( h_ax(i_ax), [-Length 2*Length])
ylim( h_ax(i_ax), [-Width 2*Width])
zlim( h_ax(i_ax), [-Length 0])
xlabel( h_ax(i_ax), '{\itX} position [m]', 'FontName', 'Times New Roman', 'FontSize', 15)
ylabel( h_ax(i_ax), '{\itY} position [m]', 'FontName', 'Times New Roman', 'FontSize', 15)
zlabel( h_ax(i_ax), '{\itZ} position [m]', 'FontName', 'Times New Roman', 'FontSize', 15)
set( h_ax(i_ax), 'FontName', 'Times New Roman')

i_ax = i_ax + 1;



h_fig(3) = figure(3);
set( h_fig(3), 'Position', [100 500 700 500])
h_ax(i_ax) = axes( 'Parent', h_fig(3), 'FontSize', 15);

% light
% lighting gouraud 
view( h_ax(i_ax), [1 2 1])
axis( h_ax(i_ax), 'equal')
grid( h_ax(i_ax), 'on')
xlim( h_ax(i_ax), [-1.5*Length 2*Length])
ylim( h_ax(i_ax), [-1.5*Width 2*Width])
zlim( h_ax(i_ax), [-1.5*Length 0])
xlabel( h_ax(i_ax), '{\itX} position [m]', 'FontName', 'Times New Roman', 'FontSize', 15)
ylabel( h_ax(i_ax), '{\itY} position [m]', 'FontName', 'Times New Roman', 'FontSize', 15)
zlabel( h_ax(i_ax), '{\itZ} position [m]', 'FontName', 'Times New Roman', 'FontSize', 15)
set( h_ax(i_ax), 'FontName', 'Times New Roman')

i_ax = i_ax + 1;





movie_data = struct( 'cdata', [], 'colormap', []);
i_time = 1;
i_movie = 1;
idx_r = reshape( [1:N_qi:N_q_all; 2:N_qi:N_q_all; 3:N_qi:N_q_all], 1, []);                
for time = time_m
    
    if mod( i_time, 5) == 0
        
        disp( [ 'Time = ', num2str( time, '%0.4f'), ' [s]'])

        %%[1-0] ノード変位データ抽出
        r_vec = double( reshape( h_X_vec(idx_r,i_time), 3, []));

        %%[1-1] 1要素当たりのノードの座標取得
%         X = zeros(4,N_element) ;
%         Y = zeros(4,N_element) ;
%         Y = zeros(4,N_element) ;
%         for ii = 1:N_element
%             X(:,ii) = r_vec(1,nodes(ii,:));
%             Y(:,ii) = r_vec(2,nodes(ii,:));
%             Z(:,ii) = r_vec(3,nodes(ii,:));
%         end
        X = reshape( r_vec(1:3:end).', Ny+1, []).';
        Y = reshape( r_vec(2:3:end).', Ny+1, []).';
        Z = reshape( r_vec(3:3:end).', Ny+1, []).';
        

        %%[1-2] plot更新
        set( h_plot(1), 'XData', X, 'YData', Y, 'ZData', Z);
        set( h_txt(1), 'String', [ 'Time = ', num2str( time, '%0.3f'), ' [s]']);
        
        %%[1-3] 挙動のスナップショット
        if mod( i_time, i_snapshot) == 0 && time < Snapshot_tmax
            
%             patch( X, Y, Z, 'r', 'Parent', h_ax(3), 'FaceAlpha', 0.5);
            surf( X, Y, Z, 'Parent', h_ax(3));
            hold( h_ax(3), 'on')
            axis( h_ax(3), 'equal')

            Xv = X(:);
            Yv = Y(:);
            Zv = Z(:);
            Rv = sqrt( Xv.^2+ Yv.^2 + Zv.^2);
            [ dummy, idx_max_r] = max( Rv);
            text( Xv(idx_max_r(1)), Yv(idx_max_r(1)), Zv(idx_max_r(1)), [ 'Time = ', num2str( time, '%0.3f'), ' [s]'],...
                    'FontSize', 12, 'FontName', 'Times New Roman', 'BackgroundColor', 'g', 'Parent', h_ax(3));
        end
        
        movie_data(i_movie) = getframe( h_fig(2));
        movie_time(i_movie) = time; %#ok<AGROW>
        
        i_movie = i_movie+1;
    end
    
    drawnow
    
    i_time = i_time + 1;
end



%% エネルギ収支


h_fig(4) = figure(4);
set( h_fig(4), 'Position', [100 100 1200 500])
h_ax(i_ax) = axes( 'Parent', h_fig(4), 'FontSize', 15);



plot( h_ax(i_ax), time_m, h_E_inertia + h_U + h_E_em + h_E_ek, 'b--', 'LineWidth', 3)
xlabel( h_ax(i_ax), 'Time [s]')
ylabel( h_ax(i_ax), 'Energy [J]') 
% ylim( h_ax(i_ax), [ -0.2 0.2])
grid( h_ax(i_ax), 'on')
hold( h_ax(i_ax), 'on')
plot( h_ax(i_ax), time_m, h_E_inertia, 'g')
plot( h_ax(i_ax), time_m, h_U, 'r')
plot( h_ax(i_ax), time_m, h_E_em, 'k')
plot( h_ax(i_ax), time_m, h_E_ek, 'm')

legend( '{\itE_{total}}', '{\itE_{inertia}}', '{\itU}', '{\itE_{em}}', '{\itE_{ek}}')

set( h_ax(i_ax), 'FontName', 'Times New Roman')


i_ax = i_ax + 1;





%% save

fig_name = { 'nodes', 'displacement', 'snapshot', 'Energy'};

for ii = 1:length( h_fig)
    
    saveas( h_fig(ii), [ './save/fig/', fig_name{ii}, '.fig']) 

    set( h_fig(ii), 'PaperPositionMode', 'auto')
    fig_pos = get( h_fig(ii), 'PaperPosition');
    set( h_fig(ii), 'Papersize', [fig_pos(3) fig_pos(4)]);
    saveas( h_fig(ii), [ './save/fig/', fig_name{ii}, '.pdf']) 
end


%% create movie


if strcmp( 'mpeg', movie_format)
    mpgwrite( movie_data, jet, './save/data.mpg')
elseif strcmp( 'avi', movie_format)
    movie2avi( movie_data, './save/data.avi')
elseif strcmp( 'wmv', movie_format)
    video.frames = movie_data;
    video.width=size( video.frames(1).cdata, 2);
    video.height=size( video.frames(1).cdata, 1);
    video.times = movie_time;
    
    mmwrite( './save/data.wmv', video)
end

%% Finish
warndlg( 'Finish')



