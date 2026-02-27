%path and filename of Rocky pendulum data set
fname = 'Gyro_calibration_v3.txt';
%load the contents of the file into struct Q
Q = load([fname]);

start_idx = 1400;
%unpack the experimental data
t = Q(start_idx:end, 1); %*1000; %time (sec)
theta = Q(start_idx:end, 2); %pendulum angle (rad)

%plot free response data
figure();
hold on
plot(t,theta,'r');


%create axis labels, title and legend
title('Rocky Pendulum Free Response Gyro Data');
xlabel('t (sec)');
ylabel('angle (rad)');





[pks, locs] = findpeaks(theta, t); 
% locs = t.*(locs);
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



