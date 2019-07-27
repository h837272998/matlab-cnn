
function varargout = untitled(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function untitled_OpeningFcn(hObject, eventdata, handles, varargin)

global cnn;
handles.output = hObject;
guidata(hObject, handles);
handles.identification_bt.Enable = 'Off';
handles.calculation_bt.Enable = 'Off';
try
    load('thecnn');
    cnn = cnn;
catch
    warndlg({'û�з���ѵ��ϵͳ�����ȳ�ʼ��ѵ����'});
    handles.Menu_3_3.Enable = 'Off';
end
try
    load('myPT');
catch
    handles.menu_3_2.Enable = 'Off';
end
set(gcf,'CloseRequestFcn',@Closethis);
% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_1_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function menu_2_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function mune_3_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function menu_3_1_Callback(hObject, eventdata, handles)
global pretrain
pretrain     = figure('Name','����ѵ��ͼ��','Menu','none',...
                'NumberTitle','off','Position',[300 300 360 305]);
movegui(pretrain,'center');
jframe = getJFrame(pretrain);
jframe.setAlwaysOnTop(0);
imgSeg_bt = uicontrol('Parent',pretrain,'Style','pushbutton','position',[25 260 115 35],...
                'String','����ͼ��','FontSize',12,'Callback',{@imgSeg_bt_Callback});
imgconfirm_bt = uicontrol('Parent',pretrain,'Style','pushbutton','position',[200 260 115 35],...
                'String','ȷ��','FontSize',12,'Callback',{@imgconfirm_bt_Callback},'Visible','On');
%==================================================
 function imgSeg_bt_Callback(obj,event)
global  pretrain number clname1 ndata
[filelist,path] = uigetfile({'*.PNG;*.jpg;*.tif',...
                      'Image Files (*.PNG,*.jpg,*.tif)'},'��ѡ������ͼ�� ...');
    if (filelist == 0)
        return;
    end
    if  isempty(number)
        number = 1;
        clname1 = cell(number,2);
        clname1{1,1} = '     ���';
        clname1{1,2} = '     �����ַ�';
    end
    teima = imread([path,filelist]);
    imwrite(teima,['train/',num2str(number-1),'.jpg']);
    answer = inputdlg('�����ַ�','Input',1);
    ndata{number,1} = number - 1;
    ndata{number,2} = [answer{1,1}];
    uitable('Data',ndata,'ColumnName',clname1,'RowName','',...
        'Parent',pretrain,'position',[45 15 220 220]);
        number = number +1 ;
        %=========================
     function imgconfirm_bt_Callback(obj,event)
         global  number ndata
         try
            mycnnPrestrain(number,ndata);
            warndlg({'���ɳɹ�'});
        catch
             warndlg({'��������'});
        end
% --------------------------------------------------------------------
function menu_3_2_Callback(hObject, eventdata, handles)
    global hwait
try
    load('thecnn');
    choice = questdlg('������ϵͳ�Ƿ����', ...
	'��ʾ', ...
	'ȷ��','ȡ��','');
switch choice
    case 'ȷ��'
        clear cnn;
        load('myPT');
       train_x = train_x;%/255;
        train_y = double(train_y');  %ѵ��������ʵ��
        cnn.layers = {  
            struct('type', 'i') %����� input layer
            struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %�����s1 convn layer
            struct('type', 's', 'scale', 2) %�ػ��� c2 sampling layer  
            struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %�����s3 convn layer  
            struct('type', 's', 'scale', 2) %�ػ���c4 subsampling layer  
        };  
        opts.alpha  = 1;  
        opts.batchsize =1;   % ѵ����������ͬ������������
        opts.numepochs=100;  
        cnn = mycnnsetup(cnn, train_x, train_y,data);  %��ʼ��cnn�ṹ
        [cnn time] = mycnntrain(cnn, train_x, train_y, opts);   %ѵ��
        save thecnn cnn;
        close(hwait); 
        choice = questdlg(['ѵ����ɣ����ѣ�',num2str(time/60),'����'], ...
        '���', ...
        'ȷ��','');
    case 'ȡ��'
        
end
catch
    warndlg({'��������,����δ���ڴ�ѵ����myPT'});
end


% --------------------------------------------------------------------
function menu_2_1_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function menu_2_2_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function menu_1_1_Callback(hObject, eventdata, handles)
    global ima;
    [filelist,path] = uigetfile({'*.PNG;*.jpg;*.tif',...
                      'Image Files (*.PNG,*.jpg,*.tif)'},'��ѡ������ͼ�� ...');
    if (filelist == 0)
        return;
    end
    ima = imread([path,filelist]);
     cla reset;
    handles.identification_axes.Visible = 'Off';
    handles.crop_axes.Visible = 'On';
    handles.crop_cancel_bt.Visible = 'On';
    handles.crop_confirm_bt.Visible = 'On';
    handles.crop_cancel_bt.Enable = 'Off';
    handles.crop_confirm_bt.Enable = 'On';
    handles.identification_bt.Visible = 'Off';
    handles.calculation_bt.Visible = 'Off';
    handles.edit.Visible = 'Off';
     handles.result_text.Visible = 'Off';
    handles.tir_text.String = '�����������,˫���������ͼ';
    axes(handles.crop_axes);
    imshow(ima);
    try
        [x,y] = ginput(2);
        rect=[x(1),y(1),x(2)-x(1),y(2)-y(1)];
        J=imcrop(ima,rect);
        imwrite(J,'temp/t.jpg');
        axes(handles.crop_axes); 
        imshow('temp/t.jpg');
        handles.crop_cancel_bt.Enable = 'On';
    catch
    end
    
% --- Executes on button press in crop_cancel_bt.
function crop_cancel_bt_Callback(hObject, eventdata, handles)
    global ima;
    axes(handles.crop_axes);
    imshow(ima);
    handles.crop_cancel_bt.Enable = 'Off';
    try
    [x,y] = ginput(2);
    rect=[x(1),y(1),x(2)-x(1),y(2)-y(1)];
    J=imcrop(ima,rect);
    imwrite(J,'temp/t.jpg');
    axes(handles.crop_axes); 
    imshow('temp/t.jpg');
    handles.crop_cancel_bt.Enable = 'On';
    catch
        return;
    end
    

function crop_confirm_bt_Callback(hObject, eventdata, handles)
    global ima;
    tima = imread('temp/t.jpg');
    ima = tima;
    handles.identification_axes.Visible = 'On';
    axes(handles.crop_axes); 
    cla reset;
    handles.crop_axes.Visible = 'Off';
    handles.crop_cancel_bt.Visible = 'Off';
    handles.crop_confirm_bt.Visible = 'Off';
    axes(handles.identification_axes);
    imshow(ima);
    title('����ͼ��');
    handles.tir_text.String = '';
    handles.identification_bt.Visible = 'On';
    handles.identification_bt.Enable = 'On';
    handles.calculation_bt.Visible = 'On';
    handles.edit.Visible = 'On';
     handles.result_text.Visible = 'On';


function edit_Callback(hObject, eventdata, handles)



function edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function identification_bt_Callback(hObject, eventdata, handles)
global ima cnn str
ima  = imread('temp/t.jpg');
ima = myPreproccess(ima);
%������
section = zeros(3,1);

ima = myerode(ima,'square',2);
ima = mydilate(ima,'square',3);
figure();imshow(ima);
[section len]= myrecursionNumber1(ima,cnn,0,zeros(2,1),section);
section = section';
len
for i= 1:size(section,2)-1
    if section(i,2)==0
        continue;
    end
    if abs(section(i,2))<size(cnn.data,2)&&strcmp(cnn.data{1,section(i,2)} ,'s')
        if i<size(section,1)&&strcmp(cnn.data{1,section(i,2)} ,'i')
        else
            section(i,2) = find(strcmp(cnn.data,'5'));
        end
    end
end
str = '';
fx = zeros(size(section,1));
for i= 1:size(section,1)
    if section(i,:)==0
        continue;
    end
    if abs(section(i,1))<size(cnn.data,2)&&section(i,1)~=0
        str = [str,'^',cnn.data{1,section(i,1)}];
        continue;
    end
    if section(i,1)~=0&&section(i,1)/111==section(i,2)/111&&section(i,3)/111==section(i,2)/111&&...
       section(i,1)/111 ==  fix(section(i,1)/111)
            mu = section(i,1)/111;
            if section(i,1)>0&&fx(mu) == 0
                 str = [str,'('];
                 fx(mu)= 1;
            else if section(i,1)>0&&fx(mu)== 1
                  str = [str,')'];
                  fx(mu) = 0;
                else if section(i,1)<0
                        str = [str,')/('];
                    end
                end
            end
    else
        str = [str,cnn.data{1,section(i,2)}];
    end
end
handles.edit.String  = str;
handles.calculation_bt.Enable = 'On';
function calculation_bt_Callback(hObject, eventdata, handles)
str = get(handles.edit,'String');
 handles.result_text.String = num2str(str2num(str));
if strcmp(num2str(str2num(str)),'')
     handles.result_text.String = '���ʽ����';
end

    %handles.result_text.String = '��ʽ����';
% --------------------------------------------------------------------
    function menu_3_3_Callback(hObject, eventdata, handles)
global cnn;

c_num = length(cnn.data);
numoftrn = cell(c_num,3);
rname    = cell(c_num,1);
numoftrn{1,1} = '            -';
numoftrn{1,2} = '            -';
numoftrn{1,3} = '            -';

for i = 1:c_num
        numoftrn{i,1} = [num2str(i)];
        numoftrn{i,2} = [cnn.data{1,i}];
        numoftrn{i,3} = ['30'];%gai
end

clname = {'cnn���','ʵ���ַ�','������'};
f      = figure('Name','ϵͳ����״̬','Menu','none',...
                'NumberTitle','off','Position',[300 300 360 305]);
movegui(f,'center');
jframe = getJFrame(f);
jframe.setAlwaysOnTop(1);
uitable('Data',numoftrn,'ColumnName',clname,'RowName','',...
        'Parent',f,'position',[45 15 280 280]);
    
    
function JFrame = getJFrame(hfig)
error(nargchk(1,1,nargin));
if ~ishandle(hfig) && ~isequal(get(hfig,'Type'),'figure')
    error('The input argument must be a Figure handle.');
end

mde        = com.mathworks.mde.desk.MLDesktop.getInstance;
if isequal(get(hfig,'NumberTitle'),'off') && isempty(get(hfig,'Name'))
    figTag = 'junziyang';
    set(hfig,'Name',figTag);
elseif isequal(get(hfig,'NumberTitle'),'on') && isempty(get(hfig,'Name'))
    figTag = ['Figure ',num2str(hfig)];
elseif isequal(get(hfig,'NumberTitle'),'off') && ~isempty(get(hfig,'Name'))
    figTag = get(hfig,'Name');
else
    figTag = ['Figure ',num2str(hfig),': ',get(hfig,'Name')];
end
drawnow;
jfig       = mde.getClient(figTag);
JFrame     = jfig.getRootPane.getParent();

function Closethis(src,evnt)
clc;
        delete(gcf);
        close all;
        clear all;