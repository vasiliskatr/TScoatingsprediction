%Plot STL geometry with rotation axis
%
%**USE ONLY WHEN GEOMETRY IS RECENTERED AROUND THE CENTER OF MASS
%
% v->vertices matrix ,centered around the cetenr of mass of the geometry (N x 3, N->number of vertices)
% f->faces matrix (M x 3)
% n->name string 
% d->dimensions array (1 x 3)
%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%


function plotgeax (v,f,n,d)

rotx=[0;0];% construct rotation axis
roty=[0;0];
rotz=[0-d(3);0+d(3)];


stlPlot(v,f,n,d);
hold on
plot3(rotx,roty,rotz,'linewidth',3,'color','black');
hold off
title(n);

end
