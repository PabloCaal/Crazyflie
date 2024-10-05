% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de seguimiento de trayectoria circular en Crazyflie con Flow Deck
% =========================================================================

%% Añadir la carpeta de comandos al path usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Generación de trayectoria circular con origen fijo
origin = [0,0,0];
take_off_point = origin(1:3) + [0, 0, 0.5];
final_point = [0.6, -0.6, 0.5];

N = 5;
% Generar los puntos de la trayectoria lineal
x = linspace(take_off_point(1), final_point(1), N);
y = linspace(take_off_point(2), final_point(2), N);
z = linspace(take_off_point(3), final_point(3), N);

plot3(x, y, z, '*-', 'DisplayName', 'Trayectoria Circular');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Trayectoria circular generada');
grid on;
axis equal;
axis([-1 1 -1 1 0 2]);
view(3);

%% Ejecución de vuelo en Crazyflie con Flow Deck
dron_id = 8;    
velocity = 1;
crazyflie_1 = crazyflie_connect(dron_id);
crazyflie_takeoff(crazyflie_1, 0.5, 0.9);
pause(1);
crazyflie_move_to_position(crazyflie_1, x(1), y(1), z(1), 0.5);
pause(1);
for i = 1:N
    crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i), velocity);
end
pause(1);
crazyflie_land(crazyflie_1);
pause(1);

crazyflie_disconnect(crazyflie_1);

%%
dron_id = 8;    
crazyflie_1 = crazyflie_connect(dron_id);
crazyflie_takeoff(crazyflie_1, 0.5, 1.0); 
crazyflie_move_to_position(crazyflie_1, 0, 0, 0.2, 0.75);
crazyflie_move_to_position(crazyflie_1, 0.75, 0, 0.2, 1);
crazyflie_land(crazyflie_1);
crazyflie_disconnect(crazyflie_1);