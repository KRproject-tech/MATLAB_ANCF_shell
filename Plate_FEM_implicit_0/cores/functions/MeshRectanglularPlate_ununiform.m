function [coordinates,nodes] = MeshRectanglularPlate_ununiform( x_vec, y_vec) 
% To Mesh a Plate using 4 noded Elements 
%--------------------------------------------------------------------------
% Code written by : Siva Srinivas Kolukula                                |
%                   Senior Research Fellow                                |
%                   Structural Mechanics Laboratory                       |
%                   Indira Gandhi Center for Atomic Research              |
%                   India                                                 |
% E-mail : allwayzitzme@gmail.com                                         |
%          http://sites.google.com/site/kolukulasivasrinivas/             |    
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Purpose:
%         To Mesh a square/Rectangular plate to use in FEM Analysis
% Synopsis :
%         [coordinates,nodes] = MeshPlate(L,B,Nx,Ny)
% Variable Description:
% Input :
%           L  - Length of the Plate along X-axes
%           B  - Breadth of the Plate along Y-axes
%           Nx - Number of Elements along X-axes
%           Ny - Number of Elements along Y-axes
% Output :
%           coordinates - The nodal coordinates of the mesh
%           -----> coordinates = [node X Y] 
%           nodes - The nodal connectivity of the elements
%           -----> nodes = [node1 node2......]    
%--------------------------------------------------------------------------
Nx = length( x_vec)-1;
Ny = length( y_vec)-1;

nel = Nx*Ny ;        % Total Number of Elements in the Mesh
nnel = 4 ;           % Number of nodes per Element
% Number of points on the Length and Breadth
npx = Nx+1 ;
npy = Ny+1 ;
nnode = npx*npy ;      % Total Number of Nodes in the Mesh
% Discretizing the Length and Breadth of the plate
nx = x_vec;
ny = y_vec;

[xx yy] = meshgrid(nx,ny) ;
% To get the Nodal Connectivity Matrix
coordinates = [xx(:) yy(:)] ;
NodeNo = 1:nnode ;
nodes = zeros(nel,nnel) ;
% If elements along the X-axes and Y-axes are equal
if npx==npy
    NodeNo = reshape(NodeNo,npx,npy);
    nodes(:,1) = reshape(NodeNo(1:npx-1,1:npy-1),nel,1);
    nodes(:,4) = reshape(NodeNo(2:npx,1:npy-1),nel,1);
    nodes(:,3) = reshape(NodeNo(2:npx,2:npy),nel,1);
    nodes(:,2) = reshape(NodeNo(1:npx-1,2:npy),nel,1);
% If the elements along the axes are different
else%if npx>npy
    NodeNo = reshape(NodeNo,npy,npx);
    nodes(:,1) = reshape(NodeNo(1:npy-1,1:npx-1),nel,1);
    nodes(:,4) = reshape(NodeNo(2:npy,1:npx-1),nel,1);
    nodes(:,3) = reshape(NodeNo(2:npy,2:npx),nel,1);
    nodes(:,2) = reshape(NodeNo(1:npy-1,2:npx),nel,1);
end

