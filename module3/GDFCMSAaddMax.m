function [ res ] = GDFCMSAaddMax(A, addMax, Niter, Nf)
%GDFCMSAADDMAX places addMax additional driver nodes for adjacency matrix
% A, or addMax additional sensor nodes for state-transition matrix A. The
% method generates the necessary driver (sensor) nodes then expand by 
% addMax new drvier (sensor). The method uses simulated annealing that runs
% Niter times, and the simulated anneling runs Nf times independently. 
% For more information: Sensors, 18(9), 3096.
% The function returns the best set of driver (or sensor) nodes.
% ##################
% Example:
% ##################
% Inputs: 
%
% A = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% addMax = 1;
% Niter = 500;
% Nf = 10;
% ##################
% Function Calling:
% 
% [ res ] = GDFCMSAaddMax(A, addMax, Niter, Nf);
% ##################
% Output:
%
% res =
%      1     3
% ##################
%  The algorithm was implemented by Janos Abonyi and Daniel Leitold 

if ~exist('allShortestPaths', 'file')
   mfilepath=fileparts(which('GDFCMSAaddMax'));
   addpath([mfilepath,'\..\module2']);
end


%% Declare result
res = [];

%% Parameters of simulated annealing
alpha = 0.5;
Tmax=10;
Tmin=1e-2;
tau=(Tmin/Tmax)^(1/Niter);

%% Parameters of fuzzy-c clustering
mmax=10;
mmin=2;
taum=(mmin/mmax)^(1/Niter);

res.N = length(A);

%% Calculate the distance matrix
% row: from, column: to 
N=length(A);
Dmat=allShortestPaths(A);
Dmat(Dmat==Inf) = N; %replace with the max distance (just for numerical ..)

Df=min(Dmat,Dmat'); %when we modify we are also interested how this not is reachable 

%% ensure robustness and calculate the initial cost function
[sensors] = getSensors(A);
tic();
[cost, maxOrd, sumOrd] = getCost(sensors, alpha, Dmat);
tim = toc();
K=length(sensors);

%% set of forbidden states
fs=find(sum(Dmat==N,2)>=(N-2));

% number of  necessary sensors
res.K = K;
% initialise with Kp = 0
res.Kp = 0;
res.costv = repmat(cost, Nf,1);
res.maxv = repmat(maxOrd, Nf,1);
res.meanv = repmat(sumOrd, Nf,1);
res.nodes = repmat({sensors}, Nf,1);
res.timev = repmat(tim, Nf,1);

for Kp = 1:addMax
    res.Kp = cat(2, res.Kp, Kp);
    Ns=K+Kp;  %the number of sensors (including the total ...

    %% Do the clustering
    costv = [];
    maxv = [];
    meanv = [];
    allSen = [];
    timev = [];
    for f=1:Nf
        tic()
        T=Tmax;
        m=mmax;
        Nso=length(sensors); %number of sensors required for obs.
        if Ns+length(fs) > N
            % if no remaining nodes, then forbidden nodes become enabled
            allSensors = randperm(N,N);
            allSensors=setdiff(allSensors,sensors);
            allSensors=[sensors allSensors(1:(Ns-Nso))];
        else
            allSensors = randperm(N,Ns+length(fs)); %just for safety
            allSensors=setdiff(allSensors,[sensors fs']);
            allSensors=[sensors allSensors(1:(Ns-Nso))];
        end
        [cost, maxOrd, sumOrd] = getCost(allSensors, alpha,Dmat);

        for k=1:Niter
            selsensor=randperm(Kp,1);        %randomly select a "medoid"/sensor
            selstate=randperm(N,1);          %random select state for swapping / base-line 

            % fuzzy mem-based selection of the state 
            dists = Df(allSensors, :);
            dum1 = 1./((dists+0.0001)).^(2/(m-1));
            dum2 = (repmat(sum(dum1), size(dum1,1), 1));
            mu = dum1./dum2; %this is the membership value
            memc = mu(selsensor+K,:);
            Pn=cumsum(memc)/sum(memc);
            selstate = find(rand<Pn,1);

            %swap
            testSensors = allSensors;
            testSensors(selsensor+K) = selstate;

            %evaluate the cost 
            [costnew, maxOrd, sumOrd] = getCost(testSensors, alpha,Dmat);

            %accept if it is better 
            if costnew <= cost
                allSensors = testSensors;
                cost = costnew;
            else %SA accept worse - with a probability ...
                delta = costnew-cost; %when we are here, delta is positive
                tr = exp(-delta/T);
                if rand < tr %the prob of accepting worse is decreasing
                    allSensors = testSensors;
                    cost = costnew;
                end
            end
            T = tau*T;
            m = taum*m;
        end
        [costv(f), maxv(f), meanv(f)] = getCost(allSensors, alpha, Dmat);
        allSen = cat(1, allSen, {allSensors});
        timev(f) = toc();
    end
    if isrow(costv)
        costv = costv';
        maxv = maxv';
        meanv = meanv';
        timev = timev';
    end         
    res.costv = cat(2, res.costv, costv);
    res.maxv = cat(2, res.maxv, maxv);
    res.meanv = cat(2, res.meanv, meanv);
    res.nodes = cat(2, res.nodes, allSen);
    res.timev = cat(2, res.timev, timev);
    
end
% Choose best solution
[~, idx] = min(res.costv(:,end));
res = res.nodes{idx, end};
end