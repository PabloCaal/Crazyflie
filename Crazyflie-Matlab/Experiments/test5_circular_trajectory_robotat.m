% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de seguimiento de trayectoria circular en Crazyflie con Flow Deck
% y lecturas de Robotat para corregir posición
% =========================================================================

%% Añadir la carpeta de comandos al path usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Lectura de markers en obstáculos y generación de trayectoria
robotat = robotat_connect();
%%
agent_id = 50;  
origin = robotat_get_pose(robotat, agent_id);
circle_center = origin(1:3) + [0,0,0.5];

%% Generación de trayectoria circular
N = 6;
radio = 0.3;
theta = linspace(0, 2*pi, N);  
x = circle_center(1) + radio * cos(theta);
y = circle_center(2) + radio * sin(theta);
z = circle_center(3) * ones(1, N);

plot3(x, y, z, 'bo-', 'DisplayName', 'Trayectoria Circular');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Trayectoria circular generada');
grid on;
axis equal;
axis([-2 2 -2.5 2.5 0 2]);
view(3);

%% Ejecución de trayectoria en Crazyflie con Flow Deck
dron_id = 8;    
crazyflie_1 = crazyflie_connect(dron_id);
pause(1);

crazyflie_takeoff(crazyflie_1);
pause(2);

for i = 1:N
    crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i));
    pause(1);
    robotat_update_crazyflie_position(crazyflie_1, robotat, agent_id);
end

crazyflie_move_to_position(crazyflie_1, circle_center(1), circle_center(2), circle_center(3));
pause(1);

crazyflie_land(crazyflie_1);
pause(1);

crazyflie_disconnect(crazyflie_1);