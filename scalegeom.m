%% scale the STL geometry

%**USE WHEN GEOMETRY IS RECENTERED AROUND THE CENTER OF MASS

% vv-> output vertices matrix (N x 3, N->number of vertices)
% v-> input vertices matrix (N x 3, N->number of vertices)
% sf-> scale factors  x, y, z dimenstions (x,y,z)



function vv = scalegeom (v,sf)

vv(:,1)=v(:,1)*sf(1);
vv(:,2)=v(:,2)*sf(2);
vv(:,3)=v(:,3)*sf(3);
end
