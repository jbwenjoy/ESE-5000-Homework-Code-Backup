%% init and setup
clear;
clc;

syms t
u = [1 - cos(t); sin(t)];
v = 1 - cos(t);
w = sin(t);
x0 = [0.0; 0.0; 0.0];
t_max = 10;
t_span = [0, t_max];

C = [1 0 0; 0 1 0; 0 0 0];
D = 0;

%% nonlinear models
% delta = 1
delta = 1.0;
nonli_sys_func1 = @(t,x) [0 delta * sin(t) 0; -delta * sin(t) 0 0; 0 0 0] * x + [1 0; 0 0; 0 1] * delta * [1 - cos(t); sin(t)];

[t_result11, x_result11] = ode45(@(t, x) nonli_sys_func1(t, x), t_span, x0);
y_result11 = C * x_result11';

% delta = 0.5
delta = 0.5;
nonli_sys_func2 = @(t,x) [0 delta * sin(t) 0; -delta * sin(t) 0 0; 0 0 0] * x + [1 0; 0 0; 0 1] * delta * [1 - cos(t); sin(t)];

[t_result12, x_result12] = ode45(@(t, x) nonli_sys_func2(t, x), t_span, x0);
y_result12 = C * x_result12';

% delta = 0.25
delta = 0.25;
nonli_sys_func3 = @(t,x) [0 delta * sin(t) 0; -delta * sin(t) 0 0; 0 0 0] * x + [1 0; 0 0; 0 1] * delta * [1 - cos(t); sin(t)];

[t_result13, x_result13] = ode45(@(t, x) nonli_sys_func3(t, x), t_span, x0);
y_result13 = C * x_result13';

%% linearized model in 5d
A_5d = [0 0 0; 0 0 0; 0 0 0];
B_5d = [1 0; 0 0; 0 1];

% delta = 1
delta = 1.0;
lin_sys_5d_func1 = @(t, x) A_5d * x + B_5d * delta * [1 - cos(t); sin(t)];
[t_result21, x_result21] = ode45(@(t, x) lin_sys_5d_func1(t, x), t_span, x0);
y_result21 = C * x_result21';

% delta = 0.5
delta = 0.5;
lin_sys_5d_func2 = @(t, x) A_5d * x + B_5d * delta * [1 - cos(t); sin(t)];
[t_result22, x_result22] = ode45(@(t, x) lin_sys_5d_func2(t, x), t_span, x0);
y_result22 = C * x_result22';

% delta = 0.25
delta = 0.25;
lin_sys_5d_func3 = @(t, x) A_5d * x + B_5d * delta * [1 - cos(t); sin(t)];
[t_result23, x_result23] = ode45(@(t, x) lin_sys_5d_func3(t, x), t_span, x0);
y_result23 = C * x_result23';

%% linearized model in 5f
A_5f = [0 1 0; -1 0 0; 0 0 0];
B_5f = [1 -1; 0 0; 0 1];
x_str = @(t) [0; -1; t];
u_str = [1; 1];

% delta = 1
delta = 1;
lin_sys_5f_func1 = @(t, x) A_5f * (x - x_str(t)) + B_5f * (delta * [1 - cos(t); sin(t)] - u_str);
[t_result31, x_result31] = ode45(@(t, x) lin_sys_5f_func1(t, x), t_span, x0);
y_result31 = C * x_result31';

% delta = 0.5
delta = 0.5;
lin_sys_5f_func2 = @(t, x) A_5f * (x - x_str(t)) + B_5f * (delta * [1 - cos(t); sin(t)] - u_str);
[t_result32, x_result32] = ode45(@(t, x) lin_sys_5f_func2(t, x), t_span, x0);
y_result32 = C * x_result32';

% delta = 0.25
delta = 0.25;
lin_sys_5f_func3 = @(t, x) A_5f * (x - x_str(t)) + B_5f * (delta * [1 - cos(t); sin(t)] - u_str);
[t_result33, x_result33] = ode45(@(t, x) lin_sys_5f_func3(t, x), t_span, x0);
y_result33 = C * x_result33';

% % delta = 1
% delta = 1;
% lin_sys_5f_func1 = @(t, x) A_5f * x + B_5f * delta * [1 - cos(t); sin(t)] + [1; 0; 0];
% [t_result31, x_result31] = ode45(@(t, x) lin_sys_5f_func1(t, x), t_span, x0);
% y_result31 = C * x_result31';
% 
% % delta = 0.5
% delta = 0.5;
% lin_sys_5f_func2 = @(t, x) A_5f * x + B_5f * delta * [1 - cos(t); sin(t)] + [1; 0; 0];
% [t_result32, x_result32] = ode45(@(t, x) lin_sys_5f_func2(t, x), t_span, x0);
% y_result32 = C * x_result32';
% 
% % delta = 0.25
% delta = 0.25;
% lin_sys_5f_func3 = @(t, x) A_5f * x + B_5f * delta * [1 - cos(t); sin(t)] + [1; 0; 0];
% [t_result33, x_result33] = ode45(@(t, x) lin_sys_5f_func3(t, x), t_span, x0);
% y_result33 = C * x_result33';

%% optional part

% x0 = [0; -1; 0];
% delta = 1;
% u = @(t) [1; 1] + delta * [1 - cos(t); sin(t)];


%% display
figure
% delta = 1.0 y1
subplot(2,3,1)
plot(t_result11, y_result11(1, :), '-o');
hold on;
plot(t_result21, y_result21(1, :), '-^');
hold on;
plot(t_result31, y_result31(1, :), '-x');
hold on;
legend({"Nonlinear", "5d) Linearized at (0, 0)", "5f) Linearized around traj"}, 'Location','northwest');
title("System Output y1 for delta = 1.0");
xlabel("Time (sec)");
ylabel("y1");
hold off;

% delta = 1.0 y2
subplot(2,3,4)
plot(t_result11, y_result11(2, :), '-o');
hold on;
plot(t_result21, y_result21(2, :), '-^');
hold on;
plot(t_result31, y_result31(2, :), '-x');
hold on;
legend({"Nonlinear", "5d) Linearized at (0, 0)", "5f) Linearized around traj"}, 'Location','northwest');
title("System Output y2 for delta = 1.0");
xlabel("Time (sec)");
ylabel("y2");
hold off;

% delta = 0.5 y1
subplot(2,3,2)
plot(t_result12, y_result12(1, :), '-o');
hold on;
plot(t_result22, y_result22(1, :), '-^');
hold on;
plot(t_result32, y_result32(1, :), '-x');
hold on;
legend({"Nonlinear", "5d) Linearized at (0, 0)", "5f) Linearized around traj"}, 'Location','northwest');
title("System Output y1 for delta = 0.5");
xlabel("Time (sec)");
ylabel("y1");
hold off;

% delta = 0.5 y2
subplot(2,3,5)
plot(t_result12, y_result12(2, :), '-o');
hold on;
plot(t_result22, y_result22(2, :), '-^');
hold on;
plot(t_result32, y_result32(2, :), '-x');
hold on;
legend({"Nonlinear", "5d) Linearized at (0, 0)", "5f) Linearized around traj"}, 'Location','northwest');
title("System Output y2 for delta = 0.5");
xlabel("Time (sec)");
ylabel("y2");
hold off;

% delta = 0.25 y1
subplot(2,3,3)
plot(t_result13, y_result13(1, :), '-o');
hold on;
plot(t_result23, y_result23(1, :), '-^');
hold on;
plot(t_result33, y_result33(1, :), '-x');
hold on;
legend({"Nonlinear", "5d) Linearized at (0, 0)", "5f) Linearized around traj"}, 'Location','northwest');
title("System Output y1 for delta = 0.25");
xlabel("Time (sec)");
ylabel("y1");
hold off;

% delta = 0.25 y2
subplot(2,3,6)
plot(t_result13, y_result13(2, :), '-o');
hold on;
plot(t_result23, y_result23(2, :), '-^');
hold on;
plot(t_result33, y_result33(2, :), '-x');
hold on;
legend({"Nonlinear", "5d) Linearized at (0, 0)", "5f) Linearized around traj"}, 'Location','northwest');
title("System Output y2 for delta = 0.25");
xlabel("Time (sec)");
ylabel("y2");
hold off;
