% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de despegue con modificación en parámetros de controlador PID 
% de posición Z (altura) en Crazyflie con Flow Deck
% =========================================================================

%% Añadir al path las carpetas con los comandos usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Valores para PID originales
% Kp = 2.00
% Ki = 0.50
% Kd = 0.00
crazyflie_get_pid_z(crazyflie_1);

%% Secuencia de conexión y despegue
% Conexión con Crazyflie
dron_id = 8; 
crazyflie_1 = crazyflie_connect(dron_id);
% Modificación del controlador PID z
crazyflie_set_pid_z(crazyflie_1, 2.00, 0.50, 0.00);
% Despegue
crazyflie_takeoff(crazyflie_1, 0.5, 1.0);
pause(10);
% Aterrizaje
crazyflie_land(crazyflie_1);
% Desconexión
crazyflie_disconnect(crazyflie_1);

%% Listado de pruebas
% Primer set de pruebas - Variación en constante proporcional
% crazyflie_set_pid_z(crazyflie_1, 1.00, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 1.50, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 2.00, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 2.50, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 3.00, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 3.50, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 4.00, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 4.50, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 5.00, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 5.50, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 6.00, 0.50, 0.00);

% Segundo set de pruebas - Variación en constante integrativa
% crazyflie_set_pid_z(crazyflie_1, 2.50, 0.00, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 2.50, 0.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 2.50, 1.00, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 2.50, 1.50, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 2.50, 2.00, 0.00);

% Tercer set de pruebas - Variación en constante derivativa
% crazyflie_set_pid_z(crazyflie_1, 2.00, 0.50, 0.01);
% crazyflie_set_pid_z(crazyflie_1, 2.00, 0.50, 0.02);
% crazyflie_set_pid_z(crazyflie_1, 2.00, 0.50, 0.03);
% crazyflie_set_pid_z(crazyflie_1, 2.00, 0.50, 0.04);
% crazyflie_set_pid_z(crazyflie_1, 2.00, 0.50, 0.05);

% Cuarto set de pruebas - Mezclas de constantes
% crazyflie_set_pid_z(crazyflie_1, 5.00, 2.00, 0.00);
% crazyflie_set_pid_z(crazyflie_1, 4.50, 2.00, 0.00); % Overshoot
% crazyflie_set_pid_z(crazyflie_1, 4.00, 2.00, 0.01);