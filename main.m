%% Prediction of Coating Properties of Thermally Sprayed WC?Co on Complex Geometries
 % Code for the publication: https://link.springer.com/article/10.1007/s11666-018-0739-6
 
 
[vert,fac] = stlRead('modelt.stl'); %USER INPUT Read STL file

name=('rotor section'); % USER INPUT name the geometry
footpr=5; % USER INPUT spray foutprint diameter in mm%
overl=10; %USER INPUT spray overlap factor in %
rpm=40; %USER IPUT specify rpm
centro= centerofmass(vert,fac);% find center of mass and volume of the imported geometry
dime=dim(vert); %dimesions of the STL file (assuming mm)


%% delete duplicate vertices

[vert,fac] = stlSlimVerts(vert,fac);

%% Make center of mass the new origin

vert=[vert(:,1)-centro(1),vert(:,2)-centro(2),vert(:,3)-centro(3)];

%% Check the orientation and dimensions of the imported STL geometry

plotgeax (vert,fac,name,dime);

%% Rotate the STL araound any axis (OPTIONAL/GEOMETRY PRE-PROCESSING)
% no rotation needed in this case ("modelt.stl")
rotaxis=[0,1,0]; % USER IPUT, define rotation axis vector, 
rotrad=0; % USER INPUT, define rotation in radians
vert=rotobj(centro,rotaxis,rotrad,vert);

%check the changes 
dime=dim(vert);
plotgeax (vert,fac,name,dime);

%% Scale the STL (OPTIONAL/GEOMETRY PRE-PROCESSING)
% Uniform scaling of a factor of 6 is needed in this case ("modelt.stl")
scalef=[6,6,6];% USER IPUT, give scale factrs fro x,y,z dimensions
vert=scalegeom(vert,scalef);

%check the changes 
dime=dim(vert);
plotgeax (vert,fac,name,dime);

%% Calculate passes coordinates, zsteplist, step

[polySet,zsteplist]= sprayedpasses (footpr,overl,vert,fac);
 
%% USER INPUT/ Which sprayed pass will be presented in the coming graphs?

prompt = [num2str(length(zsteplist)),' spreyed passes have been defined according to the spray footprint, overlap factor and dimenstions of the geomtery ','\n''Which sprayed pass should be visualised in terms of spray kinematic parameters profile and predicted coating properties ?'];
spraypassexamined = input(prompt);
if isempty(spraypassexamined)
    disp ('No Input, the 5th sprayed pass will be presented by default.')
    spraypassexamined = 5;
elseif spraypassexamined <1 || spraypassexamined > length(polySet)
     disp ('Input value exceeds the valid range, the 5^t^h sprayed pass will be presented by default.')
    spraypassexamined = 5; 
end
 
 %% Check if part is hollow, if yes, give option for external of internal spray
 
flag1= intorextspray (polySet);

%% Plot and highlight the passes that will be sprayed

plotpasses(polySet, flag1,name)

%% Convert sprayed passes into an ordered mesh of exactly 360 nodes at every sprayed pass/polygon and plot it

[mesh,rotnodedist]=ordmesh(polySet,zsteplist,flag1,dime,name);

%% Kinematic calculations for evry point. For external/internal spray

gunaxisdist = 320; % USER INPUT, distance between spray gun and rotatio axis (mm) ** Too long or toomshort distances might result in invalid kinematic calculations with repsect to the prediction space given by the experimental input resutls.

kinspraypar=kinecalc (mesh,rotnodedist,gunaxisdist,flag1,rpm);

%% Plot the Spray Kinematic parameters of specified sprayed passes

%TODO put spray pass number in fig tittle  AND correct y-axis

plotkinpar(kinspraypar,name,spraypassexamined);

%% Input, Interpolation, Visualization and normalization of the experimetal results based on HVOF SPRAY of WC-Co coatings

[exres,sprange,totpass]=experesu; %experimental results are inseted manually in the expresu function

%% Normalized predictions for each examined coating property, for every node of every sprayed pass

[npredictions,excoef]=predict(kinspraypar,exres,sprange);

%% Plot the predictions for all examined coating properties, for the selected sprayed pass

predgraph(npredictions,excoef,spraypassexamined);

%% Project predictions of all the sprayed passes on the analysed geometry

predfigs (mesh,npredictions,excoef);


