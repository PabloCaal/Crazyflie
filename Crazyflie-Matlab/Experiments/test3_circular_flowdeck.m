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
N = 10;
radio = 0.15;
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

%% Conexión con Robotat
robotat = robotat_connect(); 
%% Generación de trayectoria circular con origen de Robotat
agent_id = 50; % Número del marker del dron dentro del Robotat
origin = robotat_get_pose(robotat, agent_id, "eulxyz");

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
axis([-1 1 -1 1 0 2]);
view(3);
%% Desconexión Robotat
robotat_disconnect(robotat); 

%% Ejecución de vuelo en Crazyflie con Flow Deck
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


dron_id = 8;    
velocity = 0.2;
crazyflie_1 = crazyflie_connect(dron_id);
pause(1);

crazyflie_takeoff(crazyflie_1, 0.5, 2.5); % Mejores parámetros para despegue
pause(2);

for i = 1:N
    crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i), velocity);
    %crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i), 0.5);
    %crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i), 0.75);
    %crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i), 1);
    %crazyflie_move_to_position(crazyflie_1, x(i), y(i), z(i), 1.5);
    pause(0.01);
end

crazyflie_move_to_position(crazyflie_1, 0, 0, 0.5, velocity);
pause(1);

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