function wimg = warpimg(img, p, sz)
% function wimg = warpimg(img, p, sz)
%
%    img(h,w)   :   原始图像
%    p(6,n)     :   仿射参数    mat format
%    sz(th,tw)  ：  提取块大小
%

%% Copyright (C) 2005 Jongwoo Lim and David Ross.
%% All rights reserved.

if (nargin < 3)
    sz = size(img);
end
if (size(p,1) == 1)
    p = p(:);
end
w = sz(2);  h = sz(1);  n = size(p,2);
[x,y] = meshgrid([1:w]-w/2, [1:h]-h/2);
p(3)=p(3)*sz(1)/sz(2);
pos = reshape(cat(2, ones(h*w,1),x(:),y(:)) ...
              * [p(1,:) p(2,:); p(3:4,:) p(5:6,:)], [h,w,n,2]);
% imshow(uint8(img))
% hold on
% plot(pos(:,:,1),pos(:,:,2),'r.')
wimg = squeeze(interp2(img, pos(:,:,:,1), pos(:,:,:,2)));
                                %%pos(:,:,:,1)    :   x坐标矩阵
                                %%pos(:,:,:,2)    ：  y坐标矩阵
wimg(find(isnan(wimg))) = 0;    %%去掉个别坏点

%   B = SQUEEZE(A) returns an array B with the same elements as
%   A but with all the singleton dimensions removed.  A singleton
%   is a dimension such that size(A,dim)==1;

