close all
clear all

%Mejillones

data = readtable("mejillones.csv", "NumHeaderLines", 5);

%eliminamos enunciados con NumHeaderLines
%revisar archivo primero para identificar las primeras filas a eliminar

%eliminamos las ultimas filas, quedándonos con los 365 días del año
data = data(1:365,:);

%variables
velocidad = data.VelocidadDeVientoKm_h; %[km/h]
direccion = data.Direcci_nDeViento_; %[°]

%eliminamos los NaN
idx_v = ~isnan(velocidad);
idx_d = ~isnan(direccion);
% ~ hace que nos busque las posiciones con NO NaN

velocidad = velocidad(idx_v);
direccion = direccion(idx_d);

%% ESTACIONES

vel_o = velocidad(60:151); %60 151
dir_o = direccion(60:151);

vel_i = velocidad(152:243);
dir_i = direccion(152:243); %152 243

vel_p = velocidad(244:334); %244 334
dir_p = direccion(244:334); 

vel_v = [velocidad(1:59); velocidad(335:364)]; %335
dir_v = [direccion(1:59); direccion(335:364)];

%% transformamos a m/s 
velocidad = velocidad .* (1000/3600);

%% [a] Rosas del viento 

WindRose(direccion,velocidad)
 title('')
%%
figure()
% subplot(2,2,1)
WindRose(dir_o, vel_o, 'axes', gca);
title('')
% title('(a) Otoño','FontSize',12);
legend('Location','northwestoutside')

figure()
% subplot(2,2,2)
WindRose(dir_i, vel_i, 'axes', gca);
title('')
% title('(b) Invierno','FontSize',12);
legend('Location','northwestoutside')

figure()
% subplot(2,2,3)
WindRose(dir_p, vel_p, 'axes', gca);
title('')
% title('(c) Primavera','FontSize',12);
legend('Location','northwestoutside')

figure()
% subplot(2,2,4)
WindRose(dir_v, vel_v, 'axes', gca);
title('')
% title('(d) Verano','FontSize',12);
legend('Location','northwestoutside')
%% [b] Vectores progresivos para cada estación del año y para el período anual

direccion_r = direccion.*(pi/180); % deg2rad

% componentes
V_x = - velocidad.*sin(direccion_r); % Este - Oeste
V_y = - velocidad.*cos(direccion_r); % Norte - Sur

%el desplazamiento por día 
x = cumsum([0; V_x*86400]); 
y = cumsum([0; V_y*86400]);

% otoño
dir_o_r = dir_o.*(pi/180);
V_o_x = - vel_o.*sin(dir_o_r); % Este - Oeste
V_o_y = - vel_o.*cos(dir_o_r); % Norte - Sur
x_o = cumsum([0; V_o_x*86400]); 
y_o = cumsum([0; V_o_y*86400]);

% primavera
dir_p_r = dir_p.*(pi/180);
V_p_x = - vel_p.*sin(dir_p_r); % Este - Oeste
V_p_y = - vel_p.*cos(dir_p_r); % Norte - Sur
x_p = cumsum([0; V_p_x*86400]); 
y_p = cumsum([0; V_p_y*86400]);

% invierno
dir_i_r = dir_i.*(pi/180);
V_i_x = - vel_i.*sin(dir_i_r); % Este - Oeste
V_i_y = - vel_i.*cos(dir_i_r); % Norte - Sur
x_i = cumsum([0; V_i_x*86400]); 
y_i = cumsum([0; V_i_y*86400]);

% verano
dir_v_r = dir_v.*(pi/180);
V_v_x = - vel_v.*sin(dir_v_r); % Este - Oeste
V_v_y = - vel_v.*cos(dir_v_r); % Norte - Sur
x_v = cumsum([0; V_v_x*86400]); 
y_v = cumsum([0; V_v_y*86400]);

%% El resultado es la trayectoria del viento recorrida en un año
figure
plot(x,y,'b-','linewidth',2)
title('Trayectoria  Anual del Viento')
xlabel("[m]")
ylabel("[m]")
grid minor
axis tight

%% eztaziones

figure()
subplot(2,2,1)
plot(x_o,y_o,'b-','linewidth',2)
% title('Trayectoria del viento otoño')
xlabel("[m]")
ylabel("[m]")
grid minor
axis tight

subplot(2,2,2)
plot(x_i,y_i,'b-','linewidth',2)
% title('Trayectoria del viento invierno')
xlabel("[m]")
ylabel("[m]")
grid minor
axis tight

subplot(2,2,3)
plot(x_p,y_p,'b-','linewidth',2)
% title('Trayectoria del viento primavera')
xlabel("[m]")
ylabel("[m]")
grid minor
axis tight

subplot(2,2,4)
plot(x_v,y_v,'b-','linewidth',2)
% title('Trayectoria del viento verano')
xlabel("[m]")
ylabel("[m]")
grid minor
axis tight
