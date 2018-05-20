function MakeSlider(String,varargin)
switch(lower(String));
case 'make';
InitSlider(varargin{1});
case 'imageslice';
MoveSlice;
otherwise;
error('ŠÖ”MakeSlider‚Ìó‚¯•t‚¯‚é“®ì‚Í''Make''‚Ì‚İ‚Å‚·')
end;
function InitSlider(Handle)
H=guidata(Handle);
H.slider=uicontrol(H.figure,'Style','Slider');
H.image=image(zeros(128,128));
H.axes=gca;
set(gca,'PlotBoxAspectRatio',[1,1,1]);
FigureSize=get(H.figure,'Position');
set(H.slider,'Position',[FigureSize(3)-30,10,25,FigureSize(4)-20]);
set(H.slider,'Min',1,'Max',40,'Value',1,'SliderStep',[1,5]/39);
set(H.slider,'CallBack','MakeSlider(''ImageSlice'');');
guidata(H.figure,H);
return;
function MoveSlice
H=guidata(gcbo);
SliceNum=round(get(H.slider,'Value'));
set(H.image,'Cdata',H.tempA(:,:,SliceNum));
return;
