clear; clc; format long;

Ts = 0.01;
syms tau;
Atau = @(tau) [-0.313 0 56.7; 0 0 56.7; -0.0139 0 -0.426] * tau;
B=[0.232; 0; 0.0203];
[Qtau,Vtau] = eig(Atau(tau))  % Q is eigenvectors, V is eigenvalues
eVtau = expm(Vtau)
func = @(tau) Qtau * eVtau / Qtau;
q = int(func, tau, 0, Ts) * B;
B_d = double(q)

% q = integral(@(tau, Qtau, eVtau) func, 0, Ts, 'ArrayValued',true)

% A = [-0.313 0 56.7; 0 0 56.7; -0.0139 0 -0.426];
% B = [0.232; 0; 0.0203];
% C = [0 1 0];
% D = 0;
% Ts = 0.01;
% sys = ss(A, B, C, D)
% sysd = c2d(sys, Ts)
