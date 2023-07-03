


%% Default properties for graphics
set(0, 'DefaultLineLineWidth', 1.5);
set(0,'DefaultAxesFontSize',12);
set(0,'DefaultaxesFontWeight', 'normal'); 
set(0,'DefaultaxesLineWidth', 1); 
set(0,'DefaultLineMarkerSize',6);
get(0,'defaultfigureposition');

figure
set(gcf,'Position',[  913   624   910   537]);
color={'b' 'c' 'r' 'm' 'k' 'k'};


%% Plot results
for ii=1:6
    if ii==5
        subplot(221),plot(tsim{ii},obs{ii}(:,1),[color{ii},'--']);hold on
        subplot(223),plot(tsim{ii},obs{ii}(:,2),[color{ii},'--']);hold on
        subplot(224),plot(tsim{ii},states{ii}(:,4),[color{ii},'--']);hold on
    elseif ii==6
        subplot(221),plot(tsim{ii},obs{ii}(:,1),[color{ii},'-.']);hold on
        xlabel('Contact time [min]');ylabel({'Viable  {\it L. Monocytogenes}','[log10(CFU/mL)]'});box off
        subplot(223),plot(tsim{ii},obs{ii}(:,2),[color{ii},'-.']);hold on
        xlabel('Contact time [min]');ylabel('Free BAC [ppm]');box off
        subplot(224),plot(tsim{ii},states{ii}(:,4),[color{ii},'-.']);hold on
        xlabel('Contact time [min]');ylabel({'BAC adsorbed in',' membrane [mg/cm^2]'});box off
    else
        subplot(221),plot(tsim{ii},obs{ii}(:,1),[color{ii}]);hold on
        subplot(223),plot(tsim{ii},obs{ii}(:,2),[color{ii}]);hold on
        subplot(224),plot(tsim{ii},states{ii}(:,4),[color{ii}]);hold on
    end
end

hold on;subplot(221),area(tsim{1},2*ones(size(tsim{1})),'FaceColor','r','FaceAlpha',.2,'EdgeAlpha',.2)

for ii=1:5
    subplot(221),plot([t_s{ii}],exp_data{ii}(:,1)',[color{ii},'o'],'MarkerFaceColor',color{ii});hold on
    subplot(223),plot([t_s{ii}],exp_data{ii}(:,2)',[color{ii},'o'],'MarkerFaceColor',color{ii});hold on
end

%% Plot legends
for ii=1:4
    mylegend{ii}=['Fit ',infor{ii}];
end
mylegend{5}='Validation:60ppm,6log';
mylegend{6}='Validation estimating the inoculum';
for ii=7:11
    mylegend{ii}=['Data ',infor{ii-6}];
end
legend(mylegend,'Position',[0.613942594889946 0.617016630744266 0.222319853850534 0.273622039421963])

   
%% Save figure
savefig('fig_Kinetic_model') % save figure

