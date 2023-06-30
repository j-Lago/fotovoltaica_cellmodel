%  Created on: 13/06/2023
%      Author: j-Lago
%
classdef InversorRede
   properties
       x
       vdc
   end
   
   methods
       function self = InversorRede(vdc, x)
           self.vdc = vdc;
           self.x = x;
       end
       
       function [p, q, i, v, pgrid, qgrid, igrid, vgrid, delta] = SolveV(self, vgrid, vinv)
           
           v = vinv;
           i = (vinv - vgrid) ./ (j*self.x);
           s = 3 * vinv .* conj(i);
           p = real(s);
           q = imag(s);
           
           pgrid = p;
           qgrid = q - 3*abs(i).^2 * self.x;
           igrid = i;
           vgrid = vgrid;
           delta = (angle(vinv) - angle(vgrid))/pi*180;
       end
       
       function [p, q, i, v, pgrid, qgrid, igrid, vgrid, delta] = SolveD(self, vgrid, vinv_amp, P)
           
           delta = asin((P*self.x)./(3*abs(vinv_amp)*abs(vgrid))) * 180 / pi;
           
           if isnan(delta)
               delta = 0;
           else
               if delta > 90
               delta = 90;
               end
               if delta < -90
                   delta = 90;
               end
           end
           
           vinv = abs(vinv_amp)*(cosd(delta)+j*sind(delta));
           v = vinv;
           i = (vinv - vgrid) ./ (j*self.x);
           s = 3 * vinv .* conj(i);
           p = real(s);
           q = imag(s);
           
           pgrid = p;
           qgrid = q - 3*abs(i).^2 * self.x;
           igrid = i;
           vgrid = vgrid;
           
           
       end
       
   end
end