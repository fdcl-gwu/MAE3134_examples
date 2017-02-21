function swinging_door_example_021717
clear;
close all;

% Properties
global J c k;
J = 1;
c = 2;
k = 1;

% Initial Conditions
th0 = 1;
thdot0 = 1;
X0 = [th0;thdot0];
t0 = 0;
tf = 10;
numpts = 101;
tspan = linspace(t0, tf, numpts);

% Differential Equation
[~, X] = ode45(@eom, tspan, X0);

% Analyze Data
th = zeros(1,numpts);
th_analytical = th;

for i = 1:numpts
    th(i) = X(i,1);
    th_analytical(i) = (th0+thdot0)*tspan(i)*exp(-tspan(i))+th0*exp(-tspan(i));
end


% Plotting
figure;
subplot(2,1,1);
plot(tspan, th);
xlabel('t');
ylabel('Numerical \theta');
subplot(2,1,2);
plot(tspan, th_analytical);
xlabel('t');
ylabel('Analytical \theta');


end

function Xdot = eom(~,X)
global J c k;
th = X(1);
thdot = X(2);
thddot = -c/J*thdot-k/J*th;
Xdot = zeros(2,1);
Xdot(1) = thdot;
Xdot(2) = thddot;
end



