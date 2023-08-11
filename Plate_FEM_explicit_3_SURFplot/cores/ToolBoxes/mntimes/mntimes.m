function z = mntimes(x,y,xrowdim,xcoldim,yrowdim,ycoldim)
%% Purpose:
%  matrix n-d times routine (mntimes.m) takes any n-d matricies and
%  multiplies them together in a similar manner as mtimes.m.
%  The only assumption with this operation is that x can be reduced to some
%  N x M x L matrix while y can be reduced to either M x 1 x L or N x M x
%  L.
%
%  This is equivielent to the following statement:
%  z = x*y
%
%  Here are some working examples of what mntimes will support:
%
%  [1 2 3] [1] [14]
%  [4 5 6]*[2]=[32]  => rowdim=1, coldim=2
%  [7 8 9] [3] [50]
%
%  [1 2 3] [1] [14]
%  [4 5 6]*[2]=[32]  => rowdim=1, coldim=2
%  [7 8 9] [3] [50]
%  [1 2 3]     [14]
%
%  [1 2 3] * [1]
%            [2]  =>    rowdim=1, coldim=2
%            [3]
%
%% Inputs:
%  x                [N x M x L x ... O]                        Input matrix
%
%  y                [N x 1/M x L x ... O]                      Input matrix
%
%  xrowdim                  int                                N-D
%                                                              dimension 
%                                                              specifier of
%                                                              x to indicate
%                                                              where the
%                                                              rows are
%                                                              located
%
%  xcoldim                  int                                N-D
%                                                              dimension 
%                                                              specifier of
%                                                              x to indicate
%                                                              where the
%                                                              columns are
%                                                              located
%
%%  yrowdim                  int                               N-D
%                                                              dimension 
%                                                              specifier of
%                                                              y to indicate
%                                                              where the
%                                                              rows are
%                                                              located
%
%  ycoldim                  int                                N-D
%                                                              dimension 
%                                                              specifier of
%                                                              y to indicate
%                                                              where the
%                                                              columns are
%                                                              located
% 
%% Outputs:
%  z              [N x 1/M x L x ... O]                        Matrix
%                                                              product of
%                                                              performing
%                                                              the
%                                                              resulting
%                                                              multiplication
%
%% Revision History:
% Darin C. Koblick                                           (c) 06/29/2014
% Darin C. Koblick              Updated to address               07/25/2016
%                               indexing issue
%% ----------------------- Begin Code Sequence ----------------------------
if nargin == 2
   z = mtimes(x,y); 
   return;
elseif nargin == 4
   z = mntimes(x,y,xrowdim,xcoldim,xrowdim,xcoldim);
   return;
elseif nargin < 2 || nargin == 3 || nargin == 5 || nargin > 6
   error([mfilename,' :: Unknown Number of Inputs ',num2str(nargin)]); 
end
%% Assemble N-D matricies:
xPermSeq = 1:numel(size(x));
yPermSeq = 1:numel(size(y));
[xPermSeq(1),xPermSeq(xrowdim)] = deal(xPermSeq(xrowdim),xPermSeq(1));
[xPermSeq(2),xPermSeq(xcoldim)] = deal(xPermSeq(xcoldim),xPermSeq(2));
[yPermSeq(1),yPermSeq(yrowdim)] = deal(yPermSeq(yrowdim),yPermSeq(1));
[yPermSeq(2),yPermSeq(ycoldim)] = deal(yPermSeq(ycoldim),yPermSeq(2));
%% Permute matricies:
x = permute(x,xPermSeq);
y = permute(y,yPermSeq);
%% Create Output:
yDim = size(y);
xDim = size(x);
   z = NaN(size(x,1),size(y,2));
if numel(size(x)) > 2
   z = NaN([size(x,1),size(y,2),yDim(3:end)]);
end
%% Extract 2-D Slices of each matrix:
x = permute(x,[2 1 3:numel(xDim)]);
x = permute(x,[2 1 numel(xDim)+1 3:numel(xDim)]);
y = permute(y,[numel(yDim)+1 1:numel(yDim)]);
z = bsxfun(@times,x,y);
z = sum(z,2);
z = permute(z,[1 3:numel(size(z)) 2]);
% for tr = 1:size(x,1)
%     if numel(size(x)) > 2
%         pStr = ['permute(','x(',num2str(tr), ...
%             repmat(',:',[1 numel(size(x))-1]),')',',[2 1 3:numel(size(x))])'];
%     else
%         pStr = ['permute(','x(',num2str(tr), ...
%             repmat(',:',[1 numel(size(x))-1]),')',',[2 1])'];
%     end
%     zStr = ['z(',num2str(tr),repmat(',:',[1 numel(size(x))-1]),')'];
%     eStr = [zStr,'=','sum(bsxfun(@times,',pStr,',y),1);'];
%     eval(eStr);
% end
%% Provide the Solution back in its original format:
z = ipermute(z,xPermSeq);
end