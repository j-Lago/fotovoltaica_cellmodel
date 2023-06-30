%  Created on: 28/06/2023
%      Author: j-Lago
%
function img = mask( img, sprite, x0, y0, px, py ) 

 
 x0 = round(x0);
 y0 = round(y0);
 
 sz_img = size(img);
 sz_spr = size(sprite);
 
 dx = round( min( sz_spr(2) * px , sz_img(2) - x0 ) );
 dy = round( min( sz_spr(1) * py , sz_img(1) - y0 ) );

r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

sr = sprite(:,:,1);
sg = sprite(:,:,2);
sb = sprite(:,:,3);

for x = 1:dx 
    for y = 1:dy
        %if  ~( sr(y,x) == 255 && sg(y,x) == 255 && sb(y,x) == 255 )
        if  ( sr(y,x) + sg(y,x) + sb(y,x) ) ~= 0
            r(y + y0, x + x0) = sr(y,x);
            g(y + y0, x + x0) = sg(y,x);
            b(y + y0, x + x0) = sb(y,x);
        end
    end
end

img(:,:,1)= r; 
img(:,:,2)= g;
img(:,:,3)= b;