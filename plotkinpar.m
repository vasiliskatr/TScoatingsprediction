%% Plot figures of the calculated kinematic spray parameters
%
% k-> Kinematc paramaters results matrix        
% na-> Name of the analysed gemetry (string)
% np-> USER INPUT, Number of spreyed pass tha is displayed (integer)
%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%


function plotkinpar(k,na,np)


ax1=subplot(2,2,1);
scatter(1:1:360,k{np}(:,1));
title(ax1,['SoD of pass ', num2str(np)])
grid on
xlabel('Iteration steps (360=1 full rotation)') % x-axis label
ylabel('SOD (mm)') % y-axis label

ax2=subplot(2,2,2);
scatter(1:1:360,k{np}(:,2));
title(ax2,['impact angle of pass ', num2str(np)]);
grid on
xlabel('Iteration steps (360=1 full rotation)') % x-axis label
ylabel('Impact angle (deg.)') % y-axis label

ax3=subplot(2,2,3);
scatter(1:1:360,k{np}(:,3));
title(ax3,['azimuth angle of pass ', num2str(np)]);
grid on
xlabel('Iteration steps (360=1 full rotation)') % x-axis label
ylabel('Azimuth angle (deg.)') % y-axis label

ax4=subplot(2,2,4);
scatter(1:1:360,k{np}(:,4));
title(ax4,['trav. speed of pass ', num2str(np)]);
grid on
xlabel('Iteration steps (360=1 full rotation)') % x-axis label
ylabel('Gun travrese speed (mm/s)') % y-axis label

end