t1=2; t2=10; t3=1.5; t4=4.2; t5=6.5; t6=1.7; t7=9;
s1=64; s2=98; s3=62; s4=70; s5=63; s6=70; s7=85;
y = [s1; s2; s3; s4; s5; s6; s7];

A=[1 t1 t1^2 t1^3; 1 t2 t2^2 t2^3; 1 t3 t3^2 t3^3; 1 t4 t4^2 t4^3; 1 t5 t5^2 t5^3; 1 t6 t6^2 t6^3; 1 t7 t7^2 t7^3]
rank(A)

x=lsqr(A, y, 1e-6, 1000)

T = linspace(1, 10, 100);
S = x(4)*T.^3 + x(3)*T.^2+x(2)*T + x(1);
TT=[t1 t2 t3 t4 t5 t6 t7];
SS=[s1 s2 s3 s4 s5 s6 s7];

plot(T,S)
hold on
scatter(TT,SS)
xlabel("Time (hours)")
ylabel("Test Score")
legend('Polynomial', 'Recorded Data')
