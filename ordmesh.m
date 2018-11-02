%% Calculate lines of sight (LOS) based on given precision(ln=180), center of mass(CM) and assuming rotation axis passes through the Cm
%
% The sprayed passes 3D polygons serve as the basis on which an ordered mesh is constructed, defining the analysed geometry.
% The methof of meshing relies on the intersection points between each sprayed pass-polygon and a numer of straight 
% lines passing from the rotation axis. This lines effectively represent
% the lines-of-sight between the spray gun and the sprayed geometry since
% the spray gun is either located at the rotation axis (internal spray) or
% directed at the rotation axis (external spray). Using this method, some
% usefull conclusions on the sprayablity of the analysed geometry can be
% made: (i) if there are more than 3 intersections of a line and a spray
% pass-polygon, it means that there is shadowing due to the complexity of
% the geometry and the part is not sprayable and (ii) if there is less than
% 2 intersections between a line and a sprayed pass-polygon, it means either
% that the geometry is not a closed shape or that there is a discontinuois
% spray at some angular rnage, during the (simulated) part rotation
%
%
%
% m-> OUTPUT/ cell array, containing the coordinates (360 X 3) of all the nodes in each of the sprayed passes, for all the sprayed passes (USED FOR KINEMATIC CALCULATIONS)
% dist-> OUTPUT/ cell array, containing the distances between the rotation axis and each node, for each sprayed pass (USED FOR KINEMATIC CALCULATIONS)
% p->cell array of size (N x 1, where N is the number of calculated sprayed passes) containing the coordinates of each sprayed pass as a 3D polygon (M x 3)
% z-> array of the Z values of all the calculated sprayed passes
% f-> integer [0 or 1] indicating internal or external spray 
% d-> aray of scalars denoting the dimensions of the analyised geometry
% n-> name of STL, string
%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%

function [m,dist]=ordmesh(p,z,f,d,n)

ln=180;% 180 lines yield 360 intersections with the sprayed polygons since they pass through the rotation axis
los=[zeros(ln,1),zeros(ln,1),sin(0:0.0175:(0.0175*(ln-1)))',cos(0:0.0175:(0.0175*(ln-1)))']; % the first point of the los will be 0,0 since the whole geometry is cenetered around CG earlier


%**CHECKPOINT** calculate intersections of los and sprayed deometry per pass (2d polygon).This will create an ordered mesh on the sprayed surface
gridd=cell(length(p),5); %1st column is the intersection points with los, 2nd column is the los (id) that have >2 intersection points, 3 id s of shadowing los
figure;

for i=1:length(p)
    for j=1:ln
        gridd{i,1}{j,1}=intersectLinePolygon(los(j,:),p{i}{f}(:,1:2),1e-7);% 1e-7 is tolerance PLAY WITH THIS IF PROBLEM
        gridd{i,1}{j,2}=length(gridd{i,1}{j,1}); %catalogue number of intersections per los
    end
    gridd{i,2}=cell2mat(gridd{i,1}(:,2));
    gridd{i,3}=find(gridd{i,2}>2);%search and identifie los where > 2 intersections occur, meaning that there is shadowing
    gridd{i,4}=find(gridd{i,2}==0);%search and identifie los where 0 intersection occur, meaning that the pass polygon lies outside the rotation axis
    gridd{i,5}=cell2mat(gridd{i,1}(:,1));%cell2mat from gridd{i,1} in order to plot scatter
    gridd{i,5}=[gridd{i,5},ones(length(gridd{i,5}),1)*z(i)];% add the Z to each pass
    scatter3(gridd{i,5}(:,1),gridd{i,5}(:,2), gridd{i,5}(:,3),'.')%Check the gridd visually
    hold on
    if  isempty(gridd{i,3})==0 % if there are los with more than 2 intersection points with the pass geom ,,,show shadowing los
        scatter3(gridd{i,5}(:,1),gridd{i,5}(:,2), gridd{i,5}(:,3),'r')
        for j=1:length(gridd{i,3})
            x=[-d(1)*(los(gridd{i,3}(j),3));d(1)*(los(gridd{i,3}(j),3))];
            y=[-d(2)*(los(gridd{i,3}(j),4));d(2)*(los(gridd{i,3}(j),4))];
            z=[z(i);z(i)];
            plot3(x,y,z,'linewidth',1);
            hold on
        end
    end
end

% construct rotation axis and plot along with the ordered mesh
rotx=[0;0];
roty=[0;0];
rotz=[0-d(3);0+d(3)];
plot3(rotx,roty,rotz,'linewidth',4,'color','black');
title(['Mesh of ',n]);
hold off

% Check if the examined geometry causes shadwing or non-continuities during
% spray and abort in both cases
if sum(cell2mat(cellfun(@isempty,gridd(:,3),'uni',false)))~= length(z)
    disp(length(z)-sum(cell2mat(cellfun(@isempty,gridd(:,3),'uni',false))));
    disp(' pases cannot be sprayed due to shadowing. Simulation is aborted.');
    return
elseif sum(cell2mat(cellfun(@isempty,gridd(:,4),'uni',false)))~= length(z)
    
    disp(length(z)-sum(cell2mat(cellfun(@isempty,gridd(:,3),'uni',false))));
    disp(' passes result in discontinuous spraying during rotation. Simulation is aborted.');
    return
end


% Sort the intersection points so that they are adjuscent to one another AND find distance of every point to the origin (= rotation axis).
 c=cellfun(@(x) x(1:2:end,:),gridd(:,5),'uni',false); % c= all the Odd-Indexed Elements
 v=cellfun(@(x) x(2:2:end,:),gridd(:,5),'uni',false); % v=all the Even-Indexed Elements
 dist=cell(length(p),1);
 m=cell(length(p),1);
 for i=1:length(p)
     m{i,1}=[c{i};v{i}]; %concatenate c and v . THESE ARE THE POINTS TO USE FOR KINEMATIC CALCULATIONS
     gridd{i,6}=(gridd{i,5}(:,1:2)).^2; % square all the (x,y) coordinates
     dist{i,1}=sqrt(gridd{i,6}(:,1)+gridd{i,6}(:,2));    %Pythagoras (mm)   -> find distance of every point to the origin
 end
end

