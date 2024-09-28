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

%% Conexión
agent_id = 50;
dron_id = 8; 

robotat = robotat_connect();   
crazyflie_1 = crazyflie_connect(dron_id);

%% Prueba de orientación del dron 



%% Offset del marker en dron
pose_inicial = robotat_get_pose(robotat, agent_id, "eulxyz");

% Offset para marker en dron
pose_inicial(6) = mod(pose_inicial(6), 360);
pose_inicial(6) = pose_inicial(6) + 105;
if pose_inicial(6) >= 360
    pose_inicial(6) = pose_inicial(6) -360;
end
disp(pose_inicial);

%% Prueba 1: Actualización de pose inicial del dron
pose_inicial = crazyflie_get_pose(crazyflie_1);

actual_pose = robotat_get_pose(robotat, agent_id, "eulxyz");
crazyflie_set_position(crazyflie_1, actual_pose(1), actual_pose(2), actual_pose(3));
pause(0.5);

pose_final = crazyflie_get_pose(crazyflie_1);

%% Prueba 2: Actualización de pose, take off y movimiento frontal de 0.3 m
pose_inicial = crazyflie_get_pose(crazyflie_1);

actual_pose = robotat_get_pose(robotat, agent_id, "eulxyz");
crazyflie_set_position(crazyflie_1, actual_pose(1), actual_pose(2), actual_pose(3));
pause(0.5);

crazyflie_takeoff(crazyflie_1, 0.5, 2.5); % Mejores parámetros para despegue
pause(2);

% Land
crazyflie_land(crazyflie_1);
pause(2);

crazyflie_move_to_position(crazyflie_1, actual_pose(1), actual_pose(2) + 0.2, 0.5);
pause(2);

% Desconexión
crazyflie_disconnect(crazyflie_1);
robotat_disconnect(robotat)


%% Despegue
% Take off
crazyflie_takeoff(crazyflie_1, 0.5, 2.5); % Mejores parámetros para despegue
pause(2);

actual_pose = robotat_get_pose(robotat, agent_id);
crazyflie_set_position(crazyflie_1, actual_pose(1), actual_pose(2), actual_pose(3));
pause(0.5);

crazyflie_move_to_position(crazyflie_1, pose_inicial(1), pose_inicial(2) + 0.2, 0.5);
pause(2);

robotat_update_crazyflie_position(crazyflie_1, robotat, agent_id);
pause(0.5);

crazyflie_move_to_position(crazyflie_1, pose_inicial(1) + 0.3, pose_inicial(2), 0.5);
pause(2);

robotat_update_crazyflie_position(crazyflie_1, robotat, agent_id);
pause(0.5);

crazyflie_land(crazyflie_1);
pause(2);


%% Actualización de posición
total_duration = 10; 
interval = 0.25;   
iterations = total_duration / interval;  
posiciones = [];

for i = 1:iterations
    robotat_update_crazyflie_position(crazyflie_1, robotat, agent_id);
    pause(interval);
end

crazyflie_land(crazyflie_1);
pause(2);

%% Land
crazyflie_land(crazyflie_1);
pause(2);

%% Desconexión
crazyflie_disconnect(crazyflie_1);
robotat_disconnect(robotat)

