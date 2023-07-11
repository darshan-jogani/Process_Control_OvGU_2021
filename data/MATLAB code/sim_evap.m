close all
clc

global F2 P100 F200 F1 XF1 T1 F3 T200

% Inputs
F2 = 2; % [kg/min]
P100 = 194.7; % [kPa]
F200 = 208; % [kg/min]
F1 = 10; % [kg/min]
T1 = 40; % [°C]
XF1 = 5; % [%]
F3 = 50; % [kg/min]
T200 = 25; % [°C]

% Abitray initial conditions for the ODE system are given in a vector: X0
X0 = [7;7;7];

% Simulation sarting time and final time are given in a vector: tspan.
tspan = [0 300];

% Small tolerance values are required to get accurate numerical solution.
options = odeset('RelTol',1e-6,'AbsTol',[1.0e-6 1.e-06 1.e-06]);

% Call Matlab odesolver
[t,x]=ode45(@evapmod,tspan, X0, options);

% Store the results at the final time in the variable X0.
X0= x(end,:);

% Plot the simulation results
figure(1),
plot(t,x(:,1),"k");
hold on
grid on
plot(t,x(:,2),"r");
plot(t,x(:,3),"b");
legend('X2 (Product composition)','P2(operating pressure)', 'L2 (Separator level)',"location","best");
xlabel('t');
ylabel('output value');
title("Simulation result")
hold off

% Observe the simulation result in figure (1).
X0(3)=1; % Overwrite X0(3) to be 1.0 as given in the literature data
tspan=[0 300];
[t,x]=ode45(@evapmod,tspan, X0, options);
X0ss= x(end,:) ; % Create the variable X0ss with steady state solution.
save init_ss X0ss; % Save X0ss under filename "init_ss"

% Obseve the result in figure(2): now all outputs should be starting with steady state
figure(2),
plot(t,x(:,1),"k");
hold on
grid on
plot(t,x(:,2),"r");
plot(t,x(:,3),"b");
legend('X2 (Product composition)','P2(operating pressure)','L2 (Separator level)',"location","best");
xlabel('t');
ylabel('output value');
title("Steady-state response ")
hold off

% Exports plots as pdf in a vector form
% exportgraphics(figure(2),'twoplots.eps')
exportgraphics(figure(2),'steady-state.pdf','ContentType','vector')
exportgraphics(figure(1),'simulation.pdf','ContentType','vector')