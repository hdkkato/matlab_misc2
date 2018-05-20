%%
clear all; close all; clc;
imaqreset;

% Set up camera
hCamera = videoinput('winvideo', 1, 'YUY2_320x240');
set(hCamera,'returnedcolorspace','RGB');
hidtypeconv = vision.ImageDataTypeConverter('OutputDataType', 'single');
% Creat Viewer
viewer1 = vision.DeployableVideoPlayer('Size', 'Custom', 'CustomSize', [320 240]);
viewer2 = vision.DeployableVideoPlayer('Size', 'Custom', 'CustomSize', [320 240], 'Location', [300 300]);

hCamera.FramesPerTrigger =  1;

%% Initialization
triggerconfig(hCamera, 'manual');

%% Start Camera
start(hCamera);

%%
% �Q�����K�E�V�A���t�B���^�J�[�l���̍쐬
gaussSigma = 10;
gaussWidth = max( 1, 5*ceil( gaussSigma ) );
gauss_2d = fspecial('gaussian', gaussWidth, gaussSigma);
[U,S,V] = svd(gauss_2d);
U1 =  U(:,1)*sqrt(S(1));

figure('userdata',1);
h = image(zeros(240,320,3,'single'));

uicontrol('style','pushbutton','units','n','position',[0 0 0.5 0.03],'String','Use CPU', 'callback','set(gcbf,''userdata'', 1)')
uicontrol('style','pushbutton','units','n','position',[0.5 0 0.5 0.03],'String','Use GPU', 'callback','set(gcbf,''userdata'', 0)')
hs = uicontrol('style','slider','units','n','position',[0 0.03 1 0.03]);

numLoop = 200;
h_title = title('');
while ishandle(h_title)
    try
    cpugpu_switch = get(gcf,'userdata');
    if cpugpu_switch == 0;
        usingcpu = 0;
    else
        usingcpu = 1;
    end
    
    tic;

    % Get data
    I = getsnapshot(hCamera);
    
    % CPU ���@GPU �ŁA�f�[�^�^��I������
    if usingcpu
        I = single(I);
    else
        I = gpuArray(single(I));
    end
    
    % GPU Memory �G���A�ւ̃f�[�^�̃��[�h
    
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    %     % Display Image
    %    image(I);
    
    % �K�E�V�A���t�B���^�����摜�ɑ΂��ēK�p���ĕ������摜���쐬
    R_smooth = conv2(R, gauss_2d, 'same' );
    G_smooth = conv2(G, gauss_2d, 'same' );
    B_smooth = conv2(B, gauss_2d, 'same' );
    
    % ���摜����t�B���^���ʂ������Z���A�����g�����𒊏o
    R_edge = R - R_smooth;
    G_edge = G - G_smooth;
    B_edge = B - B_smooth;
    
    threshold = 0.05*255;
    R_edge = R_edge .* ( abs( R_edge ) < threshold );
    G_edge = G_edge .* ( abs( G_edge ) < threshold );
    B_edge = B_edge .* ( abs( B_edge ) < threshold );
    
    % �A���V���[�v�E�I�y���[�^�̍쐬
    scl = 3*get(hs,'Value'); % �X���C�_�[�E�o�[�̒l���擾
    R_sharpened = R + scl*R_edge;
    G_sharpened = G + scl*G_edge;
    B_sharpened = B + scl*B_edge;
    
    % Prevent over/under-flow
    R_sharpened = min(R_sharpened, 255);
    R_sharpened = max(R_sharpened, 0);
    G_sharpened = min(G_sharpened, 255);
    G_sharpened = max(G_sharpened, 0);
    B_sharpened = min(B_sharpened, 255);
    B_sharpened = max(B_sharpened, 0);
    
    % sharpened_image = gather(cat(3, R_sharpened, G_sharpened, B_sharpened));
    sharpened_image = cat(3, R_sharpened, G_sharpened, B_sharpened);
    
    % Display image
    % step(viewer2,sharpened_image);
    if usingcpu
        set(h,'CData',sharpened_image/255); drawnow;
    else
        set(h,'CData',gather(sharpened_image/255)); drawnow;
    end
    set(h_title, 'string', sprintf('FPS = %0.2f',1/toc));
    end
end
stop(hCamera)