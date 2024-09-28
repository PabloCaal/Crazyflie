% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de fusión de sensores (manual, sin robotat)
% =========================================================================

%% Añadir al path las carpetas de comandos usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Conexión dron, robotat y actualización de posición inicial
dron_id = 8; 
crazyflie_1 = crazyflie_connect(dron_id);

crazyflie_takeoff(crazyflie_1, 0.5, 2.5);
pose = crazyflie_get_pose(crazyflie_1);
pause(0.5);
crazyflie_set_position(crazyflie_1, 0, 0, 0.3);
pause(0.5);
pose = crazyflie_get_pose(crazyflie_1);
pause(0.5);
crazyflie_set_position(crazyflie_1, 0, 0.05, 0.3);
pause(0.5);
pose = crazyflie_get_pose(crazyflie_1);
pause(0.5);
crazyflie_set_position(crazyflie_1, 0.05, 0, 0.3);
pause(0.5);
pose = crazyflie_get_pose(crazyflie_1);
pause(0.5);
crazyflie_set_position(crazyflie_1, -0.05, 0, 0.3);
pause(0.5);
pose = crazyflie_get_pose(crazyflie_1);
pause(0.5);
crazyflie_set_position(crazyflie_1, 0, -0.05, 0.3);
pause(0.5);
pose = crazyflie_get_pose(crazyflie_1);
pause(0.5);
crazyflie_land(crazyflie_1);
crazyflie_disconnect(crazyflie_1);