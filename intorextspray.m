%% check if part is hollow, if yes, give option for external of internal spray
%
%Part is analysed and closed cavities or hollow structure (which enables
%internal spray) are detected. User input is considered in the case both external and internal spraying are possible. 
% 
% f-> OUTPUT/ Integer flag indicating external or internal spray. ** f
% CANNOT BE BOOLEAN TYPEBECUSE IT IS USED AS AN INTEGER IN THE SUBSEQUENT
% CALCULATIONS**
% p-> cell array of size (N x 1, where N is the number of calculated sprayed passes) containing the coordinates of each sprayed pass as a 3D polygon (M x 3)
%
%%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%
%
function f=intorextspray (p)

a=cell2mat(cellfun(@size,p,'uni',false));% store the nuber of polygons per pass. 'a' is a temporary array
if sum(a(:,2))==2*length(a(:,1))
    prompt = 'Part is hollow. Internal or external spray? int/ext: ';
    str = input(prompt);
    if str == 'int'
      f=2;
      c='Internal spray mode selected';
      
    elseif str == 'ext'
      f=1;
      c='External spray mode selected';
    else
       f=1; 
       c='invalid argyument, external spray selected by default'; 
           
    end
  
elseif sum(a(:,2))==length(a(:,1))
    c='Part is solid. External spray only';
    f=1;
else
    c='Part contains closed cavities. External spray only';
    f=1;
end
disp(c);
end