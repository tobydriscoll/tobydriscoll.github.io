function varargout = Fouriersummation(varargin)
% FOURIERSUMMATION M-file for Fouriersummation.fig
%      FOURIERSUMMATION, by itself, creates a new FOURIERSUMMATION or raises the existing
%      singleton*.
%
%      H = FOURIERSUMMATION returns the handle to a new FOURIERSUMMATION or the handle to
%      the existing singleton*.
%
%      FOURIERSUMMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIERSUMMATION.M with the given input arguments.
%
%      FOURIERSUMMATION('Property','Value',...) creates a new FOURIERSUMMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fouriersummation_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fouriersummation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fouriersummation

% Last Modified by GUIDE v2.5 06-Feb-2006 21:25:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fouriersummation_OpeningFcn, ...
                   'gui_OutputFcn',  @Fouriersummation_OutputFcn, ...
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

end

% --- Executes just before Fouriersummation is made visible.
function Fouriersummation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fouriersummation (see VARARGIN)

% Choose default command line output for Fouriersummation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fouriersummation wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = Fouriersummation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function EditFunction_Callback(hObject, eventdata, handles)
% hObject    handle to EditFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditFunction as text
%        str2double(get(hObject,'String')) returns contents of EditFunction as a double
end

% --- Executes during object creation, after setting all properties.
function EditFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function EditA0_Callback(hObject, eventdata, handles)
% hObject    handle to EditA0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditA0 as text
%        str2double(get(hObject,'String')) returns contents of EditA0 as a double
end

% --- Executes during object creation, after setting all properties.
function EditA0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditA0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function EditAN_Callback(hObject, eventdata, handles)
% hObject    handle to EditAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditAN as text
%        str2double(get(hObject,'String')) returns contents of EditAN as a double
end

% --- Executes during object creation, after setting all properties.
function EditAN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function EditBN_Callback(hObject, eventdata, handles)
% hObject    handle to EditBN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBN as text
%        str2double(get(hObject,'String')) returns contents of EditBN as a double
end

% --- Executes during object creation, after setting all properties.
function EditBN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function EditN_Callback(hObject, eventdata, handles)
% hObject    handle to EditN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditN as text
%        str2double(get(hObject,'String')) returns contents of EditN as a double
end

% --- Executes during object creation, after setting all properties.
function EditN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function EditXMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditXMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXMin as text
%        str2double(get(hObject,'String')) returns contents of EditXMin as a double
end

% --- Executes during object creation, after setting all properties.
function EditXMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function EditXMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditXMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXMax as text
%        str2double(get(hObject,'String')) returns contents of EditXMax as a double
end

% --- Executes during object creation, after setting all properties.
function EditXMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in ButtonGo.
function ButtonGo_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

interval(1) = str2num(get(handles.EditXMin,'string'));
interval(2) = str2num(get(handles.EditXMax,'string'));
f = inline( get(handles.EditFunction,'string'), 'x' );
a0 = str2num( get(handles.EditA0,'string') );
an = vectorize( inline( get(handles.EditAN,'string'), 'n' ) );
bn = vectorize( inline( get(handles.EditBN,'string'), 'n' ) );
N = str2num( get(handles.EditN,'string') );

figure
subplot(2,1,1)
fplot(@fouriersum,interval)
title(sprintf('f(x) = %s, N = %i terms',get(handles.EditFunction,'string'),N))
subplot(2,1,2)
fplot(@fouriersumerr,interval)
title('Error')

  function fN = fouriersum(x)
    n = 1:N;
    fN = a0 + sum( an(n).*cos(pi*n*x) + bn(n).*sin(pi*n*x) );
  end
  
  function err = fouriersumerr(x)
    err = fouriersum(x) - f(x);
  end
end
