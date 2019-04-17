

adj=[
0 1 0 0 0 0 0 0 0;
1 0 1 0 0 0 0 0 0;
1 0 0 0 0 0 0 0 0;
0 1 0 0 1 1 1 0 0;
0 1 0 1 0 0 1 0 0;
0 0 0 1 0 0 1 0 0;
0 0 0 0 0 0 0 0 1;
0 0 0 0 0 1 0 0 0;
0 0 0 0 0 0 0 0 0];

addpath('module1\');
addpath('module2\');
if ~exist('generateMatricesPF', 'file')
   mfilepath=fileparts(which('toolboxExample'));
   addpath([mfilepath,'\module1']);
end
if ~exist('matricesToStruct', 'file')
   mfilepath=fileparts(which('toolboxExample'));
   addpath([mfilepath,'\module2']);
end
if ~exist('extendData', 'file')
   mfilepath=fileparts(which('toolboxExample'));
   addpath([mfilepath,'\module3']);
end

mesConfig = getConfig();
targetDegree = 2;
alphaPar = 0.5;

% module 1
[A,B,C,D] = generateMatricesPF(adj);
% module 2
data = matricesToStruct(A, B, C, D, mesConfig);
% module 3
data = extendData(data, targetDegree, alphaPar);
data = robust(data);