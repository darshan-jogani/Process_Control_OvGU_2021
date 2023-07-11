function [sys,x0] = evapmod_s(t,x,u,flag)
%
%  Simulink interface to evapmod.m     
%
% Inputs:    t    - time in [min].
%            x    - 3 states, product composition, operating pressure, and separator level height  
%            u(1) - F1, feed flowrate
%            u(2) - XF1, feed composition
%            u(3) - T200, cooling water inlet temperature
%            u(4) - F2, product flowrate
%            u(5) - P100, steam pressure
%            u(6) - F200, cooling water flowrate
%            u(7) - T1, feed temperature
%            u(8) - F3, circulating liquor flowrate
%
% Outputs:   sys and x0 as described in the SIMULINK manual.
%            when flag is 0 sys contains sizes and x0 contains 
%            initial condition. 
%            when flag is 1, sys contains the derivatives,
%            and when flag is 3 sys contains outputs; 
%            x(1)    - X2, the level of the first tank
%            x(2)    - P2, the level of the second tank
%            x(3)    - L2, the level of the second tank
% 
% Initialize :  define initial conditions,  X0
%               define system in terms of number of states, inputs etc.
%             e.g. sys = [3, 0, 3, 8, 0, 0];
%            1st array :  number of continuous states
%            2nd array :  number of discrete states
%            3rd array :  number of outputs
%            4th array :  number of inputs
%            5th array :  flag for direct feedthrough
%            6th array :  the number of sample times
            


if abs(flag) == 1
  % Return state derivatives.
  sys = evapmod(t,x,u);
  
elseif abs(flag) == 3
  % Return system outputs.
  sys(1,1) = x(1);       %  X2
  sys(2,1) = x(2);       %  P2
  sys(3,1) = x(3);       %  L2
  
elseif flag == 0
    
  % Initialize the system
  load init_ss
  x0=X0ss ;
  sys = [3, 0, 3, 8, 0, 0];
  
else
  sys = [];  
  
end