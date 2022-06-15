clear all
close all
%rng('shuffle')

%% Model

%===================================
% PATHs DATA
%===================================

inputs.pathd.results_folder=mfilename;
inputs.pathd.short_name='DEF';
inputs.plotd.plotlevel='min';
inputs.plotd.figsave=1;

%
%===================================
% MODEL RELATED DATA
%===================================
inputs.model.exe_type='standard';
inputs.model.input_model_type='charmodelM';
inputs.model.n_st=3;
inputs.model.n_stimulus=0;
inputs.model.names_type='custom';
inputs.model.st_names=char('WN','N0','C0');
inputs.model.par_names=char('kd','xx','aa','Cwall','MIC','nv');
inputs.model.n_par=size(inputs.model.par_names,1);
inputs.model.stimulus_names=char('');
inputs.model.eqns=char('dN0=0',...
    'dC0=0',...
    'NN=N0-WN',...
    'Sads=3.52e-8*N0',...
    'Cads=(C0-Cwall)/(aa+Sads)',...
    'dWN=-(-kd*NN^xx*Cads^nv/(MIC^nv+Cads^nv))');

par=[ 0.500000005122623   1.307144365112920   5.923007800332060  20.261860660169528   2.000036540091954];
par=[ 0.225203948992396   1.398912890531431   5.899937469890336  20.423833468305460   2.019951562476248];

init_cond{1}= [1.432508980375180e+08] ;      
init_cond{2}= [2.355436068304538e+08] ;
init_cond{3}= [1.034096390111049e+07] ;
init_cond{4}= [2.304954015774227e+08] ;


            


inputs.model.par=[par 30];


%%
%===================================
%EXPERIMENTAL DATA
%===================================
inputs.exps.data_type= 'real';
inputs.exps.noise_type = 'homo_var';
pick_experiments=[1:4];
inputs.exps.n_exp=length(pick_experiments);
[r_t,r_N,r_B,r_NLog,infor]=Experimental_data(inputs.exps.n_exp);

varN=0.5;
varB=2.5;
iexp=1;
for iexp=pick_experiments
    
    inputs.exps.t_f{iexp}=r_t{iexp}(end);                                           % Experiments duration
    inputs.exps.n_s{iexp}=size(r_t{iexp}(2:end),2);                                        % Number of sampling times
    inputs.exps.t_s{iexp}=r_t{iexp}(2:end);
    
    % Sampling times
    inputs.exps.exp_y0{iexp}=[  0 init_cond{iexp}(1) r_B{iexp}(1)];%r_B{iexp}(1)-mean([r_B{iexp}(end-1) r_B{iexp}(end)])] %r_B{iexp}(end)
     %inputs.exps.exp_y0{iexp}=[  r_N{iexp}(1)  r_N{iexp}(1) r_B{iexp}(1)];%r_B{iexp}(1)-mean([r_B{iexp}(end-1) r_B{iexp}(end)])] %r_B{iexp}(end)
    
    inputs.exps.n_obs{iexp}=2;
    inputs.exps.exp_data{iexp}=[r_NLog{iexp}(2:end)' r_B{iexp}(2:end)'];
    inputs.exps.error_data{iexp}=[varN*ones(size(r_NLog{iexp}(2:end)')) varB*ones(size(r_B{iexp}(2:end)'))];
    inputs.exps.obs_names{iexp}=char('logN','BAC');
    inputs.exps.obs{iexp}=char('logN=log10(N0-WN);ind=find(log10(N0-WN)<1);logN(ind)=1*ones(size(ind));','BAC=aa*(C0-Cwall)./(aa+(3.52e-8).*N0);BAC(1)=C0(1)');
    
    inputs.PEsol.id_local_theta_y0{iexp}=char('N0');             % [] 'all'|User selected| 'none' (default)
    inputs.PEsol.local_theta_y0_max{iexp}=[10^(log10(r_N{iexp}(1))+(varN)) ];
    inputs.PEsol.local_theta_y0_min{iexp}=[10^(log10(r_N{iexp}(1))-(varN)) ];

    %inputs.PEsol.local_theta_y0_guess{iexp}=[r_N{iexp}(1)];%
 
    inputs.PEsol.local_theta_y0_guess{iexp}=init_cond{iexp};%[r_B{iexp}(1) r_N{iexp}(1)];%

    
end


inputs.PEsol.id_global_theta=char('kd','xx','aa','Cwall','MIC');
inputs.PEsol.global_theta_max=[15, 2, 100,  45, 10];
inputs.PEsol.global_theta_min=[0.1  1     1    0  0.01];
npar=size(inputs.PEsol.id_global_theta,1);
inputs.PEsol.global_theta_guess= par(1:npar);
inputs.nlpsol.eSS.log_var=[1:npar];
inputs.PEsol.PEcost_type='llk';


inputs.nlpsol.eSS.maxeval = 1e10;
inputs.nlpsol.eSS.maxtime = 60*3;
inputs.nlpsol.nlpsolver = 'ess'; %'local_fminsearch';%
inputs.nlpsol.eSS.local.solver='fmincon';%'fminsearch';
inputs.nlpsol.eSS.local.n1=25;      %Number of iterations before applying local search for the 1st time
inputs.nlpsol.eSS.local.iterprint =1;

inputs.nlpsol.nlpsolver='local_fmincon';


inputs.ivpsol.ivpsolver='ode15s';
inputs.ivpsol.rtol=1.0D-12;                            % [] Ivp solver integration tolerances
inputs.ivpsol.atol=1.0D-12;

inputs.rid.conf_ntrials=300;
inputs.plotd.n_t_plot=50;  


%% Calculations for estimation
AMIGO_Prep(inputs)  % preprocessing
results_PE=AMIGO_PE(inputs);

