%path and filename of Rocky pendulum data set
fname = 'GC_3_12_v1.txt';
%load the contents of the file into struct Q
Q = load([fname]);

start_idx = 1; %1695
end_idx = 3500;
%unpack the experimental data
t = Q(start_idx:end_idx, 1) - Q(start_idx, 1); %*1000; %time (sec), zeroed. 
theta = Q(start_idx:end_idx, 2); %pendulum angle (rad)

%plot free response data
figure();
hold on
plot(t,theta,'w.');


%create axis labels, title and legend
title('Rocky Pendulum Free Response Gyro Data');
xlabel('t (sec)');
ylabel('angle (rad)');


%running regression to find everything using stuff from HW2
signal_params = regress_underdamped_response(t,theta);
%unpack results
C = signal_params.C; S = signal_params.S; D = signal_params.D;
omega_d = signal_params.omega_d; sigma = signal_params.sigma;
omega_n = signal_params.omega_n; zeta = signal_params.zeta;

theta_with_regression = @(t_in) D + (C.*cos(omega_d*t_in) + S.*sin(omega_d*t_in)).*exp(-sigma.*t_in);

plot(t, theta_with_regression(t), "r", 'LineWidth', 2)

legend("Experimental data", "Fitted line")

%%%%%%%%%%%%%%%%%%%%% CALCULATING TAU %%%%%%%%%%%%%%%%%%%%%

%Tau = 1/(zeta*omega_n)

tau = 1/(zeta*omega_n);
tau_pendulum = tau
%Tau = 5.4614 with start_idx at 2500


omega_n
%Omega_n = 4.7764 with start_idx at 2500

l_eff = 9.8/(omega_n^2)
%L_eff = 0.4296 with start_idx at 2500
theta_offset = D

%%%%%%%%%%%%%%%%%%% EXTRA BS STUFF %%%%%%%%%%%%%%%%%%%%%%

% 
% 
% [pks, locs] = findpeaks(theta, t); 
% % locs = t.*(locs);
% %tau = oscillation period
% tau = mean(diff(locs));      % Calculate average period
% 
% %w_d = damped frequency
% w_d = 2*pi/tau;
% 
% %q = amplitude ratio
% q = pks(2)/pks(1);
% 
% %sigma = exponential decay rate
% sigma = -1/tau*log(q);
% 
% %w_n = natural frequency
% w_n = sqrt(w_d^2+sigma^2);
% 
% %l_eff 
% l_eff = 9.81/w_n^2;
% 
% 
% 
