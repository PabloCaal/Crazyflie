% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de despegue simple en Crazyflie con Flow Deck
% =========================================================================

%% Añadir al path las carpetas de comandos usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Ejecución de prueba de despegue y aterrizaje
% Conexión con Crazyflie
dron_id = 8; 
crazyflie_1 = crazyflie_connect(dron_id);
% Despegue
crazyflie_takeoff(crazyflie_1, 0.5, 1.0);
pause(2);
% Aterrizaje
crazyflie_land(crazyflie_1);
% Desconexión
crazyflie_disconnect(crazyflie_1);