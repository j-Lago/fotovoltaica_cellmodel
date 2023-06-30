%  Created on: 28/06/2023
%      Author: j-Lago
%
function img = highlight(img, x0, y0, Dx, Dy)


 x0 = round(x0);
 y0 = round(y0);
 Dx = round(Dx);
 Dy = round(Dy);

r = img(:,:,1);
g = img(:,:,2);
%b = img(:,:,3);

%sz= size(r);
for x = x0:x0+Dx 
    for y=y0:y0+Dy
        %if  ~( r(y,x) == 255 && g(y,x) == 255 && b(y,x) == 255 )
        %if  ( r(y,x) + g(y,x) + b(y,x) ) ~= 255
            r(y,x) = min(r(y,x) + 180, 255);
            g(y,x) = min(g(y,x) + 80, 255);
            %b(y,x) = min(r(y,x) +  60, 255);
        %end
    end
end

%masked = uint8(zeros(size(img)));
img(:,:,1)= r; 
img(:,:,2)= g;
%img(:,:,3)= b;