%% Information
% Title: Advanced exercise & Self-study Week 1
% Time: 26-02-2023
% Name: Boyu Gao
% E-mail: boygao@student.ethz.ch

%% Assignment2
% Title: Numerical integration  矩形/梯形求积法
% 1) Calculate the 'constant' integration using 'rectangle rule' approximation
% 2) Calculate the 'linear' integration using 'rectangle rule' approximation
% 3) Calculate the 'linear' integration using 'trapezoidal rule' approximation


%% 0) Clean sheet
clear variables  % remove items from workspace, freeing up system memory
close all        % close any open figures
clc              % and clear the command window 


%% 1) Using rectangle rule to approximate the 'constant' integration
% (1.1) The real integral result
f1 = @(x) 2;       % define an anonymous function
a = 0;             % lower limit
b = 4;             % upper limit 
real_result1 = integral(f1, a, b, 'arrayvalued', true);  % when f is constant function, we should add ['arrayvalued', true]
disp(real_result1);
% (1.2) The rectangle approximation result
N = 4;             % any integer greater > 0
dx = (b-a) / N;    % not have to be an integer
appr_result1 = 0;
for i = 0:N-1
    appr_result1 = appr_result1 + f1(a + i*dx)*dx;
end
disp(appr_result1);

% Displays
disp('Q1: The sum (approximation) returns the correct solution of the constant integration.');
disp('---');


%% 2) Using rectangle rule to approximate the 'linear' integration
% (2.1) The real integral result
f2 = @(x) 4*x;
real_result2 = integral(f2, a, b);
disp(real_result2);
% (2.2) The rectangle approximation result
N = 100;           % any integer greater > 0
dx = (b-a) / N;    % not have to be an integer
appr_result2 = 0;
for i = 0:N-1
    appr_result2 = appr_result2 + f2(a + i*dx)*dx;
end
disp(appr_result2);

% Displays
disp('Q2: The sum (approximation) could return the correct solution of the linear integration,');
disp('but the N should be larger!');
disp('---');


%% 3) Using trapezoidal rule to approximate the 'linear' integration
% (3.1) The real integral result
f3 = @(x) 4*x;
real_result3 = integral(f3, a, b);
disp(real_result3);
% (3.2) The trapezoidal approximation result
N = 100;           % any integer greater > 0
dx = (b-a) / N;    % not have to be an integer
appr_result3 = 0;
for i = 1:N-1      % The i starts from 1 !! 
    appr_result3 = appr_result3 + f3(a + i*dx);
end
appr_result3 = (appr_result3 + (f3(a) + f3(b)) / 2) * dx;
disp(appr_result3);

% Displays
disp('Q3: The trapezoidal sum (approximation) could return the correct solution of the linear integration.');
disp('It converges faster than the rectangle rule, which means N can be smaller than the rectangle rule.');
disp('---');

