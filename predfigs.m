%% predictions on geometry model
%
% Intuitive visualization of the predictions on the expamined model to
% highlight the challenging areas, with respcet to coating properties that
% are examined.
%
% m-> cell array, containing the coordinates (360 X 3) of all the nodes in each of the sprayed passes, for all the sprayed passes
% np-> cell array (N x 1, N->number of sprayed passes) normalized predictions for each examined coating property for all the nodes, in all the sprayed passes.
% c-> vector(1-dimensional array) coeficients to be applied on the normalized predictions to yield actual predictions, essentially the maximum value of the
% experimental results for each examined coating property. 
%
%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%
%
%

function predfigs (m,np,c)


%Coating thickness
figure
for i=1:length(m)
title('Coating thickness prediction');
scatter3(m{i}(:,1),m{i}(:,2),m{i}(:,3),30,np{i}(:,1)*c(1));
xlabel('(mm)') 
ylabel('(mm)') 
zlabel('(mm)') 
h=colorbar;
title(h,'(um)');
hold on
end

%Microhardness
figure
for i=1:length(m)
title('Microhardness prediction');
scatter3(m{i}(:,1),m{i}(:,2),m{i}(:,3),30,np{i}(:,2)*c(2));
xlabel('(mm)') 
ylabel('(mm)') 
zlabel('(mm)') 
h=colorbar;
title(h,'(HV 0.3)');
hold on
end

%Porosity
figure
for i=1:length(m)
title('Porosity prediction');
scatter3(m{i}(:,1),m{i}(:,2),m{i}(:,3),30,np{i}(:,3)*c(3));
xlabel('(mm)') 
ylabel('(mm)') 
zlabel('(mm)') 
h=colorbar;
title(h,'(%)');
hold on
end

%Residual stresses
figure
for i=1:length(m)
title('Compressive residual stress intensity prediction');
scatter3(m{i}(:,1),m{i}(:,2),m{i}(:,3),30,np{i}(:,4)*c(4));
xlabel('(mm)') 
ylabel('(mm)') 
zlabel('(mm)') 
h=colorbar;
title(h,'(a.u.)');
hold on
end

%WC Vol%
figure
for i=1:length(m)
title('WC Vol.% prediction');
scatter3(m{i}(:,1),m{i}(:,2),m{i}(:,3),30,np{i}(:,5)*c(5));
xlabel('(mm)') 
ylabel('(mm)') 
zlabel('(mm)') 
h=colorbar;
title(h,'(%)');
hold on
end

%Co mean free path
figure
for i=1:length(m)
title('Binder mean free path prediction');
scatter3(m{i}(:,1),m{i}(:,2),m{i}(:,3),30,np{i}(:,6)*c(6));
xlabel('(mm)') 
ylabel('(mm)') 
zlabel('(mm)') 
h=colorbar;
title(h,'(nm)');
hold on
end

%O  at.%
figure
for i=1:length(m)
title('O at.% prediction');
scatter3(m{i}(:,1),m{i}(:,2),m{i}(:,3),30,np{i}(:,7)*c(7));
xlabel('(mm)') 
ylabel('(mm)') 
zlabel('(mm)') 
h=colorbar;
title(h,'(at.%)');
hold on
end

%Specific wear rate
figure
for i=1:length(m)
title('Specific Wear rate prediction');
scatter3(m{i}(:,1),m{i}(:,2),m{i}(:,3),30,np{i}(:,8)*c(8));
xlabel('(mm)') 
ylabel('(mm)') 
zlabel('(mm)') 
h=colorbar;
title(h,'(mm^3m^-^1N^-^1)');
hold on
end


end
