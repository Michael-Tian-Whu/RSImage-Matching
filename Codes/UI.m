function varargout = UI(varargin)
% UI MATLAB code for UI.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%

% Edit the above text to modify the response to help UI

% Last Modified by GUIDE v2.5 07-Dec-2020 00:46:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before UI is made visible.
function UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% See also: GUIDE, GUIDATA, GUIHANDLES
set(handles.pushbutton2,'enable','off');
set(handles.pushbutton3,'enable','off');
global rand option;
rand=1;
option=1;
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI (see VARARGIN)

% Choose default command line output for UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

set(handles.pushbutton1,'BackGroundColor',[.49 .18 0.56]);

%���ļ�
fatherfile_path = uigetdir('','��ѡ��ң��Ӱ�����ļ���');%���ļ���·��
str_path = genpath(fatherfile_path);%���fatherfile���������ļ���·������Щ·�������ַ���p�У���';'�ָ�
length_p = size(str_path,2);%�ַ���str_path�ĳ���
file_path = {};%����һ����Ԫ���飬�����ÿ����Ԫ(��)�а���һ��Ŀ¼
temp_path = [];
for i = 1:length_p %Ѱ�ҷָ��';'��һ���ҵ�����·��tempд��path������
    if str_path(i) ~= ';'
        temp_path = [temp_path str_path(i)];
    else 
        temp_path = [temp_path '\']; %��·���������� '\'
        file_path = [file_path ; temp_path];
        temp_path = [];
    end
end
file_path=file_path(2:end,:);%�������ļ���Ŀ¼
%���˻��data�ļ��м����������ļ��У������ļ��е����ļ��У���·������������path�С�
%��������һ�ļ����ж�ȡͼ��

global all_img ;%��������ͼƬ��ÿһ�д���һ��ͼ���ļ��е�����ͼƬ
global file_num img_num
file_num = size(file_path,1);% ���ļ��еĸ���
all_img=[];
for i = 1:file_num
    temp_img=[];%��ʱ�洢һ��ͼ���ļ��е�ͼ��
    temp_path =  file_path{i}; % ͼ���ļ���·��
    temp_img_path_list = dir(strcat(temp_path,'*.tif'));%�г��ļ�������(struct����)
    img_num = length(temp_img_path_list); %���ļ�����ͼ������
    if img_num > 0
        for j = 1:img_num
              temp_image=[];%�����ṹ�壬������ɫͼ�񣬻Ҷ�ͼ�񣬻Ҷ�ֱ��ͼ���Լ��Ҷ�ֱ��ͼ����
              temp_image.name=temp_img_path_list(j).name;% ͼ����
              temp_image.img = imread(strcat(temp_path,temp_image.name));%�����ɫͼ��
              %ת��Ϊ�Ҷ�ͼ��
              imgGray=rgb2gray(temp_image.img);
              temp_image.imgGray=imgGray;%����
              %����ռ䣺�Ҷ�ֱ��ͼ����������ֵ������ֵ����
              temp_image.GrayHistEig=[];

              %����ռ䣺4������ĻҶȹ������󡢸�������ֵ�ľ�ֵ�ͷ������ֵ����
              temp_image.GrayCoMtxEig=[];

              %����ռ䣺�ݶȷ���ֱ��ͼ�����������
              temp_image.GradHistEig=[];

              %����ռ䣺RGB��ͨ����ֱ��ͼ�����������
              temp_image.RHistEig=[];
              temp_image.GHistEig=[];
              temp_image.BHistEig=[];

            temp_img=[temp_img temp_image]; 
        end
    end
    all_img=[all_img;temp_img]; 
end
set(handles.checkbox1,'value',1);
set(handles.checkbox1,'enable','on');
set(handles.pushbutton2,'enable','on');

%[file_name, file_path]=uigetfile('*.*','��ѡ���ļ�');%filenameΪ�ļ�����filepathΪ�ļ�·��
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
set(handles.checkbox2,'enable','off');
set(handles.checkbox2,'value',0);
global rand option all_img tar_img
 if(rand)%������
    x=randi(21);%�����
    y=randi(100);%�����
    tar_img=all_img(x,y);
 else
    [image_name,filepath]=uigetfile('*.*','��ѡ���ļ�');%filenameΪ�ļ�����filepathΪ�ļ�·��
    tar_img.img = imread(strcat(filepath,image_name));
    tar_img.name=image_name;
 end
   axes(handles.axes1);
   tar_img.imgGray=rgb2gray(tar_img.img);
   imshow(tar_img.img);
    tar_img.GrayHistEig = fun_HofGL(tar_img.imgGray);
    tar_img.GrayCoMtxEig=fun_HofGCM(tar_img.imgGray);
    tar_img.GradHistEig=fun_HofOG(tar_img.imgGray);
    tar_img.RHistEig = fun_HofGL(tar_img.img(:,:,1));
    tar_img.GHistEig = fun_HofGL(tar_img.img(:,:,2));
    tar_img.BHistEig = fun_HofGL(tar_img.img(:,:,3));
   title(handles.axes1,tar_img.name);
 switch option
     case 1  %�Ҷ�ֱ��ͼ
          axes(handles.axes2);
          bar(tar_img.GrayHistEig.imgHist);
          title('�Ҷ�ֱ��ͼ');

     case 2  %�Ҷȹ�������
          axes(handles.axes2);          
          plot(tar_img.GrayCoMtxEig.eigVec,'mo--');
          title('����ֵ����');
          
     case 3  %�ݶȷ���ֱ��ͼ
          axes(handles.axes2);          
          mesh( tar_img.GradHistEig.eigMtx);
          title('����ֵ����');
          
     case 4  %RGB�Ҷ�ֱ��ͼ
          axes(handles.axes2);
          plot(tar_img.RHistEig.imgHist,'r');hold on;         
          plot(tar_img.GHistEig.imgHist,'g');hold on;         
          plot(tar_img.BHistEig.imgHist,'b');hold on;
          hold off;
          title('RGB��ͨ��ֱ��ͼ');        
 end
  set(handles.pushbutton3,'enable','on');  
    

% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in pushbutton3.

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
set(handles.checkbox2,'value',0);
set(handles.checkbox2,'enable','off');
global option tar_img file_num img_num all_n2 all_img
all_n2=zeros(file_num,img_num);%Ϊ��������ֵ�������Ķ���������/����Ԥ�����ڴ�
switch option 
    %�Ҷ�ֱ��ͼ
    case 1
        for i=1:file_num
            for j=1:img_num
                all_img(i,j).GrayHistEig=fun_HofGL( all_img(i,j).imgGray);
                temp_eig=all_img(i,j).GrayHistEig;
                all_n2(i,j)=norm(tar_img.GrayHistEig.eigVec-temp_eig.eigVec);%���������Ķ������������
            end
        end
        %����������ת��Ϊ������
        n2Vec=[];
        for i=1:size(all_n2,1)
            n2Vec=[n2Vec all_n2(i,:)];
        end
        n2Sort=sort(n2Vec);%�����ж�������������
        idx=zeros(2,6);%Ϊ�洢����Ӱ���±�ľ���Ԥ�����ڴ�
        %��ȡ������С��6��������±�
        for i=2:6%ǰ2-5����С������
            [x,y]=find(all_n2==n2Sort(i));
            idx(i-1,1)=x;
            idx(i-1,2)=y;
        end
         t=tar_img.GrayHistEig.eigVec;
          axes(handles.axes4)
        imshow(all_img(idx(1,1),idx(1,2)).img);
        a=all_img(idx(1,1),idx(1,2)).GrayHistEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes5)
        imshow(all_img(idx(2,1),idx(2,2)).img);
        a=all_img(idx(2,1),idx(2,2)).GrayHistEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes6)
        imshow(all_img(idx(3,1),idx(3,2)).img);
        a=all_img(idx(3,1),idx(3,2)).GrayHistEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes7)
        imshow(all_img(idx(4,1),idx(4,2)).img);
        a=all_img(idx(4,1),idx(4,2)).GrayHistEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes8)
        imshow(all_img(idx(5,1),idx(5,2)).img);
        a=all_img(idx(5,1),idx(5,2)).GrayHistEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes9)
        bar(all_img(idx(1,1),idx(1,2)).GrayHistEig.imgHist);
        title(['n2:' num2str(n2Sort(2))]);
          axes(handles.axes10)
        bar(all_img(idx(2,1),idx(2,2)).GrayHistEig.imgHist);
        title(['n2:' num2str(n2Sort(3))]);
          axes(handles.axes11)
        bar(all_img(idx(3,1),idx(3,2)).GrayHistEig.imgHist);
        title(['n2:' num2str(n2Sort(4))]);
          axes(handles.axes12)
        bar(all_img(idx(4,1),idx(4,2)).GrayHistEig.imgHist);
        title(['n2:' num2str(n2Sort(5))]);
          axes(handles.axes13)
        bar(all_img(idx(5,1),idx(5,2)).GrayHistEig.imgHist);
        title(['n2:' num2str(n2Sort(6))]);
    %�Ҷȹ�������
    case 2
        for i=1:file_num
            for j=1:img_num
                all_img(i,j).GrayCoMtxEig=fun_HofGCM( all_img(i,j).imgGray);
                temp_eig=all_img(i,j).GrayCoMtxEig;
                all_n2(i,j)=norm(tar_img.GrayCoMtxEig.eigVec-temp_eig.eigVec);%���������Ķ������������
            end
        end
        %����������ת��Ϊ������
        n2Vec=[];
        for i=1:size(all_n2,1)
            n2Vec=[n2Vec all_n2(i,:)];
        end
        n2Sort=sort(n2Vec);%�����ж�������������
        idx=zeros(2,6);%Ϊ�洢����Ӱ���±�ľ���Ԥ�����ڴ�
        %��ȡ������С��6��������±�
        for i=2:6%ǰ2-5����С������
            [x,y]=find(all_n2==n2Sort(i));
            idx(i-1,1)=x;
            idx(i-1,2)=y;
        end
        t=tar_img.GrayCoMtxEig.eigVec;
          axes(handles.axes4)
        imshow(all_img(idx(1,1),idx(1,2)).img);
        a=all_img(idx(1,1),idx(1,2)).GrayCoMtxEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes5)
        imshow(all_img(idx(2,1),idx(2,2)).img);
        a=all_img(idx(2,1),idx(2,2)).GrayCoMtxEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes6)
        imshow(all_img(idx(3,1),idx(3,2)).img);
        a=all_img(idx(3,1),idx(3,2)).GrayCoMtxEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes7)
        imshow(all_img(idx(4,1),idx(4,2)).img);
        a=all_img(idx(4,1),idx(4,2)).GrayCoMtxEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes8)
        imshow(all_img(idx(5,1),idx(5,2)).img);
        a=all_img(idx(5,1),idx(5,2)).GrayCoMtxEig.eigVec;
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes9)
        plot(all_img(idx(1,1),idx(1,2)).GrayCoMtxEig.eigVec,'mo--');
        title(['n2:' num2str(n2Sort(1))]);
          axes(handles.axes10)
         plot(all_img(idx(2,1),idx(2,2)).GrayCoMtxEig.eigVec,'mo--');
        title(['n2:' num2str(n2Sort(3))]);
          axes(handles.axes11)
         plot(all_img(idx(3,1),idx(3,2)).GrayCoMtxEig.eigVec,'mo--');
        title(['n2:' num2str(n2Sort(4))]);
          axes(handles.axes12)
         plot(all_img(idx(4,1),idx(4,2)).GrayCoMtxEig.eigVec,'mo--');
        title(['n2:' num2str(n2Sort(5))]);
          axes(handles.axes13)
        plot(all_img(idx(5,1),idx(5,2)).GrayCoMtxEig.eigVec,'mo--');
        title(['n2:' num2str(n2Sort(6))]);
    %�ݶȷ���ֱ��ͼ
    case 3
        for i=1:file_num
            for j=1:img_num
                all_img(i,j).GradHistEig=fun_HofOG( all_img(i,j).imgGray);
                temp_eig=all_img(i,j).GradHistEig;
                all_n2(i,j)=norm(tar_img.GradHistEig.eigMtx-temp_eig.eigMtx);%���������Ķ������������
            end
        end
        %����������ת��Ϊ������
        n2Vec=[];
        for i=1:size(all_n2,1)
            n2Vec=[n2Vec all_n2(i,:)];
        end
        n2Sort=sort(n2Vec);%�����ж�������������
        idx=zeros(2,6);%Ϊ�洢����Ӱ���±�ľ���Ԥ�����ڴ�
        %��ȡ������С��6��������±�
        for i=2:6%ǰ2-5����С������
            [x,y]=find(all_n2==n2Sort(i));
            idx(i-1,1)=x;
            idx(i-1,2)=y;
        end
         t=sum(tar_img.GradHistEig.eigMtx);%���������������
          axes(handles.axes4)
        imshow(all_img(idx(1,1),idx(1,2)).img);
        a=sum(all_img(idx(1,1),idx(1,2)).GradHistEig.eigMtx);
         p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes5)
        imshow(all_img(idx(2,1),idx(2,2)).img);
        a=sum(all_img(idx(2,1),idx(2,2)).GradHistEig.eigMtx);
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes6)
        imshow(all_img(idx(3,1),idx(3,2)).img);
        a=sum(all_img(idx(3,1),idx(3,2)).GradHistEig.eigMtx);
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes7)
        imshow(all_img(idx(4,1),idx(4,2)).img);
        a=sum(all_img(idx(4,1),idx(4,2)).GradHistEig.eigMtx);
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes8)
        imshow(all_img(idx(5,1),idx(5,2)).img);
       a=sum(all_img(idx(5,1),idx(5,2)).GradHistEig.eigMtx);
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes9)         
        mesh(all_img(idx(1,1),idx(1,2)).GradHistEig.eigMtx);
        title(['n2:' num2str(n2Sort(2))]);
          axes(handles.axes10)
        mesh(all_img(idx(2,1),idx(2,2)).GradHistEig.eigMtx);
        title(['n2:' num2str(n2Sort(3))]);
          axes(handles.axes11)
        mesh(all_img(idx(3,1),idx(3,2)).GradHistEig.eigMtx);
        title(['n2:' num2str(n2Sort(4))]);
          axes(handles.axes12)
        mesh(all_img(idx(4,1),idx(4,2)).GradHistEig.eigMtx);
        title(['n2:' num2str(n2Sort(5))]);
          axes(handles.axes13)
        mesh(all_img(idx(5,1),idx(5,2)).GradHistEig.eigMtx);
        title(['n2:' num2str(n2Sort(6))]);
    %RGB��ͨ��ֱ��ͼ
    case 4
        for i=1:file_num
            for j=1:img_num
                all_img(i,j).RHistEig=fun_HofGL( all_img(i,j).img(:,:,1));temp_eigR=all_img(i,j).RHistEig;
                all_img(i,j).GHistEig=fun_HofGL( all_img(i,j).img(:,:,2));temp_eigG=all_img(i,j).GHistEig;
                all_img(i,j).BHistEig=fun_HofGL( all_img(i,j).img(:,:,3));temp_eigB=all_img(i,j).BHistEig;
                %�ֱ��������ͨ������ֵ������Ķ�����
                n1=norm(tar_img.RHistEig.eigVec-temp_eigR.eigVec);
                n2=norm(tar_img.GHistEig.eigVec-temp_eigG.eigVec);
                n3=norm(tar_img.BHistEig.eigVec-temp_eigB.eigVec);
                %�����������Ķ�����
                all_n2(i,j)=norm([n1 n2 n3]);
            end
        end
        %����������ת��Ϊ������
        n2Vec=[];
        for i=1:size(all_n2,1)
            n2Vec=[n2Vec all_n2(i,:)];
        end
        n2Sort=sort(n2Vec);%�����ж�������������
        idx=zeros(2,6);%Ϊ�洢����Ӱ���±�ľ���Ԥ�����ڴ�
        %��ȡ������С��6��������±�
        for i=2:6%ǰ2-5����С������
            [x,y]=find(all_n2==n2Sort(i));
            idx(i-1,1)=x;
            idx(i-1,2)=y;
        end
        t=[tar_img.RHistEig.eigVec,tar_img.GHistEig.eigVec,tar_img.BHistEig.eigVec];
          axes(handles.axes4)
        imshow(all_img(idx(1,1),idx(1,2)).img);
        a=[all_img(idx(1,1),idx(1,2)).RHistEig.eigVec,all_img(idx(1,1),idx(1,2)).GHistEig.eigVec,all_img(idx(1,1),idx(1,2)).BHistEig.eigVec];
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes5)
        imshow(all_img(idx(2,1),idx(2,2)).img);
        a=[all_img(idx(2,1),idx(2,2)).RHistEig.eigVec,all_img(idx(2,1),idx(2,2)).GHistEig.eigVec,all_img(idx(2,1),idx(2,2)).BHistEig.eigVec];
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes6)
        imshow(all_img(idx(3,1),idx(3,2)).img);
        a=[all_img(idx(3,1),idx(3,2)).RHistEig.eigVec,all_img(idx(3,1),idx(3,2)).GHistEig.eigVec,all_img(idx(3,1),idx(3,2)).BHistEig.eigVec];
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes7)
        imshow(all_img(idx(4,1),idx(4,2)).img);
        a=[all_img(idx(4,1),idx(4,2)).RHistEig.eigVec,all_img(idx(4,1),idx(4,2)).GHistEig.eigVec,all_img(idx(4,1),idx(4,2)).BHistEig.eigVec];
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes8)
        imshow(all_img(idx(5,1),idx(5,2)).img);
        a=[all_img(idx(5,1),idx(5,2)).RHistEig.eigVec,all_img(idx(5,1),idx(5,2)).GHistEig.eigVec,all_img(idx(5,1),idx(5,2)).BHistEig.eigVec];
        p=t*a'/norm(t)/norm(a)*100;
        title(['���ƶȣ�' '%' num2str(p)]);
          axes(handles.axes9)
        plot(all_img(idx(1,1),idx(1,2)).RHistEig.imgHist,'r');hold on;         
        plot(all_img(idx(1,1),idx(1,2)).GHistEig.imgHist,'g');hold on;         
        plot(all_img(idx(1,1),idx(1,2)).BHistEig.imgHist,'b');hold on;
          hold off;
        title(['n2:' num2str(n2Sort(2))]);
          axes(handles.axes10)
        plot(all_img(idx(2,1),idx(2,2)).RHistEig.imgHist,'r');hold on;         
        plot(all_img(idx(2,1),idx(2,2)).GHistEig.imgHist,'g');hold on;         
        plot(all_img(idx(2,1),idx(2,2)).BHistEig.imgHist,'b');hold on;
        title(['n2:' num2str(n2Sort(3))]);
          axes(handles.axes11)
        plot(all_img(idx(3,1),idx(4,2)).RHistEig.imgHist,'r');hold on;         
        plot(all_img(idx(3,1),idx(4,2)).GHistEig.imgHist,'g');hold on;         
        plot(all_img(idx(3,1),idx(4,2)).BHistEig.imgHist,'b');hold on;
        title(['n2:' num2str(n2Sort(4))]);
          axes(handles.axes12)
        plot(all_img(idx(4,1),idx(4,2)).RHistEig.imgHist,'r');hold on;         
        plot(all_img(idx(4,1),idx(4,2)).GHistEig.imgHist,'g');hold on;         
        plot(all_img(idx(4,1),idx(4,2)).BHistEig.imgHist,'b');hold on;
        title(['n2:' num2str(n2Sort(5))]);
          axes(handles.axes13)
        plot(all_img(idx(5,1),idx(5,2)).RHistEig.imgHist,'r');hold on;         
        plot(all_img(idx(5,1),idx(5,2)).GHistEig.imgHist,'g');hold on;         
        plot(all_img(idx(5,1),idx(5,2)).BHistEig.imgHist,'b');hold on;
        title(['n2:' num2str(n2Sort(6))]);       
        
end
set(handles.checkbox2,'value',1);
set(handles.checkbox2,'enable','on')
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
global rand
rand=1;%���
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton1

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
global rand
rand=0;%�ֶ�
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2







% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global option
option=get(handles.listbox1,'value');
% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
