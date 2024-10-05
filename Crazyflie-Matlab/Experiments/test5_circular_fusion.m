%% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de seguimiento de trayectoria circular en Crazyflie con fusión de
% sensores: Flow Deck + Sistema de Captura de Movimiento
% =========================================================================

%% Añadir al path las carpetas de comandos usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Conexión dron, robotat y actualización de posición inicial
agent_id = 50; % Número de marker dentro del Robotat 
dron_id = 8; % Número de dron para su dirección URI

robotat = robotat_connect();
crazyflie_1 = crazyflie_connect(dron_id);

%% Generación de trayectoria circular con origen fijo
origin = robotat_get_pose(robotat, agent_id);
crazyflie_set_position(crazyflie_1, origin(1), origin(2), origin(3));

center = origin(1:3) + [0, 0, 0.5];

N = 10; % Cantidad de puntos en la trayectoria circular
r = 0.15; % Radio de la trayectoria circular
theta = linspace(0, 2*pi, N);  
x = center(1) + r * cos(theta);
y = center(2) + r * sin(theta);
z = center(3) * ones(1, N);

plot3(x, y, z, '*-', 'DisplayName', 'Trayectoria circular');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Trayectoria circular generada');
grid on;
axis equal;
axis([-2 2 -2.5 2.5 0 2]);
view(3);

%% Ejecución de trayectoria circular
% Despegue
velocity = 1.0;
crazyflie_takeoff(crazyflie_1, 0.5, 1.0);
pause(1);
% Seguimiento de la trayectoria
crazyflie_move_to_position(crazyflie_1, x(1), y(1), z(1), 0.5);
pause(1);
for i = 1:N
    crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i), velocity);
    %pause(0.01);
    pose = robotat_get_pose(robotat, agent_id, "eulxyz");
    crazyflie_set_position(crazyflie_1, pose(1), pose(2), pose(3));
end
%crazyflie_move_to_position(crazyflie_1, x(end), y(end), z(end), 0.5);
crazyflie_move_to_position(crazyflie_1, center(1), center(2), center(3));
pose = robotat_get_pose(robotat, agent_id, "eulxyz");
crazyflie_set_position(crazyflie_1, pose(1), pose(2), pose(3));
% Aterrizaje
crazyflie_land(crazyflie_1);
% Desconexión
crazyflie_disconnect(crazyflie_1);