

clear all
% load estimation
load Kinetics_calibration_Data

%% Use estimated parameters     
par=results_PE.fit.global_theta_estimated;
init_cond=  results_PE.fit.local_theta_y0_estimated;

inputs.model.par=[par 30];

%% Add the new experiment for validation    

pick_experiments=[1:5];
inputs.exps.n_exp=length(pick_experiments);
[r_t,r_N,r_B,r_NLog,infor]=Experimental_data(inputs.exps.n_exp);

for iexp=5
    init_cond{iexp}=r_N{iexp}(1)
    inputs.exps.t_f{iexp}=r_t{iexp}(end);                                           % Experiments duration
    inputs.exps.n_s{iexp}=size(r_t{iexp}(2:end),2);                                        % Number of sampling times
    inputs.exps.t_s{iexp}=r_t{iexp}(2:end);
    
    % Sampling times
    inputs.exps.exp_y0{iexp}=[  0 init_cond{iexp}(1) r_B{iexp}(1)];%r_B{iexp}(1)-mean([r_B{iexp}(end-1) r_B{iexp}(end)])] %r_B{iexp}(end)
    
    inputs.exps.n_obs{iexp}=2;
    inputs.exps.exp_data{iexp}=[r_NLog{iexp}(2:end)' r_B{iexp}(2:end)'];
    inputs.exps.error_data{iexp}=[varN*ones(size(r_NLog{iexp}(2:end)')) varB*ones(size(r_B{iexp}(2:end)'))];
    inputs.exps.obs_names{iexp}=char('logN','BAC');
    inputs.exps.obs{iexp}=char('logN=log10(N0-WN);ind=find(log10(N0-WN)<1);logN(ind)=1*ones(size(ind));','BAC=aa*(C0-Cwall)./(aa+(3.52e-8).*N0);BAC(1)=C0(1)');
    inputs.PEsol.id_local_theta_y0{iexp}='none';
    
end

%% Calcualtions for validation
results=AMIGO_SData(inputs);



