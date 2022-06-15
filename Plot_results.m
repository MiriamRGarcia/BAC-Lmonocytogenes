clear all
close all
load Kinetics_validation_Data

% https://uk.mathworks.com/help/matlab/creating_plots/default-property-values.html

set(0, 'DefaultLineLineWidth', 1.5);
set(0,'DefaultAxesFontSize',12);
set(0,'DefaultaxesFontWeight', 'normal'); 
set(0,'DefaultaxesLineWidth', 1); 
set(0,'DefaultLineMarkerSize',6);
get(0,'defaultfigureposition');

figure
set(gcf,'Position',[ 684         574        1007         404]);
color={'b' 'c' 'r' 'm' 'k' };


%%% Fits

for ii=1:inputs.exps.n_exp-1

        subplot(121),plot(results.sim.tsim{ii},results.sim.obs{ii}(:,1),[color{ii}]);hold on
        subplot(122),plot(results.sim.tsim{ii},results.sim.obs{ii}(:,2),[color{ii}]);hold on

end


%%%% validation

for ii=5

        subplot(121),plot(results.sim.tsim{ii},results.sim.obs{ii}(:,1),[color{ii},'--']);hold on
        subplot(122),plot(results.sim.tsim{ii},results.sim.obs{ii}(:,2),[color{ii},'--']);hold on

end
legend(infor{pick_experiments})

for ii=1:inputs.exps.n_exp-1
    
    
    subplot(121),plot([0 inputs.exps.t_s{ii}],[r_NLog{ii}(1) inputs.exps.exp_data{ii}(:,1)'],[color{ii},'o'],'MarkerFaceColor',color{ii});hold on
    
    subplot(122),plot([0 inputs.exps.t_s{ii}],[r_B{ii}(1) inputs.exps.exp_data{ii}(:,2)'],[color{ii},'o'],'MarkerFaceColor',color{ii});hold on
    
end


for ii=1:inputs.exps.n_exp-1
    
    subplot(121),plot(results.sim.tsim{ii},results.sim.obs{ii}(:,1),[color{ii}]);hold on
        subplot(122),plot(results.sim.tsim{ii},results.sim.obs{ii}(:,2),[color{ii}]);hold on

end



for ii=5

          subplot(121),plot([0 inputs.exps.t_s{ii}],[r_NLog{ii}(1) inputs.exps.exp_data{ii}(:,1)'],[color{ii},'o'],'MarkerFaceColor',color{ii});hold on
          xlabel('Contact time [min]');ylabel('Viable {\it L. Monocytogenes} [cpu/ml]');box off
          ylim([0,10])
          subplot(122),plot([0 inputs.exps.t_s{ii}],[r_B{ii}(1) inputs.exps.exp_data{ii}(:,2)'],[color{ii},'o'],'MarkerFaceColor',color{ii});hold on
          xlabel('Contact time [min]');ylabel('Free BAC [ppm]');box off
end

   
name='Results';
savefig([name,'_Fig']) % save figure

