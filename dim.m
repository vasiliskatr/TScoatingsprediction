% Return the dimensions of the input geometry assuming that values in the
% vertices array are in mm.
%
% v-> vertices array (N x 3, N->number of vertices)
%
%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%
function d=dim(v)

d(1)=abs(max(v(:,1))-min(v(:,1)));
d(2)=abs(max(v(:,2))-min(v(:,2)));
d(3)=abs(max(v(:,3))-min(v(:,3)));

disp(['dimentions of geometry in mm (x,y,z): ',num2str(d)])
end