%% Information
% Title: Exercise - Week 1
% Time: 24-02-2023
% Name: Boyu Gao
% E-mail: boygao@student.ethz.ch

%% Assignment
% Title: 2D thermal diffusion using a finite-difference approximation 
%        in heterogeneous medium with varying thermal diffusivity k(x,y)
% 1) Input global parameters 
% 2) Initialize grid-spacing and time-step and temperature field
% 3) Update and plot temperature field iteratively
% Note: since k is spatial dependence, the calculation of T and dt needs to be adjusted !!! 


%% 0) Clean sheet
clear variables  % remove items from workspace, freeing up system memory
close all        % close any open figures
clc              % and clear the command window


%% 1) Input: set global parameters
% Note: t means Time, T means Temperature field !!!
nx = 100;       % grid points of x-axis
ny = 50;        % grid points of y-axis
a = 0.2;        % time step constant 
t = 0;          % start time
t_end = 0.05;   % end time
T0 = 'Spike';   % Two initial modes: Spike / Random
% Figure parameters
fontsize_large = 14;
fontsize_small = 10; 
% Thermal diffusivity varying in space (x,y)
k = zeros(ny, nx);
k(1:10, :) = 0.15;
k(11:30, :) = 0.33;
k(31:end, :) = 1.0;  % the heat should diffuse faster as going down !!!


%% 2) Initialization: calculate related parameters
h = 1 / (ny-1);      % grid spacing 
dt = a * h^2 / 1;    % time step: the time step is fixed! so here still specify k = 1
% set the initial Temperature field according to T0
if strcmp(T0, 'Spike')
    T = zeros(ny, nx);    
    T(25, 50) = 1;                            % spike value is 1 at (50,25)
elseif strcmp(T0, 'Random')
    T = padarray(rand(ny-2, nx-2), [1, 1]);   % random range (0,1) + boundary points are always zero 
    T(25, 50) = 1;                            % spike value is 1 at (25,50)
else
    error("T0 doesn't meet the requirments, please modify.");
end


%% 3) Iteration: iteratively update and plot the temperature field 
while t < t_end
    % Calculation the second-order derivative
    T = T + dt * k .* Laplacian(T, h, nx, ny);  % since k is a matrix, so here use .*
    % Display
    imagesc(T);
    colormap('hot'); 
    clb = colorbar;
    title({['Initial field: ' T0], ['Time = ' num2str(t) 's']}, 'FontSize', fontsize_large);
    xlabel('X-axis', 'FontSize', fontsize_large);
    ylabel('Y-axis', 'FontSize', fontsize_large);
    ylabel(clb, 'Temperature', 'FontSize', fontsize_small);
    drawnow;
    % Update the time
    t = t + dt;
end




