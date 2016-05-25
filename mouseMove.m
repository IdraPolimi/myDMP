% function [x,y] = mouseMove (object, eventdata)
% global x;
% global y;
% C = get (gca, 'CurrentPoint');
% 
% x = [x, C(1,1)];
% y = [y, C(1,2)];
% plot(C(1,1),C(1,2),'X');
% title(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);
% 



function mouseMove (object, eventdata)
%F=figure;
%setptr(F,'eraser'); %a custom cursor just for fun

set(gcf,'buttondownfcn',@start_pencil)

function start_pencil(src,eventdata)
coords=get(src,'currentpoint'); %since this is the axes callback, src=gca
x=coords(1,1,1);
y=coords(1,2,1);

r=line(x, y, 'color', [0 .5 1], 'LineWidth', 2, 'hittest', 'off'); %turning     hittset off allows you to draw new lines that start on top of an existing line.
set(gcf,'windowbuttonmotionfcn',{@continue_pencil,r})
set(gcf,'windowbuttonupfcn',@done_pencil)

function continue_pencil(src,eventdata,r)
global newx;
global newy;
%Note: src is now the figure handle, not the axes, so we need to use gca.
coords=get(gca,'currentpoint'); %this updates every time i move the mouse
x=coords(1,1,1);
y=coords(1,2,1);
%get the line's existing coordinates and append the new ones.
lastx=get(r,'xdata');  
lasty=get(r,'ydata');
newx=[lastx x];
newy=[lasty y];
set(r,'xdata',newx,'ydata',newy);

function done_pencil(src,evendata)
%all this funciton does is turn the motion function off 
set(gcf,'windowbuttonmotionfcn','')
set(gcf,'windowbuttonupfcn','')