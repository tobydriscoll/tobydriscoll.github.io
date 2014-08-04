function fsout = font(arg)
% FONT  Command window font size
%    font displays the font size
%    font + increases the font size
%    font - decreases the font size
%    font fs sets the font size
%    font(fs) sets the font size
%    fs = font gets the current font size

%if nargin < 1 || isequal(arg,'+') || isequal(arg,'-')
  s = char(com.mathworks.services.FontPrefs.getCodeFont);
  if s(end-2) == '='
     fs = round(.75*str2num(s(end-1)));
  else
     fs = round(.75*str2num(s(end-2:end-1)));
  end
  fn = regexp( s, 'family=([\w\s]*),','tokens');
  fn = fn{1}{1};
  if isempty(strfind(s,'style=bold'))
    wt = java.awt.Font.PLAIN; 
  else
    wt = java.awt.Font.BOLD;
  end
  
%end

if nargin == 1
  if isequal(arg,'+')
     fs = fs+1;
  elseif isequal(arg,'-')
     fs = fs-1;
  elseif isequal(arg,'bold')
     wt = java.awt.Font.BOLD;
  elseif isequal(arg,'plain') || isequal(arg,'normal') 
     wt = java.awt.Font.PLAIN;
  elseif ischar(arg)
     fs = str2num(arg);
  else
     fs = arg;
  end
end

if nargout == 1
  fsout = fs;
else
  if nargin==0
    fprintf('\n  fontsize = %d\n',fs)
  else
    fs = round(4/3*fs);
    com.mathworks.services.FontPrefs.setCodeFont( ...
      java.awt.Font(fn,wt,fs))
    com.mathworks.services.FontPrefs.setTextFont( ...
      java.awt.Font('SansSerif',java.awt.Font.PLAIN,fs))
  end
end