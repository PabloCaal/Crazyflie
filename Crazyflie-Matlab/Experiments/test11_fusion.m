% =========================================================================
% PROYECTO DE GRADUACIÓN: HERRAMIENTAS DE SOFTWARE PARA CRAZYFLIE
% Pablo Javier Caal Leiva - 20538
% -------------------------------------------------------------------------
% Prueba de fusión de sensores
% =========================================================================

%% Añadir al path las carpetas de comandos usando una ruta relativa
addpath('../../Crazyflie-Matlab');
addpath('../../Robotat');

%% Conexión dron, robotat y actualización de posición inicial
robotat = robotat_connect();
agent_id = 50; 
dron_id = 8; 
crazyflie_1 = crazyflie_connect(dron_id);

%% Desconexión
robotat_disconnect(robotat);
crazyflie_disconnect(crazyflie_1);

%% Actualización de posición inicial
pose = robotat_get_pose(robotat, agent_id);
disp(pose);
crazyflie_set_position(crazyflie_1, pose(1), pose(2), pose(3));

%% Despegue y actualización manual
crazyflie_takeoff(crazyflie_1, 0.5, 1.0);

pausa = 0.25;
try
    pause(pausa);
    pose = robotat_get_pose(robotat, agent_id);
    crazyflie_set_position(crazyflie_1, pose(1), pose(2), pose(3));
    pause(pausa);
    pose = crazyflie_get_pose(crazyflie_1);
catch
    dips("No se pudo actualizar la posición.")
end

try
    pause(pausa);
    pose = robotat_get_pose(robotat, agent_id);
    crazyflie_set_position(crazyflie_1, pose(1), pose(2), pose(3));
    pause(pausa);
    pose = crazyflie_get_pose(crazyflie_1);
catch
    dips("No se pudo actualizar la posición.")
end

try
    pause(pausa);
    pose = robotat_get_pose(robotat, agent_id);
    crazyflie_set_position(crazyflie_1, pose(1), pose(2), pose(3));
    pause(pausa);
    pose = crazyflie_get_pose(crazyflie_1);
catch
    dips("No se pudo actualizar la posición.")
end

crazyflie_land(crazyflie_1);
%crazyflie_disconnect(crazyflie_1);

%% ciclo de actualización de posición
crazyflie_takeoff(crazyflie_1, 0.5, 1.0);

pausa = 0.25;
num_iterations = 3 / pausa;  
for i = 1:num_iterations
    try
        pause(pausa);
        pose = robotat_get_pose(robotat, agent_id);
        crazyflie_set_position(crazyflie_1, pose(1), pose(2), pose(3));
        pose = crazyflie_get_pose(crazyflie_1);
    catch
        dips("No se pudo actualizar la posición.")
    end
end

crazyflie_land(crazyflie_1);
%crazyflie_disconnect(crazyflie_1);