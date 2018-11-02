%% Check that the calculated kinematic values fall in the range of the experimantal data AND calculate the coating properties for each point 
%
%
% The effect of spray angle and spray distance are synergistic since both
% of them control the particle velocity vectors/particle temperature and
% partcle temperature history at impigement. On the other hand, gun traverse
% speed does not affect directly the particle impigement conditions and
% thus, its effect is stacked on top of the synergy of spray angle/spray
% distance. Considering the abobe relations, the experimental results are
% interpolated and normalized in a matrix "b" and the kinematic paramaters for each node
% are mapped in their respective index in this matrix (b). 
%
% For more infoemation see: https://link.springer.com/article/10.1007/s11666-018-0739-6
%
%
% pre-> OUTPUT/ Cell array (N x 1, N->number of sprayed passes) normalized predictions for each examined coating property for all the nodes, in all the sprayed passes. 
% coef-> OUTPUT/ vector(1-dimensional array) coeficients to be applied on the normalized predictions to yield actual predictions, essentially the maximum value of the
% experimental results for each examined coating property. 
% ki-> Kinematc paramaters results matrix 
% a-> Interpolated epxerimentla results matrix
% sp-> speed points vector (essentially all the values for gun traverse speed for which there are experimental results)
%
%
%%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%


function [pre,coef]=predict (ki,a,sp) 

% normalize interpolations from experimental results (./max)

b=cell(2,length(a(1,:))-2); %  create a cell array of size equal to the number of preducted catoing propetries (the first 2 cells of a contain the meshgrid output of SOD/spray angle so they are not considered)
%SoD vs impact angle interpolations normalized
b{1,1}=a{1,3}./max(max(a{1,3}));% normalized thickness vs angle sod interpolation
b{1,2}=a{1,4}./max(max(a{1,4}));% normalized microhardness vs angle sod interpolation
b{1,3}=a{1,5}./max(max(a{1,5}));% normalized porosity vs angle sod intepolation
b{1,4}=a{1,6}./max(max(a{1,6}));% normalized res.stress vs angle sod intepolation
b{1,5}=a{1,7}./max(max(a{1,7}));% normalized WC Vol%  vs angle sod intepolation
b{1,6}=a{1,8}./max(max(a{1,8}));% normalized Co mean free path vs angle sod intepolation
b{1,7}=a{1,9}./max(max(a{1,9}));% normalized O atomic% vs angle sod intepolation
b{1,8}=a{1,10}./max(max(a{1,10}));% normalized Wear coefficient vs angle sod intepolation

%trav.speed interpolations normalized
b{2,1}=a{2,3}./max(max(a{2,3}));% normalized thickness vs trav.speed interpolation
b{2,2}=a{2,4}./max(max(a{2,4}));% normalized microhardness vs trav.speed interpolation
b{2,3}=a{2,5}./max(max(a{2,5}));% normalized porosity vs trav.speed interpolation
b{2,4}=a{2,6}./max(max(a{2,6}));% normalized res.stress vs trav.speed interpolation
b{2,5}=a{2,7}./max(max(a{2,7}));% normalized WC Vol% vs trav.speed interpolation
b{2,6}=a{2,8}./max(max(a{2,8}));% normalized Co mean free path vs trav.speed interpolation
b{2,7}=a{2,9}./max(max(a{2,9}));% normalized O atomic% vs trav.speed interpolation
b{2,8}=a{2,10}./max(max(a{2,10}));% normalized Wear coefficien vs trav.speed interpolation

flag2=false;%create flag2 to break the loops in case of inadequate experimental data (i.e. when the kinemaptic spray paramaters exceed the prediction space which is based on the interpolation of experimental data)

coef=ones(length(a(1,:))-2,1); %preallocate array coef to store the maximum value of each examined coating property
for i=1:length(a(1,:))-2  % for each examined coating property
coef(i,1)=max(max(a{2,i+2}));
end

pre=cell(length(ki),1);

ki=cellfun(@round,ki,'uni',false);

for i =1:length(ki); %for every pass
    extremesod=[min(ki{i}(:,1)),max(ki{i}(:,1))]; % min and max of rounded SoD values for the ith pass
    extremeimpactangle=[min(ki{i}(:,2)),max(ki{i}(:,2))]; % min and max of rounded impact angle values for the ith pass
    extremetravspeed=[min(ki{i}(:,4)),max(ki{i}(:,4))]; % min and max of rounded trav speed values for the ith pass
    
    %check that the clculated SoD for the ith pass lies with in the limits of the interpolated experimental data
    if (extremesod(1)>=a{1,1}(1,1) && extremesod(2)<=a{1,1}(1,length(a{1,1}(1,:))))
        sodid=abs(a{1,1}(1,1)-ki{i}(:,1))+1; %find the column from gridddata{1,1} that corresponds to the calculated SoD
    else
        disp(['Inadequate SoD experimental Data in pass ',num2str(i)]) %if not stop the calculation
        flag2=true;
        break
    end
    
    %check that the clculated impact angle for the ith pass lies with in the limits of the interpolated experimental data
    if (extremeimpactangle(1)>=a{1,2}(1,1) && extremeimpactangle(2)<=a{1,2}(length(a{1,2}(:,1)),1))
        angid=abs(a{1,2}(1,1)-ki{i}(:,2))+1; %find the row from gridddata{1,2} that corresponds to the calculated angle
    else
        disp(['Inadequate impact angle experimental Data in pass ',num2str(i)]) %if not stop the calculation
        flag2=true;
        break
    end
    
    %check that the clculated trav.speed for the ith pass lies with in the limits of the interpolated experimental data
    if (extremetravspeed(1)>=sp(1,1) && extremetravspeed(2)<=sp(length(sp)))
       travid=abs(sp(1,1)-ki{i}(:,4))+1; % find the indice from speedpoints (vector) that corresponds to the calculated trav.speed
    else
        disp(['Inadequate gun trav.speed experimental Data in pass ',num2str(i)])
        flag2=true;
        break
    end
    
    %*Normalized*
    %COATING PROPERTIES PROJECTIONS FOR ALL POINTS OF ith PASS
   
    pre{i}(:,1)=b{1,1}(sub2ind(size(b{1,1}),angid,sodid)).*b{2,1}(travid); %projections for coating thickness of the points of ith pass
    pre{i}(:,2)=b{1,2}(sub2ind(size(b{1,2}),angid,sodid)).*b{2,2}(travid); %projections for coating microhardness of the points of ith pass
    pre{i}(:,3)=b{1,3}(sub2ind(size(b{1,3}),angid,sodid)).*b{2,3}(travid); %projections for coating porosity of the points of ith pass
    pre{i}(:,4)=b{1,4}(sub2ind(size(b{1,4}),angid,sodid)).*b{2,4}(travid); %projections for coating res.stress of the points of ith pass
    pre{i}(:,5)=b{1,5}(sub2ind(size(b{1,5}),angid,sodid)).*b{2,5}(travid); %projections for coating WC Vol% of the points of ith pass
    pre{i}(:,6)=b{1,6}(sub2ind(size(b{1,6}),angid,sodid)).*b{2,6}(travid); %projections for coating Co mean free path of the points of ith pass
    pre{i}(:,7)=b{1,7}(sub2ind(size(b{1,7}),angid,sodid)).*b{2,7}(travid); %projections for coating O atomic% of the points of ith pass
    pre{i}(:,8)=b{1,8}(sub2ind(size(b{1,8}),angid,sodid)).*b{2,8}(travid); %projections for coating Wear coefficien of the points of ith pass

end