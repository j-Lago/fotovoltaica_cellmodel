%  Created on: 28/06/2023
%      Author: j-Lago
%
classdef ArranjoGUI
   properties
       sel            % modulo selecionado
       L              % numero de modulos/celulas visíveis por string
       C              % numero de strings visíveis do arranjo
       
       x0             % posição x onde inicia o grafico do arranjo
       y0             % POSIÇÃO Y onde inicia o grafico do arranjo
       Dx             % largura do modulo em px
       Dy             % altura do modulo em px
       
       bypass         % se possui ou não diodo de bypass
       block          % se possui ou não diodo de bloqueio
   end
   
   methods
       function self = ArranjoGUI(L, C, bypass, block, x0, y0, Dx, Dy)
           self.sel = [0,0];
           self.bypass = bypass;
           self.block = block;
           self.L = L;
           self.C = C;
           self.x0 = x0;
           self.y0 = y0;
           self.Dx = Dx;
           self.Dy = Dy;
       end
       
       %passa a posição do mouse. O metodo retorna a seleção se a posição
       %passada corresponder a um do modulos da porção gráfica do arranjo
       %se update_sel ~= 0, atualiza também o registro da selecção atual 
       function [l, c] = select(self, x, y, update_sel)
             l = 0;
             c = 0;

             if x >= self.x0                     & ...
                x <= self.x0 + self.C * self.Dx  & ...
                y >= self.y0                     & ...
                y <= self.y0 + self.L * self.Dy
            
                 l = ceil( ( y - self.y0 ) / self.Dy );
                 c = ceil( ( x - self.x0 ) / self.Dx );
                 if update_sel
                     self.sel(1) = l;
                     self.sel(2) = c;
                 end
             end
       end
   end
end