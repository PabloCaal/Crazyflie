% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de Take Off y Land en Crazyflie con Flow Deck
% =========================================================================

%% Añadir al path las carpetas de comandos usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Disconnect 
crazyflie_disconnect(crazyflie_1);
robotat_disconnect(robotat)

%% Ejecución de prueba de despegue y aterrizaje (prueba manual)
dron_id = 8; 
crazyflie_1 = crazyflie_connect(dron_id);
pause(1);

crazyflie_takeoff(crazyflie_1, 0.5, 2.5);
pause(2);

% point 1 
crazyflie_move_to_position(crazyflie_1, 0, 0, 0.2, 0.5)
robotat_update_crazyflie_position(crazyflie_1, robotat, agent_robotat_id);
pause(2)

crazyflie_move_to_position(crazyflie_1, 0, 0, 0.2, 0.5)

crazyflie_land(crazyflie_1);
pause(1);

crazyflie_disconnect(crazyflie_1);

% point 2
%crazyflie_move_to_position(crazyflie_1, -0.7, -0.35, 0.22, 0.5)
%crazyflie_move_to_position(crazyflie_1, 0.8, 0, 0.2, 0.5)
%robotat_update_crazyflie_position(crazyflie_1, robotat, agent_robotat_id);

%% Prueba de con robotat
agent_robotat_id = 50;
dron_id = 8;    

crazyflie_1 = crazyflie_connect(dron_id);
robotat = robotat_connect();
pause(1);

% Get initial pose
robotat_update_crazyflie_position(crazyflie_1, robotat, agent_robotat_id);
crazyflie_pose = robotat_get_pose(robotat, agent_robotat_id)
crazyflie_get_pose(crazyflie_1);

%% Vuelo 1
crazyflie_takeoff(crazyflie_1, 0.5, 2.5);

try
    robotat_update_crazyflie_position(crazyflie_1, robotat, agent_robotat_id);
catch
    % pass
end
pause(2);

crazyflie_land(crazyflie_1);
pause(1);
crazyflie_disconnect(crazyflie_1);

%% Vuelo
crazyflie_takeoff(crazyflie_1, 0.5, 2.5);
pause(2);

% Point 1 
crazyflie_move_to_position(crazyflie_1, 0, 0, 0.2, 0.5);
try
    robotat_update_crazyflie_position(crazyflie_1, robotat, agent_robotat_id);
catch
    % pass
end
pause(2);

crazyflie_move_to_position(crazyflie_1, 0, 0.2, 0.2, 0.5);
pause(1);

crazyflie_land(crazyflie_1);
pause(1);
crazyflie_disconnect(crazyflie_1);


%% Aterrizaje y desconexión
crazyflie_land(crazyflie_1);
pause(1);

crazyflie_disconnect(crazyflie_1);