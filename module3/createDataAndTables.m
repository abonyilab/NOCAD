%  The algorithm was implemented by Daniel Leitold 

% Add the modules
mfilepath=fileparts(which('createDataAndTables'));
addpath(fullfile(mfilepath,'../module1'));
addpath(fullfile(mfilepath,'../module2'));

% Querying existing network files
files=dir('networks\*.mat');
numOfNetworks=length(files);

% Check the directory: data
if exist('data', 'dir')==0
    mkdir('data');
end

% Check the directory: tables
if exist('tables', 'dir')==0
    mkdir('tables');
end

% Set calculated measures
mesConfig=getConfig();

% Comparison tables
tab=genCol(0,'');
tabLoop=tab;
tabSym=tab;
tabSymLoop=tab;

for idxI=1:numOfNetworks
    % Get the name of network
    [~,network,~]=fileparts(files(idxI).name);
    
    % Process message
    fprintf('%d/%d - %s, Running...\n',idxI,numOfNetworks, network);
    
    networkLoop=strcat(network, 'Loop');
    networkSym=strcat(network, 'Sym');
    networkSymLoop=strcat(network, 'SymLoop');
    
    % Loading the adjacency matrix
    load(strcat('networks\', files(idxI).name));
    
    % Rename then clear the matrix
    eval(sprintf('adj=%s;', network));
    eval(sprintf('clear %s;', network));
    
    %% Influence %%
    
    % Mapping the system
    [Am,Bm,Cm,Dm]=generateMatricesPF(adj);
    
    % Generate data
    eval(sprintf('%s=matricesToStruct(Am,Bm,Cm,Dm,mesConfig);', network));
    % Add row to the table
    eval(sprintf('tab=[tab, genCol(%s,network)];', network));
    
    % Save data
    save(strcat('data/', network, '.mat'), network);
    eval(sprintf('clear %s;', network));
    
    %% Self-affected influence %%
    
    % Change the network
    adjLoop=+(adj|speye(length(adj)));
    
    % Mapping the system
    [Am,Bm,Cm,Dm]=generateMatricesPF(adjLoop);
    
    % Generate data
    eval(sprintf('%s=matricesToStruct(Am,Bm,Cm,Dm,mesConfig);',networkLoop));
    % Add row to the table
    eval(sprintf('tabLoop=[tabLoop, genCol(%s,networkLoop)];', networkLoop));
    
    % Save data
    save(strcat('data/', networkLoop, '.mat'), networkLoop);
    eval(sprintf('clear %s;', networkLoop));
    
    %% Interaction %%
    
    % Change the network
    adjSym=+(adj|adj');
    
    % Mapping the system
    [Am,Bm,Cm,Dm]=generateMatricesPF(adjSym);
    
    % Generate data
    eval(sprintf('%s=matricesToStruct(Am,Bm,Cm,Dm,mesConfig);', networkSym));
    % Add row to the table
    eval(sprintf('tabSym=[tabSym, genCol(%s,networkSym)];', networkSym));
    
    % Save data
    save(strcat('data/', networkSym, '.mat'), networkSym);
    eval(sprintf('clear %s;', networkSym));
    
    %% Self-affected interaction %%
    
    % Change the network
    adjSymLoop=+(adj|speye(length(adj))|adj');
    
    % Mapping the system
    [Am,Bm,Cm,Dm]=generateMatricesPF(adjSymLoop);
    
    % Generate data
    eval(sprintf('%s=matricesToStruct(Am,Bm,Cm,Dm,mesConfig);', ...
        networkSymLoop));
    % Add row to the table
    eval(sprintf('tabSymLoop=[tabSymLoop, genCol(%s,networkSymLoop)];',...
        networkSymLoop));
    
    % Save data
    save(strcat('data/', networkSymLoop, '.mat'), networkSymLoop);
    eval(sprintf('clear %s;', networkSymLoop));
    
end

%% Save .mat and .xlsx and clear tables
xlswrite('tables/tab.xlsx',tab);
save('tables/tab.mat', 'tab');
clear tab;
xlswrite('tables/tabLoop.xlsx',tabLoop)
save('tables/tabLoop.mat', 'tabLoop')
clear tabLoop;
xlswrite('tables/tabSym.xlsx',tabSym)
save('tables/tabSym.mat', 'tabSym')
clear tabSym;
xlswrite('tables/tabSymLoop.xlsx',tabSymLoop)
save('tables/tabSymLoop.mat', 'tabSymLoop')
clear tabSymLoop;

%% Clear variables
clear files;
clear numOfNetworks;
clear mesConfig;
clear network;
clear networkLoop;
clear networkSym;
clear networkSymLoop;
clear adj;
clear adjLoop;
clear adjSym;
clear adjSymLoop;
clear Am;
clear Bm;
clear Cm;
clear Dm;
clear idxI;

disp('Done.')