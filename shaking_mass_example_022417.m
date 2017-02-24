function shaking_mass_example_022417

clear;
close all;

% Properties
global m c k w;
m = 1;
c = 2;
k = 1;
w = 1;

% Initial Conditions
x0 = 0;
xdot0 = 0;
X0 = [x0;xdot0];
t0 = 0;
tf = 10;
dt = 0.1;
tspan = t0:dt:tf;

% Differential Equation
[~, X] = ode45(@shaking_mass_fun, tspan, X0);
X = X';
[~, X1] = ode45(@shaking_mass_fun_1, tspan, X0);
X1 = X1';
[~, X2] = ode45(@shaking_mass_fun_2, tspan, X0);
X2 = X2';
X12 = X1+X2;

% Analyze Data
numpts = numel(tspan);
x = zeros(1,numpts);
xdot = x;
x12 = x;
for i = 1:numpts
    x(i) = X(1,i);
    xdot(i) = X(2,i);
    
    x12(i) = X12(1,i);
end

% Plotting
figure(1);
subplot(2,1,1);
plot(tspan, x);
xlabel('Time (sec)');
ylabel('x (m)');

subplot(2,1,2);
plot(tspan, xdot);
xlabel('Time (sec)');
ylabel('xdot (m/s)');

figure(2);
plot(tspan, x, 'b-', tspan, x12, 'r-');
xlabel('Time (sec)');
ylabel('x (m) with numerical error');
legend('Single EOM', 'Different EOMs')

end


function Xdot = shaking_mass_fun(t, X)
global c m k;
x = X(1);
xdot = X(2);

xddot = 1/m*time_fun_1(t)+1/m*time_fun_2(t)-c/m*xdot-k/m*x;

Xdot = [xdot;xddot];
end

function Xdot = shaking_mass_fun_1(t, X)
global c m k;
x = X(1);
xdot = X(2);

xddot = 1/m*time_fun_1(t)-c/m*xdot-k/m*x;

Xdot = [xdot;xddot];
end

function Xdot = shaking_mass_fun_2(t, X)
global c m k;
x = X(1);
xdot = X(2);

xddot = 1/m*time_fun_2(t)-c/m*xdot-k/m*x;

Xdot = [xdot;xddot];
end

function fun_out = time_fun_1(t)
global w;
if t < 11
    fun_out = cos(w*t);
else
    fun_out = 0;
end

end

function fun_out = time_fun_2(t)
global w;
fun_out = cos(w*t);
end

