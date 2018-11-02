%Center of mass calculation 
% 
%
% c-> OUTPUT/Center of mass [x,y,z]
% v-> OUTPUT/ Volume of the analysed geometry
% v-> vertices array (N x 3, N->number of vertices)
% f-> facses array 
%
%
%
%For more info:
%https://stackoverflow.com/questions/2083771/a-method-to-calculate-the-centre-of-mass-from-a-stl-stereo-lithography-file
%http://mathworld.wolfram.com/Tetrahedron.html

function [c,v]= centerofmass(v,f)
totvol=0;
curvol=0;
xcent=0;
ycent=0;
zcent=0;
for i=1:length(f)
    curvol=(v(f(i,1),1)*v(f(i,2),2)*v(f(i,3),3)- v(f(i,1),1)*v(f(i,3),2)*v(f(i,2),3)-v(f(i,2),1)*v(f(i,1),2)*v(f(i,3),3)+v(f(i,2),1)*v(f(i,3),2)*v(f(i,1),3)+v(f(i,3),1)*v(f(i,1),2)*v(f(i,2),3)-v(f(i,3),1)*v(f(i,2),2)*v(f(i,1),3))/6;
    totvol=totvol+curvol;

    xcent= xcent+((v(f(i,1),1)+v(f(i,2),1)+v(f(i,3),1))/4)*curvol;
    ycent= ycent+((v(f(i,1),2)+v(f(i,2),2)+v(f(i,3),2))/4)*curvol;
    zcent= zcent+((v(f(i,1),3)+v(f(i,2),3)+v(f(i,3),3))/4)*curvol;
end
xcent= xcent/totvol;
ycent= ycent/totvol;
zcent= zcent/totvol;
c=[xcent,ycent,zcent];
v= totvol;
end