x=0;y=0;
plot1=plot(x,y);axis([-3,3,-1,3]);axis square;


ui=uicontrol('style','slider','min',-3,'max',3,'value',0);
set(ui,'callback','x=get(ui,''value'');y=0;plot(x,y);axis([-3,3,-1,3]);axis square');
