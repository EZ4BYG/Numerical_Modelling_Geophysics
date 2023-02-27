%% Information
% Title: Advanced exercise & Self-study Week 1
% Time: 26-02-2023
% Name: Boyu Gao
% E-mail: boygao@student.ethz.ch

%% Assignment3
% Title: Gaussian polynomial quadrature  高斯多项式求积法 (只能求多项式！)
% Note: 1. can only approximate polynomial; 2. the integral range must be [-1, 1]
% 1) Use two points to approximate any polynomial up to degree 1
% 2) Test one special property of Legendre polynomials
% 3) Polynomial division property  多项式除法 -> 2个多项式相除的结果，可写成"商"和"余数"的形式
%    f(x) / g(x) = Q(x) + R(x) / g(x) --> f(x) = Q(x)g(x) + R(x)
% 4) Gauss-Legendre quadrature  高斯-勒让德求积法 -> 用勒让德多项式辅助进行更"讲究"的选点！
% 5) Gauss-Legendre-Lobatto quadrature  高斯-勒让德-洛巴托求积分 -> 用勒让德多项式"导函数"的零点 以及 x = ±1 这两个固定点 
% 补充1：GLL虽比GL用更多的点近似更低阶的多项式，但好处是GLL用到了积分上、下限这2个固定（积分边界）点！
% 补充2：最终形态的Gauss-Legendre-Lobatto quadrature，会在spectral element method中用到！！！


%% 0) Clean sheet
clear variables  % remove items from workspace, freeing up system memory
close all        % close any open figures
clc              % and clear the command window 


%% 1) Using rectangle rule to approximate the 'constant' integration
% (1.1) The real integral result
f1 = @(x) 2 + x;   % define an anonymous function: arbitrary polynomial up to degree 1
a = -1;            % lower limit must be -1
b = 1;             % upper limit must be 1
real_result1 = integral(f1, a, b);
disp(real_result1);
% (1.2) The Gaussian approximation result
N = 2;             % at least 2 points to approximate polynomials up to degree 1
x1 = -1;
x2 = 1;
appr_result1 = f1(x1) + f1(x2);
disp(appr_result1);

% Displays
disp('Q1: We can approximate an integral using 2 points to accurately approximate polynomials up to degree 1.');
disp('Reason: Within the integration interval of [-1, 1], the first-order polynomial is symmetric about the origin,');
disp('which means the result of its integration is 0.');
disp('---');


%% 2) Confirm one property of Lagendre polynomials
p3 = @(x) 0.5 * (5*x.^3 - 3*x);    % define a 3-th Legendre polynomial
f2 = @(x) 2 + x + 3*x.^2;          % define a 2-th normal polynomial
multi_func = @(x) p3(x) .* f2(x);  % don't forget (x) !!! and must use .*
real_result2 = integral(multi_func, a, b);
disp(real_result2);

% Displays
disp('Q2: The n-th Legendre polynomial multiplied with an (n-1)-th degree polynomial integrates to zero on the domain [-1, 1].');
disp('---');


%% 3) Polynomial division property
syms x;
f3 = @(x) 1 + 2*x + x.^2 + 5*x.^3; % 3rd degree
Q = @(x) 2 / 3 + 10 / 3 * x;
R = @(x) 4 / 3 + 11 / 3 * x;
g = @(x) 1 / 2 * (3*x.^2 - 1);     % 2nd degree
right_term = Q(x) .* g(x) + R(x);
disp( simplify(right_term) );      % It equals to f3 

% Displays
disp("Q3: If we divide an M-th degree polynomial by an N-th degree polynomial,");
disp("the maximum degree of 'quotient' Q(x) and 'remainder' R(x) polynomials is (M-N).");
disp('Here we divide a 3rd (M=3) polynomial by a 2rd (N=2) polynomial, so the maximum degree of Q(x) and R(x) is 3-2=1.');
disp("The result shows that we can always divide 2 polynomials and write the result in terms of a 'quotient' Q(x) and a 'remainder' R(x).");
disp('f(x) / g(x) = Q(x) + R(x) / g(x) --> f(x) = Q(x)g(x) + R(x)');
disp('---');


%% 4) Gauss-Legendre quadrature
% (4.1) The real integral result
a = 1; b = 3; c = 2.5; d = -1.7; e = 0.2; f = 2.2;
f4 = @(x) a + b*x + c*x.^2 + d*x.^3 + e*x.^4 + f*x.^5;  % f(x) is a '2N-1 = 5' degree polynomial 
real_result4 = integral(f4, -1, 1);
disp(real_result4);
% (4.2) Use N = 3 degree to select 3 points to approximately integrate the f(x)
% Note: we can ask Chatgpt to obtain the specific points and corresponding weights directly !!!
x1 = -sqrt(3/5); x2 = 0; x3 = sqrt(3/5);  % 3 clever choice of the sampling locations using N = 3 degree Legendre polynomial
w1 = 5/9; w2 = 8/9; w3 = 5/9;
appr_result4 = w1*f4(x1) + w2*f4(x2) + w3*f4(x3);
disp(appr_result4);

% Displays
disp('Q4: The original 2N-1 degree polynomial requires at least 2N sampling points (corresponding to 2N weights) to be accurately approximated.');
disp('But when we make clever choices of sampling points using Legendre polynomials,');
disp("we can 'actually' accurately approximate the original 2N-1 degree polynomial with only N sampling points.");
disp('Therefore, introducing Legendre polynomials is to help us make smarter and fewer choices of sampling points !!!');
disp('---');


%% 5) Gauss-Legendre-Lobatto quadrature
% (5.1) The real integral result
a = -2; b = 1.2; c = -0.8; d = 9.5;
f5 = @(x) a + b*x + c*x.^2 + d*x.^3;   % f(x) is a '2N-3 = 3' degree polynomial
real_result5 = integral(f5, -1, 1);
disp(real_result5);
% (5.2) Use N = 3 degree Legendre polynomial: N-1=2个三阶勒让德多项式导函数零点 + 2个固定点x=±1 -> 共n+1=4个点
x1 = -1; x2 = -sqrt(1/5); x3 = sqrt(1/5); x4 = 1;
w1 = 1/6; w2 = 5/6; w3 = 5/6; w4 = 1/6;
appr_result5 = w1*f5(x1) + w2*f5(x2) + w3*f5(x3) + w4*f5(x4);
disp(appr_result5);

% Displays
disp('Q5: The core of GLL is still Legendre polynomials, but using their derivative functions.');
disp('GLL(n) means it needs n degree Legendre polynomial -> n + 1 points in total');
disp('· (n-1) points from the derivative of the n-th Legendre polynomial;');
disp('· 2 points at x = ± 1');
disp('These n + 1 points can integrate 2n-3 degree polynomial.');
disp('---')
