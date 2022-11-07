clear all
close all

%%% fixed parameters
Scell   = 3.52e-8;  % cm^2
K_H     = 0.65;     % cm-1
kd      = 0.60;     % min^-1
km      = 7.66;     % mug/cm^2
xx      = 1.29;     % -
det_lim = 1;        % when number cell<10 assume 10


%%% Load experiments
[tt,expN,expB,NLog,infor]=get_Experimental_Data(1:5,det_lim);
init_load=[1.43251e+08	1.89526e+08	3.56886e+07	1.47264e+08 4.50e6 1.34045e+07];

%%% simulate each experiment
for iexp=1:6
    if iexp<6
        N0=init_load(iexp);
        C0=expB{iexp}(1);
    else
        N0=init_load(iexp);
        C0=expB{iexp-1}(1);
        tt{iexp}=tt{iexp-1};
        NLog{iexp}=NLog{iexp-1};
        expB{iexp}=expB{iexp-1};
    end
    
    [t,x]=ode15s(@theMODEL,0:0.25:10,[N0,0],[],N0,C0,K_H,Scell,kd,km,xx);

    %%% necessary for plotting
    results.sim.tsim{iexp}          = t;
    ind=find(x(:,1)<det_lim);x(ind,det_lim) = 1;
    results.sim.obs{iexp}(:,1)      = log10(x(:,1));
    results.sim.obs{iexp}(:,2)      = C0-x(:,2)*Scell*N0;
    results.sim.states{iexp}(:,4)   = x(:,2);
    inputs.exps.t_s{iexp}           = tt{iexp};
    inputs.exps.exp_data{iexp}(:,1) = NLog{iexp};
    inputs.exps.exp_data{iexp}(:,2) = expB{iexp};
end

get_Plot


function dx=theMODEL(t,x,N0,C0,K_H,Scell,kd,km,xx);
N=x(1);
Cm=x(2);
Cm_eq=K_H*C0/(1+K_H*Scell*N0);
dN=-kd*N^xx*(Cm^30./(Cm^30+km^30));
dCm=30*(Cm_eq-Cm);
dx=[dN, dCm]';
end
