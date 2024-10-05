%% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de movimiento punto a punto en Crazyflie con fusión de
% sensores: Flow Deck + Sistema de Captura de Movimiento
% =========================================================================

%% Añadir al path las carpetas de comandos usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Conexión con Robotat
robotat = robotat_connect(); 
agent_id = 50; % Número del marker del dron dentro del Robotat

%% Generación de trayectoria circular con origen de Robotat
%origin = robotat_get_pose(robotat, agent_id, "eulxyz");
origin = [0,0,0];
takeoff_point = origin(1:3) + [0, 0, 0.5];
point1 = takeoff_point(1:3) + [0.5, 0, 0.3];
point2 = takeoff_point(1:3) + [-0.5, 0, 0.3];
land_point = origin(1:3) + [0, 0, 0.3];

% Crear un array donde cada fila es un punto
trajectory = [takeoff_point(1:3); point1(1:3); point2(1:3); land_point(1:3)];

plot3(trajectory(:,1), trajectory(:,2), trajectory(:,3), '*');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Gráfica de los puntos a seguir por el dron');
grid on;
axis equal;
axis([-1 1 -1 1 0 2]);
view(3);


%% Ejecución de trayectoria circular
% Conexión con Crazyflie
dron_id = 8;   
crazyflie_1 = crazyflie_connect(dron_id);
% Actualización de pose inicial
crazyflie_set_position(crazyflie_1, origin(1), origin(2), origin(3));
% Despegue
crazyflie_takeoff(crazyflie_1, 0.5, 1.0);
% Seguimiento de la trayectoria
for i = 1:length(trajectory)
    crazyflie_move_to_position(crazyflie_1, trajectory(i,1), trajectory(i,2), trajectory(i,3), 0.5);
    %pause(0.01);
    pose = robotat_get_pose(robotat, agent_id, "eulxyz");
    crazyflie_set_position(crazyflie_1, pose(1), pose(2), pose(3));
end
% Aterrizaje
crazyflie_land(crazyflie_1);
% Desconexión
crazyflie_disconnect(crazyflie_1);