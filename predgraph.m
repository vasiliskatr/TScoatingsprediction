%% Visualisation of predicted properties 
%
% Predicted coating properties are presented in indivudial graphs
%
%
% normp-> Cell array (N x 1, N->number of sprayed passes) normalized predictions for each examined coating property for all the nodes, in ll the sprayed passes.
% c-> coeficients to be applied on the normalized predictions to yield actual predictions, essentially the maximum value of the
% experimental results for each examined coating property. 
% np- USER INPUT (integer), index of sprayed pass that is presented in the graphs
%
%
%%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%
%



function predgraph (normp,c,np)

range=(1:1:360);

figure; %Thickness
p=plot(range,(normp{np}(1:length(range),1))*c(1),'k');
title(['Coating thickness prediction of sprayed pass ', num2str(np)])
xlabel('Iteration steps (360=1 full rotation)'); % x-axis label
ylabel('Coating thickness (um)'); % y-axis label
grid on
grid minor
p(1).LineWidth = 1;

figure; %Microhardness
p=plot(range,(normp{np}(1:length(range),2))*c(2),'k');
title(['Microhardness of sprayed pass ', num2str(np)])
xlabel('Iteration steps (360=1 full rotation)'); % x-axis label
ylabel('microhardness (HV0.3)'); % y-axis label
grid on
grid minor
p(1).LineWidth = 1;

figure; %Porosity
p=plot(range,(normp{np}(1:length(range),3))*c(3),'k');
title(['Porosity of sprayed pass ', num2str(np)])
xlabel('Iteration steps (360=1 full rotation)'); % x-axis label
ylabel('Porosity (%)'); % y-axis label
grid on
grid minor
p(1).LineWidth = 1;

figure; % Compressive Residual stresses
p=plot(range,(normp{np}(1:length(range),4))*c(4),'k');
title(['Compressive residual stress level of sprayed pass ', num2str(np)])
xlabel('Iteration steps (360=1 full rotation)'); % x-axis label
ylabel('Compressive residual stress level (a.u.)'); % y-axis label
grid on
grid minor
p(1).LineWidth = 1;

figure; %Wc Vol%
p=plot(range,(normp{np}(1:length(range),5))*c(5),'k');
title(['WC Vol.% of sprayed pass ', num2str(np)])
xlabel('Iteration steps (360=1 full rotation)'); % x-axis label
ylabel('WC Vol.%'); % y-axis label
grid on
grid minor
p(1).LineWidth = 1;

figure; %Binder Mean free path
p=plot(range,(normp{np}(1:length(range),6))*c(6),'k');
title(['Binder mean free path of sprayed pass ', num2str(np)])
xlabel('Iteration steps (360=1 full rotation)'); % x-axis label
ylabel('Binder mean free path (nm)'); % y-axis label
grid on
grid minor
p(1).LineWidth = 1;

figure; %O at.%
p=plot(range,(normp{np}(1:length(range),7))*c(7),'k');
title(['Oxygen at.% of sprayed pass ', num2str(np)])
xlabel('Iteration steps (360=1 full rotation)'); % x-axis label
ylabel('O at.%'); % y-axis label
grid on
grid minor
p(1).LineWidth = 1;

figure; %Specific wear rate
p=plot(range,(normp{np}(1:length(range),8))*c(8),'k');
title(['Specific wear rate of sprayed pass ', num2str(np)])
xlabel('Iteration steps (360=1 full rotation)'); % x-axis label
ylabel('Specific wear rate (mm^3m^-^1N^-^1)'); % y-axis label
grid on
grid minor
p(1).LineWidth = 1;
end