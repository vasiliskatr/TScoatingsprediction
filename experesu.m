%% Input, Interpolation and Visualization of the experimetal results based on HVOF SPRAY of WC-Co coatings
% Detailed discusion of these results can be found in the links bellow:
%
% https://www.sciencedirect.com/science/article/pii/S0257897217300166
% https://www.sciencedirect.com/science/article/pii/S0257897217309131
%
%** THE EXPERIMENTAL DATA CORRESPOND TO A COATING COMPRISED OF 20 CONSECUTIVE COTING
%LAYERS (1 SPRAY PASS OF THE WHOLE GEOMETRY YIELDS 1 COATING LAYER). ALL NON-NORMALIZED PREDICTIONS ARE VALID FOR
%AN EQUIVALEND NUMEBR OF CONSECUTIVE SPRAY PASSES.**
%
%
%At this stage, the raw result data is entered in the script manually, a
%functionality that enables rading results from .csv files may be added for
%easier input of new results
%
%
% a-> Interpolated epxerimentla results matrix
% speedpoints-> Intepolated gun traverse speed vector
% totp-> number of sprayed layers used for the experimental results
%
%** SOD->Stand of distance (refering the distance between the spray gun and the coated substrate)
%
%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%

function [a,speedpoints,totp]=experesu

%% Input of Experimntal results

totp=20; % USER INPUT/ total number of consecutive pases of the spray gun over the same spot during
%the experiments that are used. At the moment this value is returned from
%the experesu function but is not used in the rest of the code. This might
%change in future versions of the program where the this information might
%be useful (i.e. calculating the number of coating layers needed so that a
%given coating thickness is achieved in diffcult areas.)


exp=cell(2,8);
%exp{:,1}->thickness (um)
exp{1,1}=[364 396 397 413
    341	336	370	426
    274	270	325	307
    217	233	250	248
    147	185	224	211];
exp{2,1}=[364,281,95];
%exp{:,2}->microhardness (HV)
exp{1,2}=[1365	1323	1176	795
    1337	1321	1204	889
    1260	1254	1180	891
    1210	1189	1123	893
    1108	1105	1068	921];
exp{2,2}=[1365	1339	1308];
%exp{:,3}-> porosity (%)
exp{1,3}=[0.15	0.14	0.28	0.61
    0.24	0.26	0.37	0.66
    0.33	0.32	0.49	0.49
    0.23	0.35	0.35	0.54
    0.33	0.7	    0.77	0.65];
exp{2,3}=[0.15	0.16	0.16];
%exp{:,4}-> res.stress (au.)
exp{1,4}=[1.12	0.84	0.54	0.51
    1.09	0.91	0.40	0.47
    1.21	0.65	0.23	0.28
    0.92	0.68	0.42	0.38
    0.73	0.53	0.29	0.41];
exp{2,4}=[1.12	1.7	1.32];
%exp{:,5}-> WC Vol% (%)
exp{1,5}=[51.9	49.1	49.3	48.4
    49	51.3	50	49.8
    46.1	46.1	46.3	47.6
    43.9	39.1	41.4	39.7
    32	37	38.3	38.7];
exp{2,5}=[51.9	49	50.9];
%exp{:,6}-> Co mean free path (nm)
exp{1,6}=[511	551	658	892
    594	619	586	702
    667	728	813	814
    634	765	912	824
    1037	1060	1044	883];
exp{2,6}=[551	566	561];
%exp{:,7}->O atomic% (%)
exp{1,7}=[5.3	6.26	6.8	6.3
    5.18	5.8	7.2	6.8
    8	6.5	6.28	9.24
    8.38	6.98	6.9	8.54
    7.74	8.3	7.86	7.48];
exp{2,7}=[5.3	6.8	8.74];
%exp{:,8}-> Wear coefficient (mm^3/(N*m))
exp{1,8}=[5.21E-08	5.96E-08	1.19E-07	2.80E-07
    5.73E-08	4.90E-08	1.26E-07	2.15E-07
    8.22E-08	1.00E-07	1.61E-07	2.46E-07
    9.20E-08	1.04E-07	2.07E-07	3.23E-07
    1.74E-07	1.46E-07	2.66E-07	3.94E-07];
exp{2,8}=[5.21E-08	5.33E-08	9.3E-8];
%% set the exp points for interpolation
%
scatterr=[119,90
    119,75
    119,60
    119,45
    119,29
    138,90
    138,75
    138,60
    138,45
    138,29
    170,90
    170,75
    170,60
    170,45
    170,29
    241,90
    241,75
    241,60
    241,45
    241,29];
%***speeds,***
speeds=[499;670;2010];
%*** speedponts,***
speedpoints=(499:1:2010)';
expin=cellfun(@(x) reshape(x,[],1),exp,'uniformOutput',false); % make exp into row vectors 
%% Interpolations of experimental results
a=cell(2,length(exp(1,:))+2);
%SoD vs impact angle interpolations
[a{1,1},a{1,2}]=meshgrid(119:1:241,29:1:90); % meshgrid (SOD range, impact angle range)
a{1,3}=griddata(scatterr(:,1),scatterr(:,2),expin{1,1},a{1,1},a{1,2},'cubic');%thickness angle sod interpolation
a{1,4}=griddata(scatterr(:,1),scatterr(:,2),expin{1,2},a{1,1},a{1,2},'cubic');%microhardness angle sod interpolation
a{1,5}=griddata(scatterr(:,1),scatterr(:,2),expin{1,3},a{1,1},a{1,2},'cubic');%porosity angle sod intepolation
a{1,6}=griddata(scatterr(:,1),scatterr(:,2),expin{1,4},a{1,1},a{1,2},'cubic');%res.stress angle sod intepolation
a{1,7}=griddata(scatterr(:,1),scatterr(:,2),expin{1,5},a{1,1},a{1,2},'cubic');%WC Vol% angle sod intepolation
a{1,8}=griddata(scatterr(:,1),scatterr(:,2),expin{1,6},a{1,1},a{1,2},'cubic');%Co mean free path angle sod intepolation
a{1,9}=griddata(scatterr(:,1),scatterr(:,2),expin{1,7},a{1,1},a{1,2},'cubic');%O atomic% angle sod intepolation
a{1,10}=griddata(scatterr(:,1),scatterr(:,2),expin{1,8},a{1,1},a{1,2},'cubic');%Wear coefficient angle sod intepolation

%trav.speed interpolations
a{2,3}=interp1(speeds,exp{2,1},speedpoints,'pchip');%thickness speed interpolation
a{2,4}=interp1(speeds,exp{2,2},speedpoints,'pchip');%m-hardness speed interpolation
a{2,5}=interp1(speeds,exp{2,3},speedpoints,'pchip');%porosity speed interpolation
a{2,6}=interp1(speeds,exp{2,4},speedpoints,'pchip');%res.stress speed interpolation
a{2,7}=interp1(speeds,exp{2,5},speedpoints,'pchip');%WC Vol% speed interpolation
a{2,8}=interp1(speeds,exp{2,6},speedpoints,'pchip');%Co mean free path speed interpolation
a{2,9}=interp1(speeds,exp{2,7},speedpoints,'pchip');%O atomic% speed interpolation
a{2,10}=interp1(speeds,exp{2,8},speedpoints,'pchip');%Wear coefficient speed interpolation

%% Plot the interpolated exp results
figure('name','experimetal results','Position', [10, 10, 1749, 895]);

subplot(2,4,1)
surfc(a{1,1},a{1,2},a{1,3});
title('Coating thickness results');
xlabel('SoD(mm)') % x-axis label
ylabel('Spray angle (deg.)') % y-axis label
zlabel('Coating thickness (um) ') % y-axis label
grid on
grid minor

subplot(2,4,2)
surfc(a{1,1},a{1,2},a{1,4});
title('Microhardness results');
xlabel('SoD(mm)') % x-axis label
ylabel('Spray angle (deg.)') % y-axis label
zlabel('Microhardness (HV 0.3)') % y-axis label
grid on
grid minor

subplot(2,4,3)
surfc(a{1,1},a{1,2},a{1,5});
title('Porosity results');
xlabel('SoD(mm)') % x-axis label
ylabel('Spray angle (deg.)') % y-axis label
zlabel('Porosity (%)') % y-axis label
grid on
grid minor

subplot(2,4,4)
surfc(a{1,1},a{1,2},a{1,6});
title('Residual stress results');
xlabel('SoD(mm)') % x-axis label
ylabel('Spray angle (deg.)') % y-axis label
zlabel('Res.stress (a.u.) ') % y-axis label
grid on
grid minor

subplot(2,4,5)
plot(speedpoints,a{2,3});
xlabel('Gun traverse speed (mm/sec)') % x-axis label
ylabel('Coating thickness (um) ') % y-axis label
grid on
grid minor

subplot(2,4,6)
plot(speedpoints,a{2,4});
xlabel('Gun traverse speed (mm/sec)') % x-axis label
ylabel('Microhardness (HV 0.3) ') % y-axis label
grid on
grid minor

subplot(2,4,7)
plot(speedpoints,a{2,5});
xlabel('Gun traverse speed (mm/sec)') % x-axis label
ylabel('Porosity (%) ') % y-axis label
grid on
grid minor

subplot(2,4,8)
title('norm. Residual stress');
plot(speedpoints,a{2,6});
xlabel('Gun traverse speed (mm/sec)') % x-axis label
ylabel('Res.stress (a.u.)') % y-axis label
grid on
grid minor


%second figure
figure('name','experimetal results 2','Position', [10, 10, 1749, 895]);

subplot(2,4,1)
surfc(a{1,1},a{1,2},a{1,7});
title('WC Volume fraction results');
xlabel('SoD(mm)') % x-axis label
ylabel('Spray angle (deg.)') % y-axis label
zlabel('WC Vol. (%) ') % y-axis label
grid on
grid minor

subplot(2,4,2)
surfc(a{1,1},a{1,2},a{1,8});
title('Co mean free path results');
xlabel('SoD(mm)') % x-axis label
ylabel('Spray angle (deg.)') % y-axis label
zlabel('Co mean free path (nm)') % y-axis label
grid on
grid minor

subplot(2,4,3)
surfc(a{1,1},a{1,2},a{1,9});
title('Oxygen atomic % results');
xlabel('SoD(mm)') % x-axis label
ylabel('Spray angle (deg.)') % y-axis label
zlabel('O at.%') % y-axis label
grid on
grid minor

subplot(2,4,4)
surfc(a{1,1},a{1,2},a{1,10});
title('Specific Wear rate results');
xlabel('SoD(mm)') % x-axis label
ylabel('Spray angle (deg.)') % y-axis label
zlabel('Specific Wear rate (mm^3m^-^1N^-^1) ') % y-axis label
grid on
grid minor

subplot(2,4,5)
plot(speedpoints,a{2,7});
xlabel('Gun traverse speed (mm/sec)') % x-axis label
ylabel('WC Vol. (%) ') % y-axis label
grid on
grid minor

subplot(2,4,6)
plot(speedpoints,a{2,8});
xlabel('Gun traverse speed (mm/sec)') % x-axis label
ylabel('Co mean free path (nm) ') % y-axis label
grid on
grid minor

subplot(2,4,7)
plot(speedpoints,a{2,9});
xlabel('Gun traverse speed (mm/sec)') % x-axis label
ylabel('O at.% ') % y-axis label
grid on
grid minor

subplot(2,4,8)
plot(speedpoints,a{2,10});
xlabel('Gun traverse speed (mm/sec)') % x-axis label
ylabel('Specific Wear rate (mm^3m^-^1 N^-^1)') % y-axis label
grid on
grid minor

end
