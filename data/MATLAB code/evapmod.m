function dxdt = evapmod(t, x, u)

%         % Input variables
%         F2 = 2; % [kg/min]
%         P100 = 194.7; % [kPa]
%         F200 = 208; % [kg/min]
%         T1 = 40; % [°C]
%         F3 = 50; % [kg/min]
%         F1 = 10; % [kg/min]
%         XF1 = 5; % []
%         T200 = 25; % [°C]
        
        % Outputs
        X2 = x(1);
        P2 = x(2);
        L2 = x(3);
        
        % Variables
        F1 = u(1);
        XF1 = u(2);
        T200 = u(3);
        F2 = u(4);
        P100 = u(5);
        F200 = u(6);
        T1 = u(7);
        F3 = u(8);

        % Parameters
        C = 4; 
        Cp = 0.07;
        lam = 38.5; 
        lams = 36.6; 
        rhoA = 20;
        M = 20; 
        UA2 = 6.84;

        % Algebraic equations
        % Evaporator and steam jacket
        T2 = 0.5616*P2 + 0.3126*X2 + 48.43;
        T3 = 0.507*P2 + 55;
        T100 = 0.1538*P100 + 90;
        Q100 = 0.16*(F1 + F3)*(T100 -T2);
        F100 = Q100/lams;
        F4 = (Q100 - F1*Cp*(T2 - T1))/lam;

        %Condenser
        Q200 = UA2*(T3-T200)/(1+UA2/(2*Cp*F200));
        F5 = Q200/lam;

        %Differential equations
        dX2dt = (F1*XF1 - F2*X2)/M;
        dP2dt = (F4 - F5)/C;
        dL2dt = (F1 - F4 - F2)/rhoA;

        %Output
        dxdt = [dX2dt;dP2dt;dL2dt];
end