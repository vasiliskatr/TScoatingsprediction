%% Roatate the STL geometry around any axis

%**USE ONLY WHEN GEOMETRY IS RECENTERED AROUND THE CENTER OF MASS

% x=point of rotation, normally the center o mass
% y= direction of rotation vector 
% r= rotation in rad
% v= matrix of vertices (N x 3, N->number of vertices)


function vert = rotobj(x,y,r,v)

line = [x, y];
v=v';%invert vert
v=[v;ones(1,numel(v(1,:)))];%add a row of ones below vertices matrix
rot = createRotation3dLineAngle(line, r);
v=rot*v; %apply transformation to vert
v(size(v,1),:)=[];%delete extra row of ones 
vert=v';%re-invert to create the vert matrix with the correct transformation
end