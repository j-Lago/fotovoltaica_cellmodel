function plot_refresh(hObject, eventdata, handles)

global dtemp
global sombra
global arranjo_gui


Psun = get(handles.psun, 'Value');
Tamb = get(handles.tamb, 'Value');

axes(handles.axes1);
cla;

        
showP_flag =  get(handles.checkbox1, 'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%teste_serie


x_lim = [-10, 70];
y_lim = [-2, 8];

%showP_flag 
xP = 50;

Lgrid    = LineStyle('-.', [1. 1. 1.]*.5, 1.0, 9);

Lp1    = LineStyle( '-', [.8 1. 1.]*.8, 2.0, 9);
Lp2    = LineStyle( '-', [1. .8 1.]*.8, 2.0, 9);
Lstr   = LineStyle( '-', [.6 1. .3]*.6, 2.0, 9);

Mp1    = LineStyle('*', [.8 1. 1.]*.8, 2.0, 9);
Mp2    = LineStyle('*', [1. .8 1.]*.8, 2.0, 9);
Mstr   = LineStyle( 'o', [.6 1. .3]*.6, 2.0, 9);

Lmppt    = LineStyle(':', [1. .6 .3]*1., 2.0, 9);



if 0
    Psun = 800;
    Tamb = 25;
    alpha1 = 1;
    alpha2 = 0.7;
    vstr = 50;
else
    alpha1 = 1 - sombra(1,1);
    alpha2 = 1 - sombra(2,1);
    beta1 =  dtemp(1,1);
    beta2 =  dtemp(2,1);
    vstr = get(handles.vmppt, 'Value');
end

Npt = 3000;
Vmax = 55;
Vmin = -20;



v = Vmin : (Vmax-Vmin) / (Npt-1) : Vmax;

p1 = PanelPV();
p2 = PanelPV();

p1.bypass = get(handles.bypass, 'Value');
p2.bypass = get(handles.bypass, 'Value');

p1.blocking = get(handles.blocking, 'Value');
p2.blocking = get(handles.blocking, 'Value');

p1.solve_i(Psun*alpha1, Tamb+beta1, v);
p2.solve_i(Psun*alpha2, Tamb+beta2, v);


if p2.bypass || p1.bypass
    imax = max(max(p1.i), max(p2.i));
    imin = min(min(p1.i), min(p2.i));
    ieq = imin : (imax - imin) / (Npt-1) : imax;
    veq = zeros(size(ieq));
    for k = 1 : length(ieq)
       [~,id1] = min(abs(p1.i-ieq(k)));
       [~,id2] = min(abs(p2.i-ieq(k)));
       veq(k) = p1.v(id1) + p2.v(id2); 
    end
else
    imax = min(max(p1.i), max(p2.i));
    imin = max(min(p1.i), min(p2.i));
    ieq = imin : (imax - imin) / (Npt-1) : imax;
    veq = zeros(size(ieq));
    for k = 1 : length(ieq)
       [~,id1] = min(abs(p1.i-ieq(k)));
       [~,id2] = min(abs(p2.i-ieq(k)));
       veq(k) = p1.v(id1) + p2.v(id2); 
    end
end



[~,Nop] = min(abs(veq - vstr));
[~,Nop1] = min(abs(p1.i - ieq(Nop)));
[~,Nop2] = min(abs(p2.i - ieq(Nop)));



Istr = [ieq(Nop)   , 0 , 0 ];

Ipnl = [ieq(Nop)   , 0 , 0 ;
        ieq(Nop)   , 0 , 0 ;
        ieq(Nop)   , 0 , 0 ;
        ieq(Nop)   , 0 , 0 ];

Vpnl = [p1.v(Nop1) , 0 , 0 ;
        p2.v(Nop2) , 0 , 0 ;
                 0 , 0 , 0 ;
                 0 , 0 , 0 ];

Ppnl = Ipnl .* Vpnl;
    


if showP_flag
    Lgrid.plot( [0 , 0], [y_lim(1) * showP_flag .* xP , y_lim(2) * showP_flag .* xP] );
    hold on
    Lgrid.plot( [x_lim(1)  , x_lim(2)], [0, 0] );
    if get(handles.show_paineis, 'Value')
        Lp1.plot(p1.v, p1.i    .*     showP_flag .* p1.v);
        Lp2.plot(p2.v, p2.i    .*     showP_flag .* p2.v);
        Mp1.plot(p1.v(Nop1), p1.i(Nop1)    .*     showP_flag .* p1.v(Nop1) );
        Mp2.plot(p2.v(Nop2), p2.i(Nop2)    .*     showP_flag .* p1.v(Nop2) );
    end
    if get(handles.show_string, 'Value')
        Lmppt.plot( [veq(Nop)  , veq(Nop)], [y_lim(1) * showP_flag .* xP, y_lim(2) * showP_flag .* xP]);
        %Lmppt.plot( [x_lim(1)  , x_lim(2)], [ieq(Nop) * showP_flag .* veq(Nop) , ieq(Nop) * showP_flag .* veq(Nop)]);
        Lstr.plot(veq, ieq     .*     showP_flag .* veq);
        Mstr.plot(veq(Nop), ieq(Nop)       .*     showP_flag .* veq(Nop) );
    end

    hold off
    xlim(x_lim);
    ylim(y_lim*xP);
    ylabel('Power [W]')
else
    Lgrid.plot( [0 , 0], [y_lim(1) , y_lim(2)] );
    hold on
    Lgrid.plot( [x_lim(1)  , x_lim(2)], [0, 0] );
    if get(handles.show_paineis, 'Value')
        Lp1.plot(p1.v, p1.i);
        Lp2.plot(p2.v, p2.i);
        Mp1.plot(p1.v(Nop1), p1.i(Nop1));
        Mp2.plot(p2.v(Nop2), p2.i(Nop2) );
    end
    if get(handles.show_string, 'Value')
        Lmppt.plot( [veq(Nop)  , veq(Nop)], [y_lim(1) , y_lim(2) ]);
        Lmppt.plot( [x_lim(1)  , x_lim(2)], [ieq(Nop) , ieq(Nop) ]);
        Lstr.plot(veq, ieq);
        Mstr.plot(veq(Nop), ieq(Nop) );
    end
    hold off
    xlim(x_lim);
    ylim(y_lim);
    ylabel('Current [A]')
end
xlabel('Voltage [V]')
grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if showP_flag
%     vpot = v;
%     ymax = Pmax;
%     set(handles.checkbox1, 'String', 'Watt vs Volt');
% else
%     vpot = ones(size(v));
%     ymax = Imax;
%     set(handles.checkbox1, 'String', 'Amp vs Volt');
% end



        
if get(handles.blocking, 'Value') && get(handles.bypass, 'Value')
    img = imread('foto_bp.png');
elseif get(handles.blocking, 'Value')
    img = imread('foto_b.png');
elseif get(handles.bypass, 'Value')
    img = imread('foto_p.png');
else
    img = imread('foto.png');
end
spr = imread('sprite.png');


for m = 1 : arranjo_gui.L
   for n = 1 : arranjo_gui.C
       if sombra(m, n)
           img = mask( img ,                   ...
                       spr ,                   ...
                       arranjo_gui.x0 + (n-1) * arranjo_gui.Dx , ...
                       arranjo_gui.y0 + (m-1) * arranjo_gui.Dy , ...
                       sombra(m,n), ...
                       1);
       end
   end
end

if arranjo_gui.sel(1) > 0 && arranjo_gui.sel(2) > 0
    
    img = highlight( img,                                                      ...
                     arranjo_gui.x0 + (arranjo_gui.sel(2)-1) * arranjo_gui.Dx, ...
                     arranjo_gui.y0 + (arranjo_gui.sel(1)-1) * arranjo_gui.Dy, ...
                     arranjo_gui.Dx, arranjo_gui.Dy );
                 
    set(handles.arr_text, 'String', sprintf( 'painel %d', arranjo_gui.sel(1) ));                 
    set(handles.psel_val, 'String', sprintf('%3.0f W', Ppnl(arranjo_gui.sel(1), arranjo_gui.sel(2))) );
    set(handles.vsel_val, 'String', sprintf('%2.1f V', Vpnl(arranjo_gui.sel(1), arranjo_gui.sel(2))) );
    set(handles.isel_val, 'String', sprintf('%2.1f A', Istr(arranjo_gui.sel(2))) );
else
    set(handles.arr_text, 'String', 'nenhum selecionado');
    set(handles.psel_val, 'String', '');
    set(handles.vsel_val, 'String', '');
    set(handles.isel_val, 'String', '');
end

axes(handles.axes2);
imh = image( img );
axis off
axis image
set(imh,'ButtonDownFcn', {@click, handles});


 set(handles.psun_val, 'String', sprintf( '%3.0f W/m²', Psun) );
 set(handles.tamb_val, 'String', sprintf( '%2.1f °C', Tamb) );
% 
set(handles.vin_val, 'String', sprintf( '%2.1f V', veq(Nop)) );
set(handles.iin_val, 'String', sprintf( '%2.1f A', ieq(Nop)) );
set(handles.pin_val, 'String', sprintf( '%3.0f W', veq(Nop)*ieq(Nop)) );
% 
% set(handles.istr1_val, 'String', sprintf( '%2.1f A', Istr(1)) );
% set(handles.istr2_val, 'String', sprintf( '%2.1f A', Istr(2)) );
% set(handles.istr3_val, 'String', sprintf( '%2.1f A', Istr(3)) );
% 
% set(handles.pstr1_val, 'String', sprintf( '%1.1f kW', Istr(1) * vmppt/1000) );
% set(handles.pstr2_val, 'String', sprintf( '%1.1f kW', Istr(2) * vmppt/1000) );
% set(handles.pstr3_val, 'String', sprintf( '%1.1f kW', Istr(3) * vmppt /1000) );
% 
% if flag_vdceq
%     set(handles.vlink_val, 'String', sprintf( '%2.0f V', Vlink ) );
% else
%     set(handles.vlink_val, 'String', '?????');
% end
% set(handles.t11, 'String', sprintf( '%2.0f V', Vpnl(1,1) ) );
% set(handles.t21, 'String', sprintf( '%2.0f V', Vpnl(2,1) ) );
% set(handles.t31, 'String', sprintf( '%2.0f V', Vpnl(3,1) ) );
% set(handles.t41, 'String', sprintf( '%2.0f V', Vpnl(4,1) ) );
% 
% set(handles.t12, 'String', sprintf( '%2.0f V', Vpnl(1,2) ) );
% set(handles.t22, 'String', sprintf( '%2.0f V', Vpnl(2,2) ) );
% set(handles.t32, 'String', sprintf( '%2.0f V', Vpnl(3,2) ) );
% set(handles.t42, 'String', sprintf( '%2.0f V', Vpnl(4,2) ) );
% 
% set(handles.t13, 'String', sprintf( '%2.0f V', Vpnl(1,3) ) );
% set(handles.t23, 'String', sprintf( '%2.0f V', Vpnl(2,3) ) );
% set(handles.t33, 'String', sprintf( '%2.0f V', Vpnl(3,3) ) );
% set(handles.t43, 'String', sprintf( '%2.0f V', Vpnl(4,3) ) );
% 
% set(handles.pinv_val, 'String', sprintf( '%2.1f kW', pinv /1000) );
% set(handles.qinv_val, 'String', sprintf( '%2.1f kVAr', qinv /1000) );
% set(handles.iinv_val, 'String', sprintf( '%2.1f A < %2.1f°', abs(iinv), angle(iinv)*180/pi) );
% set(handles.vinv_val, 'String', sprintf( '%3.0f V < %2.1f°', abs(vinv), angle(vinv)*180/pi) );

