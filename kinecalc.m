%% Kinematic calculations for evry point. For external/internal spray
%
% The calculation of the sprayed kinematic parameters for each node, of
% each sprayed pass takes place. for more information check: https://link.springer.com/article/10.1007/s11666-018-0739-6
%
%
% kin-> OUTPUT/ cell array (N X 1, N-> number of sprayed passes) containg the calculated spray kinemati parameters for each node, for each sprayed pass
% me-> cell array, containing the coordinates (360 X 3) of all the nodes in each of the sprayed passes, for all the sprayed passes
% rndist-> cell array (N X 1, N-> number of sprayed passes), containing the distances between the rotation axis and each node, for each sprayed pass
% gadist-> scalar (float) indicating the distance between the spray gun and the rotation axis in mm
% f-> Flag1 (integer), indicating external or inetrnal spray simulation
% rpm-> scalar, rpm 
%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%

function kin=kinecalc(me,rndist,gadist,f,rpm)

%calculation of spray distance (SOD)
kin=cell(length(me),1);
if f==2 %if internal spray, SOD= distance of each node to the rotation axis - distance of spray gun from rotation axis
    
    kin= cellfun(@(x) x-gadist,rndist(:),'uni',false);
elseif f==1 %if external spray, SOD= distance of spray gun from rotation axis - distance of each node to the rotation axis
    
    kin= cellfun(@(x) gadist-x,rndist(:),'uni',false);
end

for i=1:length(me)-1% For every pass **EXEPT LAST PASS** (calculations for the last pass take place later because the i+1 sprayed pass are considerd for the calculations)
    me{i}= [me{i};me{i}(1,:)];%add an extra 1st point at the end of the point list for the sake of the calculations
    me{i+1}= [me{i+1};me{i+1}(1,:)]; % add an extra 1st point at the end of the point list for the sake of the calculations to the i+1 sprayed pass
    for j=1:length (me{i})-1% number of nodes for every sprayed pass (equall for all sprayed passes (=360 in this case))
        n = cross(me{i}(j+1,:)-me{i}(j,:), me{i+1}(j,:)-me{i}(j,:)); %normal vector to plane which is defined by the local sprayed surface ** z axis reference from point from the next pass (i+1)**
        m= me{i}(j+1,:)-me{i}(j,:);%vector of twoadjuscent points on the same spreyed pass
        k= [0,0,me{i}(j,3)]-me{i}(j,:); % vector of spray plume
        azimang= atan2(norm(cross(m,k)), dot(m,k));% azimuth angle calculation (needed for the calculation of gun trav. speed) ** Should always be 0<az<pi
            if azimang<0 || azimang> pi
                disp (['i', num2str(i),'j',num2str(j)]);
            end
        impactang= pi/2-(atan2(norm(cross(n,k)), dot(n,k))); %pi/2 - angle between the two vectors n,k.
       
        kin{i}(j,2)=rad2deg(impactang); % *IMPACT ANGLE conversion to degrees===
        kin{i}(j,3)=rad2deg(azimang); % Azimuth angle (used in the calculation of trav.speed)
        kin{i}(j,4)=(sin(azimang)*rndist{i}(j))*((rpm*2*pi)/60)*(sec(pi/2-azimang))^2; % tr.speed (mm/sec)**CHECK if
    end
    me{i}(end,:) = []; %delete the extra 1st point that was added earlier (for the sake of plotting later)
    me{i+1}(end,:) = [];
end

% kinematic calculations for the last pass (change the method of calculating the normal vector to impigemend plane for each point -consider i-1 sprayed pass in stead of i+1-. This yields negative results for trav speed, thus the sign correction below)
me{end}= [me{end};me{end}(1,:)];%add an extra 1st point at the end of the point list for the shake of the calculations
me{end-1}= [me{end-1};me{end-1}(1,:)];
for j=1:length (me{end})-1% number of nodes for every sprayed pass (equall for all sprayed passes)
    n = cross(me{end}(j+1,:)-me{end}(j,:), me{end-1}(j,:)-me{end}(j,:)); %normal vector to impigement plane ** z axis reference from point from the previoues pass**
    m= me{end}(j,:)-me{end}(j+1,:);%vector of twoadjuscent points on the same pass
    k= [0,0,me{end}(j,3)]-me{end}(j,:); % vector of spray plume
    azimang= atan2(norm(cross(m,k)), dot(m,k));% azimuth angle calc. ** Should always be 0<az<pi
   
    impactang= pi/2-(atan2(norm(cross(n,k)), dot(n,k))); %pi/2 - angle between the two vectors n,k.
   
    kin{end}(j,2)=abs(rad2deg(impactang)); % *IMPACT ANGLE)conversion to degrees
    kin{end}(j,3)=rad2deg(azimang); % Azimuth angle (used in the calculation of trav.speed)
    kin{end}(j,4)=-((sin(impactang)*rndist{end}(j))*((rpm*2*pi)/60)*(sec(pi/2-impactang))^2); % tr.speed (mm/sec)**Corrected sign**
end
me{end}(end,:) = []; %delete the extra 1st point that was added earlier (for the shake of plotting later)
me{end-1}(end,:) = [];

end