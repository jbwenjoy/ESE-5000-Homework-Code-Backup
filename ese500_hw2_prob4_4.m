%% Prob 4-3

clear;
clc;

A = [-0.313 0 56.7; 0 0 56.7; -0.0139 0 -0.426];
B = [0.232; 0; 0.0203];
C = [0 1 0];
D = 0;

x0 = [0; 0; 0];
delta = 0.2;
t_max = 10;
t_span = [0, t_max];

sys = ss(A,B,C,D);
sys_c_func = @(t, x, u) A * x + B * u;

[t_result, x_result] = ode45(@(t, x) sys_c_func(t, x, delta), t_span, x0);
x_result = x_result';
y_result = C * x_result;

plot(t_result, y_result, '-o');
hold on;


%% Prob 4-4

Ts_arr = [0.01, 0.1, 0.5, 1, 2, 5, 10];
u = delta;

for i = 1:7  % for every Ts
    sysd = c2d(sys, Ts_arr(i));
    t_arr = 0:Ts_arr(i):t_max;
    u_arr = delta * ones(size(t_arr));
    t_result = t_arr;
    y_result = zeros(1,length(t_result));
    x_cur = x0;
    for k = 1:length(t_result)
        % x_next = sysd.A * x_cur + sysd.B * u;
        % y_next = sysd.C * x_next;
        % x_cur = x_next;
        % y_result(k) = y_next;
        [y_result, t_result] = lsim(sysd, u_arr, t_arr);
    end

    plot(t_result, y_result);
    hold on;
end

title("System Output");
xlabel("Time (sec)");
ylabel("y");
legend({"Cont", "Ts = 0.01", "Ts = 0.1", "Ts = 0.5", "Ts = 1.0", "Ts = 2.0", "Ts = 5.0", "Ts = 10"}, 'Location','southeast');
hold off;
