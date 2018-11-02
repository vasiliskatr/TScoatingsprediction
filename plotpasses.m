%% plot and highlight the passes that will be sprayed
%
%
% p-> cell array of size (N x 1, where N is the number of calculated sprayed passes) containing the coordinates of each sprayed pass as a 3D polygon (M x 3)
% f-> scalar [0 or 1] that indicates internal or external spray
% n-> name of the STL file
%___________________
%Author: Vasileios Katranidis, University of Surrey, UK 2017
%



function plotpasses (p,f,n)
figure;
if f==2 
    title(['Internal spray of ',n])
elseif f==1
    title(['external spray spray of ',n])
end
view([-135 35]);
drawPolygon3d(p, 'lineWidth', 0.1, 'color', 'b')
hold on
drawPolygon3d(cellfun(@(x) x(:,f),p,'uni',false), 'lineWidth', 0.1, 'color', 'r')
hold off
end