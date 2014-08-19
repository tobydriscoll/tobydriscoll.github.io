function varargout = heatdemo(varargin)
% HEATDEMO M-file for heatdemo.fig
%      HEATDEMO, by itself, creates a new HEATDEMO or raises the existing
%      singleton*.
%
%      H = HEATDEMO returns the handle to a new HEATDEMO or the handle to
%      the existing singleton*.
%
%      HEATDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HEATDEMO.M with the given input arguments.
%
%      HEATDEMO('Property','Value',...) creates a new HEATDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before heatdemo_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to heatdemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help heatdemo

% Last Modified by GUIDE v2.5 27-Feb-2006 07:30:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @heatdemo_OpeningFcn, ...
                   'gui_OutputFcn',  @heatdemo_OutputFcn, ...
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


% --- Executes just before heatdemo is made visible.
function heatdemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to heatdemo (see VARARGIN)

% Choose default command line output for heatdemo
handles.output = hObject;

x = linspace(0,1,250)';
f = @(x) exp(3*sin(2*x)-cos(3*x));
v = @(x) f(1)*x + f(0)*(1-x);
for n = 1:12
  b(n) = quadl( @(x) (f(x)-v(x)).*sin(n*pi*x),0,1,1e-7);
end
axes(handles.AxesSolution)
u=plot(x,f(x));
axis tight
axlim = axis;
axis(axlim)
axes(handles.AxesSteady)
plot(x,v(x))
axis tight
axis(axlim)
axes(handles.AxesTransient)
w=plot(x,f(x)-v(x));
axis tight
axlim2 = axis;
axis(axlim2)
axes(handles.AxesFourier)
S = sin(pi*x*(1:12))*diag(b);
w_hat=plot(x,S);
axis tight, axis off
axis(axis)

handles.u = u;
handles.w = w;
handles.w_hat = w_hat;
handles.x = x;
handles.f = f;
handles.v = v;
handles.b = b;
handles.S = S;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = heatdemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function SliderT_Callback(hObject, eventdata, handles)
% hObject    handle to SliderT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

t = get(hObject,'value')/24;
St = handles.S*diag(exp(-pi^2*(1:12).^2*t));
for n = 1:12
  set(handles.w_hat(n),'ydata',St(:,n))
end
wt = sum(St,2);
set(handles.w,'ydata',wt)
v0 = handles.v(handles.x);
set(handles.u,'ydata',v0+wt)
drawnow

% --- Executes during object creation, after setting all properties.
function SliderT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SliderT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


