%  Created on: 28/06/2023
%      Author: j-Lago
%
function config(hObject, eventdata, handles)

global arranjo_gui;


axes(handles.axes2)
imh = image(imread('foto.png'));


%flag_pot = 'Off';
%flag_iv = 'OF';

%if get(handles.flag_pot,'Value')
%    flag_pot = 'On';
%end
%if get(handles.flag_iv,'Value')
%    flag_iv = 'On';
%end

%set(handles.perdas_val, 'Visible', flag_pot)
%set(handles.pt_val, 'Visible', flag_pot)
%set(handles.pest_val, 'Visible', flag_pot)
%set(handles.qest_val, 'Visible', flag_pot)
%set(handles.ptot_val, 'Visible', flag_pot)
%set(handles.qtot_val, 'Visible', flag_pot)
%set(handles.fp_val, 'Visible', flag_pot)
%set(handles.iest_val, 'Visible', flag_iv)
%set(handles.vest_val, 'Visible', flag_iv)

axis off
axis image
set(imh,'ButtonDownFcn', {@click, handles});







axes(handles.axes3)
if get(handles.bypass, 'Value')
    imh = image(imread('modelo1.png'));
else
    imh = image(imread('modelo0.png'));
end
axis off
axis image

plot_refresh(hObject, eventdata, handles)
