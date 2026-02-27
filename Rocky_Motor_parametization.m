%loads and plots the motor calibration data
function [t, y_L, v_L, y_R, v_R] = load_motor_data()
%path and file name of data
fname = 'motor_calibration_data.txt'; %file name (change this!)
%load the motor calibration data
motor_data = importdata([fname]);
%unpack the motor calibration data
t = motor_data(100:200,1);
t = t(:) - t(1);
y_L = motor_data(100:200,2); v_L = motor_data(100:200,3);
y_R = motor_data(100:200,4); v_R = motor_data(100:200,5);


%plot the motor calibration data
figure(1);
subplot(2,1,1);
hold on
plot(t,v_L,'k','linewidth',1);
plot(t,v_R,'r','linewidth',1);
xlabel('time (sec)'); ylabel('wheel speed (m/sec)');
title('Motor Calibration Data');
h1 = legend('Left Wheel','Right Wheel');
set(h1,'location','southeast');
subplot(2,1,2);
hold on
plot(t,y_L,'k','linewidth',1);
plot(t,y_R,'r--','linewidth',1);
xlabel('time (sec)'); ylabel('wheel command (-)');
title('Motor Calibration Data');
h2 = legend('Left Wheel','Right Wheel');
set(h2,'location','southeast');

figure();
a_g = 1/.3; c_g = 1;
%run the fit.
%List of guesses should be in alphabetical order (or parameters)
f_params = fit(t,v_L,'c*(1-exp(-a*x))','StartPoint',[a_g,c_g]);
%unpack the result
a = f_params.a; c = f_params.c;
%Evaluate the fit function at the data points
vL_fit = c.*(1-exp(-a.*t));
%compare fit with the data
hold on
plot(t,v_L,'ro','markerfacecolor','r','markersize',2);
plot(t,vL_fit,'k','linewidth',2);
xlabel('t (s)'); ylabel('v_L (m/s)'); title('Fit Motor Data Left Wheel');
legend('Data','Fit');
tau_L = 1/a;
beta_L = c/y_L;

figure();
a_g = 1; c_g = 1;
%run the fit.
%List of guesses should be in alphabetical order (or parameters)
f_params = fit(t,v_R,'c*(1-exp(-a*x))','StartPoint',[a_g,c_g]);
%unpack the result
a = f_params.a; c = f_params.c;
%Evaluate the fit function at the data points
vR_fit = c*(1-exp(-a*t));
%compare fit with the data
hold on
plot(t,v_R,'ro','markerfacecolor','r','markersize',2);
plot(t,vR_fit,'k','linewidth',2);
xlabel('t (s)'); ylabel('v_L (m/s)'); title('Fit Motor Data Right Wheel');
legend('Data','Fit');
tau_R = 1/a;
beta_R = c/y_R;


end

[t, y_L, v_L, y_R, v_R] = load_motor_data()
