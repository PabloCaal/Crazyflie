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
circle_center = origin(1:3) + [0, 0, 0.5];
N = 25;
radio = 0.35;
theta = linspace(0, 2*pi, N);  
x = circle_center(1) + radio * cos(theta);
y = circle_center(2) + radio * sin(theta);
z = circle_center(3) * ones(1, N);
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
velocity = 1.1;
crazyflie_1 = crazyflie_connect(dron_id);
crazyflie_takeoff(crazyflie_1, 0.5, 1.0);
pause(1);
crazyflie_move_to_position(crazyflie_1, x(1), y(1), z(1), 0.5);
pause(1);
for i = 1:N
    crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i), velocity);
end
pause(1);
crazyflie_move_to_position(crazyflie_1, 0, 0, 0.5, velocity);
crazyflie_land(crazyflie_1);
pause(1);

crazyflie_disconnect(crazyflie_1);

%%
dron_id = 8;    
crazyflie_1 = crazyflie_connect(dron_id);
crazyflie_takeoff(crazyflie_1, 0.5, 2.5); 
crazyflie_move_to_position(crazyflie_1, 1, 1, 0.5, 0.2);
crazyflie_move_to_position(crazyflie_1, 0, 0, 0.5, 0.2);
crazyflie_land(crazyflie_1);
crazyflie_disconnect(crazyflie_1);