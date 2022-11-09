clear all
close all

%% Parameters
% Detection limit
det_lim = 1;                                                            % detection limit (logN<1)

% For calculation of cell surface
r       = 0.335;                                                        % [\mu m]     Half the width in Harris 2016
L       = 1;                                                            % [\mu m]     Length with caps (2.5 with caps in Harris 2016)
Scellmum= 2*pi*r*(2*r + L);                                             % [\mu m^2]   Cell surface
Scell   = Scellmum/(10000)^2;                                           % [cm^2]      Cell surface in cm

% Estimated parameters
K_H     = 0.65;                                                         % [cm-1]      Adsorption rate constant (Henry's constat)
kd      = 0.60;                                                         % [min^-1]    Maximum inactivation rate constant
km      = 7.66;                                                         % [mug/cm^2]  Adsorbed BAC to kill the cell
xx      = 1.29;                                                         % -           Constant Rational mode



%% Load experiments
[tt,expN,expB,NLog,infor]=get_Experimental_Data(1:6,det_lim);

% Initial load/inoculum values. 
init_load=[1.43251e+08,...                                              % Estimated within the expected error of the method, that is+- 0.5 logs the measure)
    1.89526e+08,...
    3.56886e+07,...
    1.47264e+08,...
    expN{5}(1),...                                                      % not estimated
    1.34045e+07];


%% Simulate each experiment
for iexp=1:6
    
    % Initial conditions                  	                                        
    N0=init_load(iexp);                                                 % Initial incoculum
    C0=expB{iexp}(1);                                                   % Initial BAC dose

    % Sovel ODE system
    [t,x]=ode15s(@theMODEL,0:0.25:10,[N0,0],[],N0,C0,K_H,Scell,kd,km,xx);

    % necessary for plotting
    tsim{iexp}          = t;                                            % [min]     Simulation time 
    ind=find(x(:,1)<det_lim);x(ind,det_lim) = 1;                        % For detection limit zone
    obs{iexp}(:,1)      = log10(x(:,1));                                % log10cfus Plot listeria in log10(cfus)
    obs{iexp}(:,2)      = C0-x(:,2)*Scell*N0;                           % ppm       Calculate adsorbed BAC
    states{iexp}(:,4)   = x(:,2);                                       % ppm       Free BAC
    t_s{iexp}           = tt{iexp};                                     % [min]     Sampling times
    exp_data{iexp}(:,1) = NLog{iexp};                                   % experimental data listeria
    exp_data{iexp}(:,2) = expB{iexp};                                   % esperimental data free BAC
end

%% Plot results
get_Plot


%% The kinetic model based on adsorption
function dx=theMODEL(t,x,N0,C0,K_H,Scell,kd,km,xx);
N=x(1);                                                                 % cfus Listeria
Cm=x(2);                                                              	% ppm free BAC
Cm_eq=K_H*C0/(1+K_H*Scell*N0);                                          % Calculate adsorbed BAC in equilibrium
dN=-kd*N^xx*(Cm^30./(Cm^30+km^30));                                     % Calculate cfus Listeria
dCm=30*(Cm_eq-Cm);                                                      % Calculated adsorbed BAC
dx=[dN, dCm]';
end
