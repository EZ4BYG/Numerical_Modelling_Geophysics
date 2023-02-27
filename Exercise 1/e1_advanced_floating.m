%% Information
% Title: Advanced exercise & Self-study Week 1
% Time: 25-02-2023
% Name: Boyu Gao
% E-mail: boygao@student.ethz.ch

%% Assignment1
% Title: Floating point arithmetic  浮点数运算精度
% 1) Calculate the Basel problem with an 'ascending' single precision for-loop
% 2) Calculate the Basel problem with an 'descending' single precision for-loop
% 3) How to calculate '1 + 10^(-100) - 1'


%% 0) Clean sheet
clear variables  % remove items from workspace, freeing up system memory
close all        % close any open figures
clc              % and clear the command window 


%% 1) With an 'ascending' single precision for-loop
bp1 = 0;
n1 = 100000;
for i = 1:n1
    bp1 = bp1 + 1 / (single(i)^2);  
end
format long;
disp(bp1);

% Try:
% a = 1;
% b = a + 1 / (single(1000)^2);   % result is 1.000001
% c = a + 1 / (single(10000)^2);  % result is 1

% Displays
disp('As n continuously increases, the sum converges to 1.6447, which is inaccurate!');
disp('When i is large, the 1/(i^2) becomes very small! If we use 1/(double(i)^2), the result will become accurate.');
disp('Reason: In MATLAB, the single precision format has 24 bits of precision,')
disp('which is equivalent to about 7 decimal digits.');
disp('So when i > 10000, the 1 / (single(i)^2) is so small and will be rounded off.');
disp('Example: 1 + 1 / (single(1000)^2) = 1.000001, but 1 + 1 / (single(10000)^2) = 1');
disp('---');


%% 2) With an 'descending' single precision for-loop
bp2 = 0;
n1 = 100000;
for i = n1:-1:1
    bp2 = bp2 + 1 / (single(i)^2);
end
format long;
disp(bp2);

% Displays
disp('As n continuously decreases, the sum converges to 1.6449, which is accurate!');
disp('Changing the order of the for-loop (in reverse order) can improve the accuracy of the result.');
disp('Reason: This reduces the accumulation of round-off errors.');
disp('When we add a small number to a large number, the small number may be rounded off, which means its contribution to the sum can be lost!');
disp('But if we start with small terms and add large terms later, the beginning small terms will still contribute to the sum.');
disp('---');


%% 3) Associativity 
c1 = 1 + 10^(-100) - 1;
c2 = (1-1) + 10^(-100);
format long;
disp(c1); 
disp(c2);

% Displays
disp('Theoretically, when performing summation, we should put smaller numbers first and larger numbers last.');
disp('1 + (2+3) == (1+2) + 3');
disp('(1 + 10^(-100)) - 1 = 0,  but (1-1) + 10^(-100) = 10^(-100) + (1-1) = 10^(-100).');
disp('This is because 10^(-100) is too small to be represented in single / double precision floating-point format,');
disp('which means 1 + 10^(-100) = 1, and then 1 - 1 = 0.');
disp('We should reverse the order: put small number (1-1) in front, following 10^(-100).');
disp('---');
