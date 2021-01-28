function varargout = ADKO(varargin)
% ADKO MATLAB code for ADKO.fig
%      ADKO, by itself, creates a new ADKO or raises the existing
%      singleton*.
%
%      H = ADKO returns the handle to a new ADKO or the handle to
%      the existing singleton*.
%
%      ADKO('CALLBACK',hObject,eventData,handles,...) calls Okrethe local
%      function named CALLBACK in ADKO.M with the given input arguments.
%
%      ADKO('Property','Value',...) creates a new ADKO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ADKO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ADKO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ADKO

% Last Modified by GUIDE v2.5 17-Jan-2019 23:59:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ADKO_OpeningFcn, ...
    'gui_OutputFcn',  @ADKO_OutputFcn, ...
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


% --- Executes just before ADKO is made visible.
function ADKO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ADKO (see VARARGIN)

% Choose default command line output for ADKO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ADKO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ADKO_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% F U N K C J E   K O M P R E S I J %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in zapisz_button.
function zapisz_button_Callback(hObject, eventdata, handles)
% hObject    handle to zapisz_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global proba;
global m1;
global n1;
global A1;
global info;
global contents_transformata;
global contents_rozmiar_bl;
global contents_sposob_komp;
global lengc;
global s;
global falka;
global slownik;
global hh;
global hh2;
global contents_format;

if contents_transformata==1
    if contents_format==2
        uisave({'proba','m1','n1','slownik','contents_transformata','contents_rozmiar_bl','contents_sposob_komp','contents_format'},'Obraz skompresowany');
    else
         uisave({'proba','m1','n1','slownik','hh','hh2','contents_transformata','contents_rozmiar_bl','contents_sposob_komp','contents_format'},'Obraz skompresowany');
    end
else
    uisave({'A1','lengc','s','falka','hh','hh2','contents_transformata','contents_format'},'Obraz skompresowany');
end

infocom=dir('Obraz skompresowany.mat');
wspocom=info.FileSize/infocom.bytes;
oszczcom=(1-(infocom.bytes/info.FileSize))*100;
set(handles.nazwa_com,'string',infocom.name);
set(handles.rozmiar_com,'string',infocom.bytes/1000);
set(handles.wspol_com,'string',wspocom);
set(handles.oszcz_com,'string',oszczcom);

% --- Executes on button press in wyczysc_button3.
function wyczysc_button3_Callback(hObject, eventdata, handles)
% hObject    handle to wyczysc_button3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.nazwa,'string',{''});
set(handles.rozmiar,'string',{''});
set(handles.format,'string',{''});
set(handles.szerokosc,'string',{''});
set(handles.wysokosc,'string',{''});
set(handles.kolor,'string',{''});
set(handles.bpp,'string',{''});
set(handles.entropia,'string',{''});
set(handles.nazwa_com,'string',{''});
set(handles.rozmiar_com,'string',{''});
set(handles.wspol_com,'string',{''});
set(handles.oszcz_com,'string',{''});
clearvars -global
cla

% --- Executes on button press in kompresuj_button.
function kompresuj_button_Callback(hObject, eventdata, handles)
% hObject    handle to kompresuj_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global contents_transformata;
global contents_rozmiar_bl;
global contents_sposob_komp;
global ObrazORG;
global PK;
global contents_format;
global proba;
global m1;
global n1;
global level;
global falka;
global A1;
global m;
global n;
global lengc;
global s;
global slownik;
global hh;
global hh2;

[m,n] = size(ObrazORG);

proba=[];
if contents_transformata==1
    if contents_rozmiar_bl==1
        if contents_sposob_komp==1
            if contents_format==1
                %4x4 w blokach int8
                rows = m;
                cols = n;
                Rb = 4; % block rows
                Cb = 4; % block columns
                Rx = Rb*ones(1,rows/Rb);
                Cx = Cb*ones(1,cols/Cb);
                S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                
                [m1,n1]=size(S);
                
                [proba,hh,hh2]=dct4x4fiwblint8(S,m1,n1,PK);
            elseif contents_format==2
                %4x4 w blokach int16
                rows = m;
                cols = n;
                Rb = 4; % block rows
                Cb = 4; % block columns
                Rx = Rb*ones(1,rows/Rb);
                Cx = Cb*ones(1,cols/Cb);
                S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                
                [m1,n1]=size(S);
                
                proba=dct4x4fiwblint16(S,m1,n1,PK);
            else
            end
        else
            if contents_format==1
                %4x4 rle int8
                rows = m;
                cols = n;
                Rb = 4; % block rows
                Cb = 4; % block columns
                Rx = Rb*ones(1,rows/Rb);
                Cx = Cb*ones(1,cols/Cb);
                S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                
                [m1,n1]=size(S);
                
                [proba,slownik,hh,hh2]=dct4x4IIint8(S,m1,n1,PK);
            elseif contents_format==2
                %4x4 rle int16
                rows = m;
                cols = n;
                Rb = 4; % block rows
                Cb = 4; % block columns
                Rx = Rb*ones(1,rows/Rb);
                Cx = Cb*ones(1,cols/Cb);
                S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                
                [m1,n1]=size(S);
                
                [proba,slownik]=dct4x4IIint16(S,m1,n1,PK);
            else

            end
        end
    elseif contents_rozmiar_bl==2
        if contents_sposob_komp==1
            if contents_format==1
                %8x8 w blokach int8
                rows = m;
                cols = n;
                Rb = 8; % block rows
                Cb = 8; % block columns
                Rx = Rb*ones(1,rows/Rb);
                Cx = Cb*ones(1,cols/Cb);
                S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                
                [m1,n1]=size(S);
                
                [proba,hh,hh2]=dct8x8fiwblint8(S,m1,n1,PK);
            elseif contents_format==2
                %8x8 w blokach int16
                rows = m;
                cols = n;
                Rb = 8; % block rows
                Cb = 8; % block columns
                Rx = Rb*ones(1,rows/Rb);
                Cx = Cb*ones(1,cols/Cb);
                S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                
                [m1,n1]=size(S);
                
                proba=dct8x8fiwblint16(S,m1,n1,PK);
            else

            end
        else
            if contents_format==1
                %8x8 tresh int8
                rows = m;
                cols = n;
                Rb = 8; % block rows
                Cb = 8; % block columns
                Rx = Rb*ones(1,rows/Rb);
                Cx = Cb*ones(1,cols/Cb);
                S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                
                [m1,n1]=size(S);
                
                [proba,slownik,hh,hh2]=dct8x8IIint8(S,m1,n1,PK);
            elseif contents_format==2
                %8x8 tresh int16
                rows = m;
                cols = n;
                Rb = 8; % block rows
                Cb = 8; % block columns
                Rx = Rb*ones(1,rows/Rb);
                Cx = Cb*ones(1,cols/Cb);
                S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                
                [m1,n1]=size(S);
                
                [proba,slownik]=dct8x8IIint16(S,m1,n1,PK);
            else
            end
        end
    else
        if contents_sposob_komp==1
            if contents_format==1
                %16x16 w blokach int8
                rows = m;
                cols = n;
                Rb = 16; % block rows
                Cb = 16; % block columns
                if mod((rows/Rb),1)==0 && mod((rows/Cb),1)==0
                    Rx = Rb*ones(1,rows/Rb);
                    Cx = Cb*ones(1,cols/Cb);
                    S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                                    [m1,n1]=size(S);
                
                [proba,hh,hh2]=dct16x16fiwblint8(S,m1,n1,PK);
                else
                    msgbox('WYMIARY OBRAZU MUSZ¥ BYÆ PODZIELNE PRZEZ 16','B£¥D');
                end

            elseif contents_format==2
                %16x16 w blokach int16
                rows = m;
                cols = n;
                Rb = 16; % block rows
                Cb = 16; % block columns
                if mod((rows/Rb),1)==0 && mod((rows/Cb),1)==0
                    Rx = Rb*ones(1,rows/Rb);
                    Cx = Cb*ones(1,cols/Cb);
                    S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                                    [m1,n1]=size(S);
                
                proba=dct16x16fiwblint16(S,m1,n1,PK);
                else
                    msgbox('WYMIARY OBRAZU MUSZ¥ BYÆ PODZIELNE PRZEZ 16','B£¥D');
                end
            else
            end
        else
            if contents_format==1
                %16x16 tresh int8
                rows = m;
                cols = n;
                Rb = 16; % block rows
                Cb = 16; % block columns
                if mod((rows/Rb),1)==0 && mod((rows/Cb),1)==0
                    Rx = Rb*ones(1,rows/Rb);
                    Cx = Cb*ones(1,cols/Cb);
                    S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                                    [m1,n1]=size(S);
                
                [proba,slownik,hh,hh2]=dct16x16IIint8(S,m1,n1,PK);
                else
                    msgbox('WYMIARY OBRAZU MUSZ¥ BYÆ PODZIELNE PRZEZ 16','B£¥D');
                end
            elseif contents_format==2
                %16x16 tresh int16
                rows = m;
                cols = n;
                Rb = 16; % block rows
                Cb = 16; % block columns
                if mod((rows/Rb),1)==0 && mod((rows/Cb),1)==0
                    Rx = Rb*ones(1,rows/Rb);
                    Cx = Cb*ones(1,cols/Cb);
                    S = struct('block',mat2cell(ObrazORG,Rx,Cx));
                                    [m1,n1]=size(S);
                
                [proba,slownik]=dct16x16IIint16(S,m1,n1,PK);
                else
                    msgbox('WYMIARY OBRAZU MUSZ¥ BYÆ PODZIELNE PRZEZ 16','B£¥D');
                end
            else
            end
        end
    end 
else
    if contents_format==1
    [A1,lengc,s,falka,hh,hh2]=DWTint8(ObrazORG,level,falka,PK);    
    elseif contents_format==2
    [A1,lengc,s,falka]=DWTint16(ObrazORG,level,falka,PK);         
    end
end
if isempty(proba)==0
msgbox('OBRAZ POMŒLNIE SKOMPRESOWANY!','SUKCES!');
elseif isempty(A1)==0
msgbox('OBRAZ POMŒLNIE SKOMPRESOWANY!','SUKCES!');
end

% --- Executes on button press in wybierz_button.
function wybierz_button_Callback(hObject, eventdata, handles)
% hObject    handle to wybierz_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ObrazORG;
global info;
[Obraz,sciezka,index]=uigetfile({'*.bmp'});
if Obraz==0
    msgbox('NIE WYBRANIO PLIKU','B£¥D');
else
    if index==1
        ObrazORG=rgb2gray(imread(Obraz));
        imwrite(ObrazORG,'ObrazORG.bmp');
        info = imfinfo('ObrazORG.bmp');
        entropiaORG=entropy(ObrazORG);
        set(handles.nazwa,'string',Obraz);
        set(handles.rozmiar,'string',info.FileSize/1000);
        set(handles.format,'string',info.Format);
        set(handles.szerokosc,'string',info.Width);
        set(handles.wysokosc,'string',info.Height);
        set(handles.kolor,'string',info.ColorType);
        set(handles.bpp,'string',info.BitDepth);
        set(handles.entropia,'string',entropiaORG);
        imshow(ObrazORG,'Parent',handles.axes1);
    else
        msgbox('WYBRANO NIEW£AŒCIWY PLIK','B£¥D');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% P A R A M E T R Y %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on selection change in transformata.
function transformata_Callback(hObject, eventdata, handles)
% hObject    handle to transformata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns transformata contents as cell array
%        contents{get(hObject,'Value')} returns selected item from transformata
global contents_transformata;
contents_transformata = get(hObject,'Value');
switch contents_transformata
    case 1
        set(handles.poziom_dekom_popup,'Enable','off');
        set(handles.falka_popup,'Enable','off');
        set(handles.rozmiar_bl_popup,'Enable','on')
        set(handles.sposob_komp_popup,'Enable','on')
        set(handles.slider1,'Enable','on')
        set(handles.format_popup,'Enable','on')
    case 2
        set(handles.poziom_dekom_popup,'Enable','on');
        set(handles.falka_popup,'Enable','on');
        set(handles.rozmiar_bl_popup,'Enable','off')
        set(handles.sposob_komp_popup,'Enable','off')
        set(handles.slider1,'Enable','on')
        set(handles.format_popup,'Enable','on')
end

% --- Executes on selection change in rozmiar_bl_popup.
function rozmiar_bl_popup_Callback(hObject, eventdata, handles)
% hObject    handle to rozmiar_bl_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rozmiar_bl_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rozmiar_bl_popup
global contents_rozmiar_bl;
contents_rozmiar_bl = get(hObject,'Value');

% --- Executes on selection change in sposob_komp_popup.
function sposob_komp_popup_Callback(hObject, eventdata, handles)
% hObject    handle to sposob_komp_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sposob_komp_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sposob_komp_popup

global contents_sposob_komp;
contents_sposob_komp = get(hObject,'Value');

% --- Executes on slider movement.
function slider1_Callback(hObject, ~, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global PK;
PK=get(hObject,'Value');

% --- Executes on selection change in poziom_dekom_popup.
function poziom_dekom_popup_Callback(hObject, eventdata, handles)
% hObject    handle to poziom_dekom_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poziom_dekom_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poziom_dekom_popup
global level;
contents_poziom_dekom = get(hObject,'Value');
switch contents_poziom_dekom
    case 1
        level=1;
    case 2
        level=2;
    case 3
        level=3;
end

% --- Executes on selection change in falka_popup.
function falka_popup_Callback(hObject, eventdata, handles)
% hObject    handle to falka_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns falka_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from falka_popup
global falka;
contents_falka = get(hObject,'Value');
switch contents_falka
    case 1
        falka='haar';
    case 2
        falka='db5';
    case 3
        falka='dmey';
end

% --- Executes on selection change in format_popup.
function format_popup_Callback(hObject, eventdata, handles)
% hObject    handle to format_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns format_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from format_popup

global contents_format;
contents_format = get(hObject,'Value');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% F U N K C J E  D E K O M P R E S I J %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in zapisz_decom_butt.
function zapisz_decom_butt_Callback(hObject, eventdata, handles)
% hObject    handle to zapisz_decom_butt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Z;
imwrite(Z,'Obraz zdekompresowany.bmp');

% --- Executes on button press in porownaj_butt.
function porownaj_butt_Callback(hObject, eventdata, handles)
% hObject    handle to porownaj_butt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Z;
global ObrazPorow;

[ObrazPoro,sciezka,index]=uigetfile({'*.bmp'});
if ObrazPoro==0
    msgbox('NIE WYBRANIO PLIKU','B£¥D');
else
    if index==1
        ObrazPorow=imread(ObrazPoro);
        err = immse(Z,ObrazPorow);
        set(handles.text65,'string',err);
        peaksnr = psnr(ObrazPorow,Z);
        set(handles.text72,'string',peaksnr);
        entro=entropy(Z);
        set(handles.text74,'string',entro);
        imshowpair(ObrazPorow,Z,'montage','Parent',handles.axes4)
    else
        msgbox('WYBRANO NIEW£AŒCIWY PLIK','B£¥D');
    end
end

% --- Executes on button press in dekom_butt.
function dekom_butt_Callback(hObject, eventdata, handles)
% hObject    handle to dekom_butt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
global Z;
if S.contents_transformata==1
    if S.contents_rozmiar_bl==1
        if S.contents_sposob_komp==1
            if S.contents_format==2
            %dct 4x4 I sposob int16
            Z=uint8(dct4x41spos(S.proba,S.m1,S.n1));
            imshow(Z,'Parent',handles.axes2);
            else
            %dct 4x4 I sposob int8
            Z=uint8(dct4x41sposint8(S.proba,S.m1,S.n1,S.hh,S.hh2));
            imshow(Z,'Parent',handles.axes2);  
            end
        else
            if S.contents_format==2
            %dct 4x4 II sposob int16
            Z=uint8(idct4x4II(S.proba,S.m1,S.n1,S.slownik));
            imshow(Z,'Parent',handles.axes2);
            else
             %dct 4x4 II sposob int8
            Z=uint8(idct4x4IIint8(S.proba,S.m1,S.n1,S.slownik,S.hh,S.hh2));
            imshow(Z,'Parent',handles.axes2);
            end

        end
    elseif S.contents_rozmiar_bl==2
        if S.contents_sposob_komp==1
            if S.contents_format==2
            %dct 8x8 I sposob int16
            Z=uint8(dct8x81spos(S.proba,S.m1,S.n1));
            imshow(Z,'Parent',handles.axes2);
            else
            %dct 8x8 I sposob int8
            Z=uint8(dct8x81sposint8(S.proba,S.m1,S.n1,S.hh,S.hh2));
            imshow(Z,'Parent',handles.axes2);   
            end
        else
            if S.contents_format==2
            %dct 8x8 II sposob
            Z=uint8(idct8x8II(S.proba,S.m1,S.n1,S.slownik));
            imshow(Z,'Parent',handles.axes2);
            else
            %dct 8x8 II sposob int8
            Z=uint8(idct8x8IIint8(S.proba,S.m1,S.n1,S.slownik,S.hh,S.hh2));
            imshow(Z,'Parent',handles.axes2);    
            end
        end
    else
        if S.contents_sposob_komp==1
            if S.contents_format==2
            %dct 16x16 I sposob int16
            Z=uint8(dct16x161spos(S.proba,S.m1,S.n1));
            imshow(Z,'Parent',handles.axes2);
            else
            %dct 16x16 I sposob int8
            Z=uint8(dct16x161sposint8(S.proba,S.m1,S.n1,S.hh,S.hh2));
            imshow(Z,'Parent',handles.axes2); 
            end
        else
            if S.contents_format==2
            %dct 16x16 II sposob int 16
            Z=uint8(idct16x16II(S.proba,S.m1,S.n1,S.slownik));
            imshow(Z,'Parent',handles.axes2);
            else
            %dct 16x16 II sposob int8
            Z=uint8(idct16x16IIint8(S.proba,S.m1,S.n1,S.slownik,S.hh,S.hh2));
            imshow(Z,'Parent',handles.axes2);            
            end
        end
    end
else
    if S.contents_format==2
    Z=uint8(IDWT(S.A1,S.lengc,S.s,S.falka));
    imshow(Z,'Parent',handles.axes2);
    else
    Z=uint8(IDWTint8(S.A1,S.lengc,S.s,S.falka,S.hh,S.hh2));
    imshow(Z,'Parent',handles.axes2);  
    end
end

% --- Executes on button press in wybierz_pl_butt.
function wybierz_pl_butt_Callback(hObject, eventdata, handles)
% hObject    handle to wybierz_pl_butt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
[Obraz,sciezka,index]=uigetfile({'*.mat'});
if Obraz==0
    msgbox('NIE WYBRANIO PLIKU','B£¥D');
else
    if index==1
        S=load(Obraz,'-mat');
    else
        msgbox('WYBRANO NIEW£AŒCIWY PLIK','B£¥D');
    end
end

% --- Executes on button press in nowe_okna_butt.
function nowe_okna_butt_Callback(hObject, eventdata, handles)
% hObject    handle to nowe_okna_butt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Z;
global ObrazPorow;
figure(1);
imshow(ObrazPorow);
title('\fontsize{16} Obraz wybrany do porównania');
figure(2);
imshow(Z);
title('\fontsize{16} Obraz zdekompresowany');
figure(3);
imshowpair(ObrazPorow,Z,'montage');
title('\fontsize{16} Porównanie obrazów');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% F U N K C J E   T W O R Z ¥ C E %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes during object creation, after setting all properties.
function transformata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to transformata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function rozmiar_bl_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rozmiar_bl_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function falka_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rozmiar_bl_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function sposob_komp_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sposob_komp_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function poziom_dekom_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poziom_dekom_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function format_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to format_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% F U N K C J E   L I C Z ¥ C E %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%    DCT I SPOSOB    %%%%%%%%%%%%%%

function output=dct4x4fiwblint16(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=16:-1:-PK
                ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
            end
        end
    end
end
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:16
                if l==1 && ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok=0;
                end
                if ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)~=0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=ObrazPOdctSTRUCTzigzag(i,j).blok(k,l);
                end
            end
        end
    end
end
for i=1:1:m1
    for j=1:1:n1
        output(i,j).blok=int16(round(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end
function [output,hh,hh2]=dct4x4fiwblint8(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end



for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=16:-1:-PK
                ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:16
                if l==1 && ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok=0;
                end
                if ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)~=0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=ObrazPOdctSTRUCTzigzag(i,j).blok(k,l);
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        compresed1(i,j).bbl=(ObrazPOdctSTRUCTzigzag1(i,j).blok);
    end
end
for i=1:1:m1
    for j=1:1:n1
        h(i,j)=min(compresed1(i,j).bbl);
        h2(i,j)=max(compresed1(i,j).bbl);
    end
end

hh=min(min(h));
hh2=max(max(h2));

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(compresed1(i,j).bbl)
                output(i,j).blok(k,l)=uint8(round(((compresed1(i,j).bbl(k,l)-hh)/(hh2-hh))*255));
            end
        end
    end
end

function output=dct8x8fiwblint16(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end



for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=64:-1:-PK
                ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:64
                if l==1 && ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok=0;
                end
                if ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)~=0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=ObrazPOdctSTRUCTzigzag(i,j).blok(k,l);
                end
            end
        end
    end
end



for i=1:1:m1
    for j=1:1:n1
        output(i,j).blok=int16(round(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end
function [output,hh,hh2]=dct8x8fiwblint8(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end



for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=64:-1:-PK
                ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:64
                if l==1 && ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok=0;
                end
                if ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)~=0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=ObrazPOdctSTRUCTzigzag(i,j).blok(k,l);
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        compresed1(i,j).bbl=(ObrazPOdctSTRUCTzigzag1(i,j).blok);
    end
end
for i=1:1:m1
    for j=1:1:n1
        h(i,j)=min(compresed1(i,j).bbl);
        h2(i,j)=max(compresed1(i,j).bbl);
    end
end

hh=min(min(h));
hh2=max(max(h2));

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(compresed1(i,j).bbl)
                output(i,j).blok(k,l)=uint8(round(((compresed1(i,j).bbl(k,l)-hh)/(hh2-hh))*255));
            end
        end
    end
end

function output=dct16x16fiwblint16(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end



for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=256:-1:-PK
                ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:256
                if l==1 && ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok=0;
                end
                if ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)~=0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=ObrazPOdctSTRUCTzigzag(i,j).blok(k,l);
                end
            end
        end
    end
end



for i=1:1:m1
    for j=1:1:n1
        output(i,j).blok=int16(round(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end
function [output,hh,hh2]=dct16x16fiwblint8(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end



for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=256:-1:-PK
                ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:256
                if l==1 && ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok=0;
                end
                if ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)~=0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=ObrazPOdctSTRUCTzigzag(i,j).blok(k,l);
                end
            end
        end
    end
end



for i=1:1:m1
    for j=1:1:n1
        compresed1(i,j).bbl=(ObrazPOdctSTRUCTzigzag1(i,j).blok);
    end
end
for i=1:1:m1
    for j=1:1:n1
        h(i,j)=min(compresed1(i,j).bbl);
        h2(i,j)=max(compresed1(i,j).bbl);
    end
end

hh=min(min(h));
hh2=max(max(h2));

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(compresed1(i,j).bbl)
                output(i,j).blok(k,l)=uint8(round(((compresed1(i,j).bbl(k,l)-hh)/(hh2-hh))*255));
            end
        end
    end
end

%%%%%%%%%%%%%%%%   IDCT I SPOSOB   %%%%%%%%%%%%%%%%%

function output=dct4x41spos(in,m1,n1)
for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=double(in(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        if proba(i,j).blok==0
            proba(i,j).blok=zeros(1,16);
        elseif length(proba(i,j).blok)~=16
            proba(i,j).blok=[proba(i,j).blok,zeros(1,16-length(proba(i,j).blok))];
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,4,4);
    end
end

for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end

output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));
function output=dct4x41sposint8(in,m1,n1,hh,hh2)

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(in(i,j).blok)
                y(i,j).blok(k,l)=double(in(i,j).blok(k,l));
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(y(i,j).blok)
                ry(i,j).blok(k,l)=((y(i,j).blok(k,l)*(hh2-hh))/255)+hh;
            end
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=double(ry(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        if proba(i,j).blok==0
            proba(i,j).blok=zeros(1,16);
        elseif length(proba(i,j).blok)~=16
            proba(i,j).blok=[proba(i,j).blok,zeros(1,16-length(proba(i,j).blok))];
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,4,4);
    end
end

for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end

output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));
function output=dct8x81spos(in,m1,n1)

for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=double(in(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        if proba(i,j).blok==0
            proba(i,j).blok=zeros(1,64);
        elseif length(proba(i,j).blok)~=64
            proba(i,j).blok=[proba(i,j).blok,zeros(1,64-length(proba(i,j).blok))];
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,8,8);
    end
end

for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end

output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));
function output=dct8x81sposint8(in,m1,n1,hh,hh2)

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(in(i,j).blok)
                y(i,j).blok(k,l)=double(in(i,j).blok(k,l));
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(y(i,j).blok)
                ry(i,j).blok(k,l)=((y(i,j).blok(k,l)*(hh2-hh))/255)+hh;
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=double(ry(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        if proba(i,j).blok==0
            proba(i,j).blok=zeros(1,64);
        elseif length(proba(i,j).blok)~=64
            proba(i,j).blok=[proba(i,j).blok,zeros(1,64-length(proba(i,j).blok))];
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,8,8);
    end
end

for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end

output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));
function output=dct16x161spos(in,m1,n1)
for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=double(in(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        if proba(i,j).blok==0
            proba(i,j).blok=zeros(1,256);
        elseif length(proba(i,j).blok)~=256
            proba(i,j).blok=[proba(i,j).blok,zeros(1,256-length(proba(i,j).blok))];
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,16,16);
    end
end

for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end

output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));
function output=dct16x161sposint8(in,m1,n1,hh,hh2)

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(in(i,j).blok)
                y(i,j).blok(k,l)=double(in(i,j).blok(k,l));
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(y(i,j).blok)
                ry(i,j).blok(k,l)=((y(i,j).blok(k,l)*(hh2-hh))/255)+hh;
            end
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=double(ry(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        if proba(i,j).blok==0
            proba(i,j).blok=zeros(1,256);
        elseif length(proba(i,j).blok)~=256
            proba(i,j).blok=[proba(i,j).blok,zeros(1,256-length(proba(i,j).blok))];
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,16,16);
    end
end

for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end

output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));

%%%%%%%%%%%%%%%    DCT II SPOSOB    %%%%%%%%%%%%%%

function [compresed1,slownik]=dct8x8IIint16(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end
x=63+PK;
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:64
                if abs(ObrazPOdctSTRUCTzigzag(i,j).blok(k,l))<x
                    ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=(int16(round(ObrazPOdctSTRUCTzigzag(i,j).blok)));
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:64
                if proba(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=0;
                else
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=1;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        slownik(i,j).blok=(int8(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end

for i=1:1:m1
    for j=1:1:n1
compres=nonzeros(proba(i,j).blok);
compresed1(i,j).bbl=compres';
    end
end
function [output,slownik,hh,hh2]=dct8x8IIint8(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end
x=63+PK;
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:64
                if abs(ObrazPOdctSTRUCTzigzag(i,j).blok(k,l))<x
                    ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=(ObrazPOdctSTRUCTzigzag(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:64
                if proba(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=0;
                else
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=1;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        slownik(i,j).blok=(int8(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end

for i=1:1:m1
    for j=1:1:n1
compres=nonzeros(proba(i,j).blok);
compresed1(i,j).bbl=compres';
    end
end
for i=1:1:m1
    for j=1:1:n1
        h(i,j)=min(compresed1(i,j).bbl);
        h2(i,j)=max(compresed1(i,j).bbl);
    end
end

hh=min(min(h));
hh2=max(max(h2));

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(compresed1(i,j).bbl)
                output(i,j).blok(k,l)=uint8(round(((compresed1(i,j).bbl(k,l)-hh)/(hh2-hh))*255));
            end
        end
    end
end

function [compresed1,slownik]=dct4x4IIint16(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end
x=63+PK;
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:16
                if abs(ObrazPOdctSTRUCTzigzag(i,j).blok(k,l))<x
                    ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=(int16(round(ObrazPOdctSTRUCTzigzag(i,j).blok)));
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:16
                if proba(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=0;
                else
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=1;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        slownik(i,j).blok=(int8(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end

for i=1:1:m1
    for j=1:1:n1
compres=nonzeros(proba(i,j).blok);
compresed1(i,j).bbl=compres';
    end
end
function [output,slownik,hh,hh2]=dct4x4IIint8(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end
x=63+PK;
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:16
                if abs(ObrazPOdctSTRUCTzigzag(i,j).blok(k,l))<x
                    ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=(ObrazPOdctSTRUCTzigzag(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:16
                if proba(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=0;
                else
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=1;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        slownik(i,j).blok=(int8(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end

for i=1:1:m1
    for j=1:1:n1
        compres=nonzeros(proba(i,j).blok);
        compresed1(i,j).bbl=compres';
    end
end
%%%%tutaj ma wejsc%%%%%%

for i=1:1:m1
    for j=1:1:n1
        h(i,j)=min(compresed1(i,j).bbl);
        h2(i,j)=max(compresed1(i,j).bbl);
    end
end

hh=min(min(h));
hh2=max(max(h2));

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(compresed1(i,j).bbl)
                output(i,j).blok(k,l)=uint8(round(((compresed1(i,j).bbl(k,l)-hh)/(hh2-hh))*255));
            end
        end
    end
end

function [compresed1,slownik]=dct16x16IIint16(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end
x=63+PK;
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:256
                if abs(ObrazPOdctSTRUCTzigzag(i,j).blok(k,l))<x
                    ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=(int16(round(ObrazPOdctSTRUCTzigzag(i,j).blok)));
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:256
                if proba(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=0;
                else
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=1;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        slownik(i,j).blok=(int8(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end

for i=1:1:m1
    for j=1:1:n1
compres=nonzeros(proba(i,j).blok);
compresed1(i,j).bbl=compres';
    end
end
function [output,slownik,hh,hh2]=dct16x16IIint8(in,m1,n1,PK)

for i=1:1:m1
    for j=1:1:n1
        S(i,j).block=dct2(in(i,j).block);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTzigzag(i,j).blok=zigzag(S(i,j).block);
    end
end
x=63+PK;
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:256
                if abs(ObrazPOdctSTRUCTzigzag(i,j).blok(k,l))<x
                    ObrazPOdctSTRUCTzigzag(i,j).blok(k,l)=0;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        proba(i,j).blok=(ObrazPOdctSTRUCTzigzag(i,j).blok);
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:256
                if proba(i,j).blok(k,l)==0
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=0;
                else
                    ObrazPOdctSTRUCTzigzag1(i,j).blok(k,l)=1;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        slownik(i,j).blok=(int8(ObrazPOdctSTRUCTzigzag1(i,j).blok));
    end
end

for i=1:1:m1
    for j=1:1:n1
compres=nonzeros(proba(i,j).blok);
compresed1(i,j).bbl=compres';
    end
end

for i=1:1:m1
    for j=1:1:n1
        h(i,j)=min(compresed1(i,j).bbl);
        h2(i,j)=max(compresed1(i,j).bbl);
    end
end

hh=min(min(h));
hh2=max(max(h2));

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(compresed1(i,j).bbl)
                output(i,j).blok(k,l)=uint8(round(((compresed1(i,j).bbl(k,l)-hh)/(hh2-hh))*255));
            end
        end
    end
end

%%%%%%%%%%%%%%%%   IDCT II SPOSOB   %%%%%%%%%%%%%%%%%

function output=idct4x4II(in,m1,n1,slownik)

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            h=1;
            for l=1:1:16
                if slownik(i,j).blok(k,l)==1
                    ODT(i,j).blok(k,l)=in(i,j).bbl(k,h);
                    h=h+1;
                else
                    ODT(i,j).blok(k,l)=0;
                end
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
       proba(i,j).blok=double(ODT(i,j).blok);
    end
end


for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,4,4);
    end
end

for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end

output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));
function output=idct4x4IIint8(in,m1,n1,slownik,hh,hh2)

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(in(i,j).blok)
                y(i,j).blok(k,l)=double(in(i,j).blok(k,l));
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(y(i,j).blok)
                ry(i,j).blok(k,l)=((y(i,j).blok(k,l)*(hh2-hh))/255)+hh;
            end
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            h=1;
            for l=1:1:16
                if slownik(i,j).blok(k,l)==1
                    ODT(i,j).blok(k,l)=ry(i,j).blok(k,h);
                    h=h+1;
                else
                    ODT(i,j).blok(k,l)=0;
                end
            end
        end
    end
end
for i=1:1:m1
    for j=1:1:n1
       proba(i,j).blok=double(ODT(i,j).blok);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,4,4);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end
output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));

function output=idct8x8II(in,m1,n1,slownik)
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            h=1;
            for l=1:1:64
                if slownik(i,j).blok(k,l)==1
                    ODT(i,j).blok(k,l)=in(i,j).bbl(k,h);
                    h=h+1;
                else
                    ODT(i,j).blok(k,l)=0;
                end
            end
        end
    end
end
for i=1:1:m1
    for j=1:1:n1
       proba(i,j).blok=double(ODT(i,j).blok);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,8,8);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end
output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));
function output=idct8x8IIint8(in,m1,n1,slownik,hh,hh2)

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(in(i,j).blok)
                y(i,j).blok(k,l)=double(in(i,j).blok(k,l));
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(y(i,j).blok)
                ry(i,j).blok(k,l)=((y(i,j).blok(k,l)*(hh2-hh))/255)+hh;
            end
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            h=1;
            for l=1:1:64
                if slownik(i,j).blok(k,l)==1
                    ODT(i,j).blok(k,l)=ry(i,j).blok(k,h);
                    h=h+1;
                else
                    ODT(i,j).blok(k,l)=0;
                end
            end
        end
    end
end
for i=1:1:m1
    for j=1:1:n1
       proba(i,j).blok=double(ODT(i,j).blok);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,8,8);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end
output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));

function output=idct16x16II(in,m1,n1,slownik)
for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            h=1;
            for l=1:1:256
                if slownik(i,j).blok(k,l)==1
                    ODT(i,j).blok(k,l)=in(i,j).bbl(k,h);
                    h=h+1;
                else
                    ODT(i,j).blok(k,l)=0;
                end
            end
        end
    end
end
for i=1:1:m1
    for j=1:1:n1
       proba(i,j).blok=double(ODT(i,j).blok);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,16,16);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end
output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));
function output=idct16x16IIint8(in,m1,n1,slownik,hh,hh2)

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(in(i,j).blok)
                y(i,j).blok(k,l)=double(in(i,j).blok(k,l));
            end
        end
    end
end

for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            for l=1:1:length(y(i,j).blok)
                ry(i,j).blok(k,l)=((y(i,j).blok(k,l)*(hh2-hh))/255)+hh;
            end
        end
    end
end


for i=1:1:m1
    for j=1:1:n1
        for k=1:1
            h=1;
            for l=1:1:256
                if slownik(i,j).blok(k,l)==1
                    ODT(i,j).blok(k,l)=ry(i,j).blok(k,h);
                    h=h+1;
                else
                    ODT(i,j).blok(k,l)=0;
                end
            end
        end
    end
end
for i=1:1:m1
    for j=1:1:n1
       proba(i,j).blok=double(ODT(i,j).blok);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctSTRUCTdecom(i,j).blok=izigzag(proba(i,j).blok,16,16);
    end
end
for i=1:1:m1
    for j=1:1:n1
        ObrazPOdctdecom(i,j).block=idct2(ObrazPOdctSTRUCTdecom(i,j).blok);
    end
end
output = cell2mat(reshape({ObrazPOdctdecom.block},size(ObrazPOdctdecom)));

%%%%%%%%%%%%%%%%%%%%%%   DWT   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output,lengc,s,falka,hh,hh2]=DWTint8(ObrazORG,level,falka,PK)
[c,s] = wavedec2(ObrazORG,level,falka);
lengc=length(c);
x1=(PK*(-100)/61)/100;
s=int16(s);

for i=length(c):-1:length(c)*x1
   c(i)=1233321; 
end

for i=1:1:length(c)
   if c(i)~=1233321
       c1(i)=c(i);
   end
end

hh=min(c1);
hh2=max(c1);
for l=1:1:length(c1)
    output(l)=uint8(round(((c(l)-hh)/(hh2-hh))*255));
end

function [output,lengc,s,falka]=DWTint16(ObrazORG,level,falka,PK)
[c,s] = wavedec2(ObrazORG,level,falka);
lengc=length(c);
x1=(PK*(-100)/61)/100;
s=int16(s);

for i=length(c):-1:length(c)*x1
   c(i)=1233321; 
end

for i=1:1:length(c)
   if c(i)~=1233321
       c1(i)=c(i);
   end
end

output=int16(ceil(c1));


%%%%%%%%%%%%%%%%%%%%%   IDWT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output=IDWT(in,lengc,s,falka)
zera=zeros(1,(lengc-length(in)));
zlozenie=[in,zera];
output=waverec2(double(zlozenie),double(s),falka);
function output=IDWTint8(in,lengc,s,falka,hh,hh2)

for l=1:1:length(in)
    y(l)=double(in(l));
end

for l=1:1:length(y)
    ry(l)=((y(l)*(hh2-hh))/255)+hh;
end
zera=zeros(1,(lengc-length(ry)));
zlozenie=[ry,zera];
output=waverec2(double(zlozenie),double(s),falka);
%%%%%%%%%%%%%%%%%%%%%   ZIG-ZAG    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = zigzag(in)
% initializing the variables
%----------------------------------
h = 1;
v = 1;
vmin = 1;
hmin = 1;
vmax = size(in, 1);
hmax = size(in, 2);
i = 1;
output = zeros(1, vmax * hmax);
%----------------------------------
while ((v <= vmax) && (h <= hmax))
    
    if (mod(h + v, 2) == 0)                 % going up
        if (v == vmin)
            output(i) = in(v, h);        % if we got to the first line
            if (h == hmax)
                v = v + 1;
            else
                h = h + 1;
            end
            i = i + 1;
        elseif ((h == hmax) && (v < vmax))   % if we got to the last column
            output(i) = in(v, h);
            v = v + 1;
            i = i + 1;
        elseif ((v > vmin) && (h < hmax))    % all other cases
            output(i) = in(v, h);
            v = v - 1;
            h = h + 1;
            i = i + 1;
        end
        
    else                                    % going down
        if ((v == vmax) && (h <= hmax))       % if we got to the last line
            output(i) = in(v, h);
            h = h + 1;
            i = i + 1;
            
        elseif (h == hmin)                   % if we got to the first column
            output(i) = in(v, h);
            if (v == vmax)
                h = h + 1;
            else
                v = v + 1;
            end
            i = i + 1;
        elseif ((v < vmax) && (h > hmin))     % all other cases
            output(i) = in(v, h);
            v = v + 1;
            h = h - 1;
            i = i + 1;
        end
    end
    if ((v == vmax) && (h == hmax))          % bottom right element
        output(i) = in(v, h);
        break
    end
end

%%%%%%%%%%%%%%%%%%%%%   IZIG-ZAG    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = izigzag(in, vmax, hmax) %%% to (vmax x hmax) matrix.
% initializing the variables
%----------------------------------
h = 1;
v = 1;
vmin = 1;
hmin = 1;
output = zeros(vmax, hmax);
i = 1;
%----------------------------------
while ((v <= vmax) && (h <= hmax))
    if (mod(h + v, 2) == 0)                % going up
        if (v == vmin)
            output(v, h) = in(i);
            if (h == hmax)
                v = v + 1;
            else
                h = h + 1;
            end
            i = i + 1;
        elseif ((h == hmax) && (v < vmax))
            output(v, h) = in(i);
            i;
            v = v + 1;
            i = i + 1;
        elseif ((v > vmin) && (h < hmax))
            output(v, h) = in(i);
            v = v - 1;
            h = h + 1;
            i = i + 1;
        end
        
    else                                   % going down
        if ((v == vmax) && (h <= hmax))
            output(v, h) = in(i);
            h = h + 1;
            i = i + 1;
            
        elseif (h == hmin)
            output(v, h) = in(i);
            if (v == vmax)
                h = h + 1;
            else
                v = v + 1;
            end
            i = i + 1;
        elseif ((v < vmax) && (h > hmin))
            output(v, h) = in(i);
            v = v + 1;
            h = h - 1;
            i = i + 1;
        end
    end
    if ((v == vmax) && (h == hmax))
        output(v, h) = in(i);
        break
    end
end
