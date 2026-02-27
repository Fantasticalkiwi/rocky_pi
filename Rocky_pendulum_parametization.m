%path and filename of Rocky pendulum data set
fname = 'rocky_pendulum_estimation_data01.mat';
%load the contents of the file into struct Q
Q = load([fname]);
%unpack the experimental data
t = Q.t/1000; %time (sec)
theta = Q.theta; %pendulum angle (rad)
%plot free response data
figure(1);
hold on
plot(t,theta,'k');
%create axis labels, title and legend
title('Rocky Pendulum Free Response Data');
xlabel('t (sec)');
ylabel('angle (rad)');

[pks, locs] = findpeaks(y, t); 
locs = t(locs);
%tau = oscillation period
tau = mean(diff(locs));      % Calculate average period

%w_d = damped frequency
w_d = 2*pi/tau;

%q = amplitude ratio
q = pks(2)/pks(1);

%sigma = exponential decay rate
sigma = -1/tau*log(q);

%w_n = natural frequency
w_n = sqrt(w_d^2+sigma^2);

%l_eff 
l_eff = 9.81/w_n^2;



