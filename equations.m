clc
clear all

%% System states and inputs
% States:
syms Vrel lce Te Ve

% Inputs:
syms STIM

%% Constants
syms width Marm Llarm Fmax lse_0

a = 1/(width^2);
Iarm = Marm*(Llarm^2)/3;
kse = Fmax/((0.04*lse_0)^2);
%% X1: Vrel
syms m 

% X1_dot
Vrel_dot = m*(STIM-Vrel);

%% X2: lce
syms a0 a1e a2e lce_opt c u k q0 arel brel

lmtc = a0 + (a1e*Te) + (a2e*(Te^2));

lse = lmtc - lce;

Fmtc = kse*(lse-lse_0)^2;

lce_rel = lce/lce_opt;

rho = c*u*(k-1)/(k-lce_rel)*lce_rel;

q = (q0 + (rho*Vrel)^3)/(1 + (rho*Vrel)^3);

Fisom_n = -a*(lce_rel^2) + 2*a*lce_rel - a + 1;
Fce_rel = Fmtc/Fmax;

A = 1/(1+exp(-100*(lce_rel-1)));
B = 1/(1+exp(100*(lce_rel-1)));
arel_dot = arel*Fisom_n*(B*(1/Fisom_n) + A);
brel_dot = brel;

% X2_dot
Vce_rel = brel_dot*(Fce_rel - q*Fisom_n)/(Fce_rel + q*arel_dot);
lce_dot = Vce_rel*lce_opt;

%% X3: Te

% X3_dot
Te_dot = Ve;

%% X4: Ve
syms g Cload Kload Mload

arm = -a1e;
Torq_m = Fmtc * arm;
Torq_g = Marm*(Llarm/2*g)*sin(Te);
Torq_ext = Cload*Ve + Kload*Te + Mload*g*Llarm*sin(Te);

Ve_dot = (Torq_m + Torq_g + Torq_ext)/Iarm;

%% Assigning Constant Values:

m = 11.25;
arel = 0.41;
brel = 5.2;
lce_opt = 0.092;
lse_0 = 0.172;
Fmax = 1420;
q0 = 0.005;
c = 1.373e-4;
u = 52700;
k = 2.90;
width = 0.66;
a0 = 0.286;
a1e = -0.014;
a2e = -3.96e-3;

g = -9.8;
Marm = 2.5;
Llarm = 0.5;
Kload = -10;
Cload = -10;

%% Substituting for expressions:

Vrel_dot_exp = subs(Vrel_dot);
lce_dot_exp = subs(lce_dot);
Te_dot_exp = subs(Ve);
Ve_dot_exp = subs(Ve_dot);


