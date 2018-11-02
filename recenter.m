%% Recenter geometry coordinates around the ceneter of mass
%
% a-> OUTPUT/ cell array of size (M x 1, where M is the number of
% calculated sprayed passes) containing the coordinates of each sprayed
% pass as a 3D polygon, recentered with respect to the center of mass
% p-> cell array of size (M x 1, where M is the number of calculated sprayed passes) containing the coordinates of each sprayed pass as a 3D polygon (C x 3, C->number of nodes on each sprayed pass/polygon)
% c-> center of mass (x,y,z)
% f-> flag1 (integer), indicatiing external or internal spray


function a=recenter(p, c,f)
 for i = 1:length(p)
p{i}{f}(:,1) = p{i}{f}(:,1)-c(1);
p{i}{f}(:,2) = p{i}{f}(:,2)-c(2);
 end
a=p;
end