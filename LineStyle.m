%  Created on: 13/06/2023
%      Author: j-Lago
%
classdef LineStyle
   properties
       s
       lc
       lw
       ms
   end
   
   methods
       function self = LineStyle(line_style, line_color, line_width, marker_size)
           self.s  = line_style;
           self.lc = line_color;
           self.lw = line_width;
           self.ms = marker_size;
       end
       
       function p = plot(self, x, y)
           p = plot(x, y, self.s, 'Color', self.lc, 'LineWidth', self.lw, 'Markersize', self.ms);
       end
   end
end