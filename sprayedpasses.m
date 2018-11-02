%% Calculate sprayed passes coordinates as 3D polygons, Z axis coordinates of the sprayed passes (zsteplist) and step of the consecutive spray passes
%
% The geometry is "sliced" in a number of horrizontal slices, with each
% slice representing the trajectory of a spray pass during the hypothetical
% rotation of the geometry. The "slices" are represented as 3D polygons and
% their number depences on the spray footprint dimensions and spray overlap
% factor, both of which are user defined parameters.
%
%
%
% p=cell array of size (M x 1, where M is the number of calculated sprayed passes) containing the coordinates of each sprayed pass as a 3D polygon (C x 3, C->number of nodes on each sprayed pass/polygon)
% z= array of size (M x 1) which stores the Z coordinate for each of the calculater sprayed passes
% fo= spray footprint (scalar)
% o= overlap factor (scalar)
% v= array of vertices (N x 3, N->number of vertices)
% fa= array of faces 
%
%

function [p,z]= sprayedpasses (fo,o,v,fa)

step = fo-(fo*(o/100));% calculate step of passes (mm)
z = ((min(v(:,3))+step):step:max(v(:,3)))'; %list of the z coorditates of each pass
p = cell(length(z),1);
for i = 1:length(z)
    z0 = z(i);
    plane = createPlane([0,0,z0], [0,0,1]);
    
    p{i} = intersectPlaneMesh(plane,v, fa);
end

end