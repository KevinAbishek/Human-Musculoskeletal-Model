clc
clear all
%% constants:

tstep = 0.0001;

%% Skeletal Dynamics

a0 = 0.286;
a1e = -0.014;
a2e = -3.96e-3;

ThetaInit = 0;
Llarm = 0.5;
%Marm = 2.52/100*73;
Marm = 2.5;
Iarm = Marm*(Llarm^2)/3;

%%
c = 1.373e-4;
u = 52700;
k = 2.90;
q0 = 0.005;
m = 11.25;

width = 0.66;
arel = 0.41;
brel = 5.2;
qcrit = 0.03;
a = 1/(width^2);
brel = 5.2;

%% Table 4.3B, pg 73, Kistemaker et al. 2006

% Selected muscle: MEF
lse_0 = 0.172; % Tendon natural length (m)
lce_opt = 0.092; % Optimal CE length (m)
lpe_0 = 1.4*lce_opt; % PE natural length (m)
%lpe_0 = 1*lce_opt; % PE natural length (m)
Fmax = 1420; % MVC value (N)

kse = Fmax/((0.04*lse_0)^2); % SE Stiffness (N/m)
kpe = (0.5*Fmax)/(1 + width - (lpe_0/lce_opt)); % PE Stiffness (N/m)

%% Muscle Kinematics & Kinetics initialization

lmtc_init = a0 + (a1e*ThetaInit) + (a2e*(ThetaInit^2));
lce_init = lmtc_init-lse_0;
