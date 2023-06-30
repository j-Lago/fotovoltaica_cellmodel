%  Created on: 28/06/2023
%      Author: j-Lago
%
function click(hObject, eventdata, handles)

   global dtemp;
   global sombra;
   global arranjo_gui;
   
   

   position = get( ancestor(hObject,'axes'), 'CurrentPoint' );
   button = get( ancestor(hObject,'figure'), 'SelectionType' );
   
   x = position(1, 1);
   y = position(1, 2);
   
   
   %botao do meio
   if strcmp(button, 'extend')
       arranjo_gui.sel = [0, 0];
       set(handles.irrad_per, 'Value', 0);
       set(handles.dtemp, 'Value', 0);
   else
       [l,c] = arranjo_gui.select(x, y, 1);
       if l + c > 0
           if strcmp(button, 'alt')
                sombra(l, c) = ~ sombra(l, c);
           elseif strcmp(button, 'normal')
               arranjo_gui.sel = [l,c];
           end
           set(handles.irrad_per, 'Value', sombra(l, c));
           set(handles.dtemp, 'Value', dtemp(l, c));
       end
   end
   
   plot_refresh(hObject, eventdata, handles)