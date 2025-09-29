%% MATLAB Examples: Tabular Data, Conditional Indexing, Statistics, Plotting, and ODEs
% This script demonstrates various MATLAB capabilities with practical examples

clear; clc; close all;

%% 1. PROCESSING TABULAR DATA
fprintf('=== 1. PROCESSING TABULAR DATA ===\n');

% Create sample tabular data
data = table();
data.Name = {'Alice'; 'Bob'; 'Charlie'; 'Diana'; 'Eve'};
data.Age = [25; 30; 35; 28; 32];
data.Salary = [50000; 60000; 70000; 55000; 65000];
data.Department = {'Engineering'; 'Sales'; 'Engineering'; 'Marketing'; 'Sales'};

% Display the table
fprintf('Original data table:\n');
disp(data);

% Add calculated columns
data.Experience = data.Age - 22; % Assume work starts at 22
data.SalaryPerYear = data.Salary ./ data.Experience;

% Sort by salary
data_sorted = sortrows(data, 'Salary', 'descend');
fprintf('\nData sorted by salary (descending):\n');
disp(data_sorted);

% Group by department
fprintf('\nGrouping by department:\n');
departments = unique(data.Department);
for i = 1:length(departments)
    dept_data = data(strcmp(data.Department, departments{i}), :);
    fprintf('%s: %d employees, avg salary: $%.0f\n', ...
        departments{i}, height(dept_data), mean(dept_data.Salary));
end

%% 2. CONDITIONAL INDEXING
fprintf('\n=== 2. CONDITIONAL INDEXING ===\n');

% Create sample data
x = 1:20;
y = randn(1, 20) * 10 + 50; % Random data around 50

% Basic conditional indexing
positive_values = y(y > 0);
high_values = y(y > 60);
even_indices = y(mod(x, 2) == 0);

fprintf('Original data range: %.2f to %.2f\n', min(y), max(y));
fprintf('Positive values count: %d\n', length(positive_values));
fprintf('High values (>60) count: %d\n', length(high_values));
fprintf('Values at even indices count: %d\n', length(even_indices));

% Multiple conditions
high_positive = y(y > 0 & y > 60);
low_or_negative = y(y < 0 | y < 40);

fprintf('High positive values count: %d\n', length(high_positive));
fprintf('Low or negative values count: %d\n', length(low_or_negative));

% Using find() for indices
high_indices = find(y > 60);
fprintf('Indices of high values: %s\n', mat2str(high_indices));

%% 3. BASIC STATISTICAL FUNCTIONS
fprintf('\n=== 3. BASIC STATISTICAL FUNCTIONS ===\n');

% Generate sample data
data_vector = randn(100, 1) * 15 + 100; % Normal distribution, mean=100, std=15

% Basic statistics
mean_val = mean(data_vector);
median_val = median(data_vector);
std_val = std(data_vector);
var_val = var(data_vector);
min_val = min(data_vector);
max_val = max(data_vector);
range_val = range(data_vector);

fprintf('Sample data statistics (n=%d):\n', length(data_vector));
fprintf('Mean: %.2f\n', mean_val);
fprintf('Median: %.2f\n', median_val);
fprintf('Standard deviation: %.2f\n', std_val);
fprintf('Variance: %.2f\n', var_val);
fprintf('Min: %.2f\n', min_val);
fprintf('Max: %.2f\n', max_val);
fprintf('Range: %.2f\n', range_val);

% Percentiles
percentiles = prctile(data_vector, [25, 50, 75, 90, 95]);
fprintf('25th percentile: %.2f\n', percentiles(1));
fprintf('50th percentile (median): %.2f\n', percentiles(2));
fprintf('75th percentile: %.2f\n', percentiles(3));
fprintf('90th percentile: %.2f\n', percentiles(4));
fprintf('95th percentile: %.2f\n', percentiles(5));

% Correlation example
x_data = 1:50;
y_data = 2*x_data + randn(1, 50)*5; % Linear relationship with noise
correlation = corrcoef(x_data, y_data);
fprintf('Correlation between x and y: %.3f\n', correlation(1,2));

%% 4. PLOTTING
fprintf('\n=== 4. PLOTTING ===\n');

% Create figure with subplots
figure('Position', [100, 100, 1200, 800]);

% Subplot 1: Line plot
subplot(2, 3, 1);
x = linspace(0, 4*pi, 100);
y1 = sin(x);
y2 = cos(x);
plot(x, y1, 'b-', 'LineWidth', 2, 'DisplayName', 'sin(x)');
hold on;
plot(x, y2, 'r--', 'LineWidth', 2, 'DisplayName', 'cos(x)');
xlabel('x');
ylabel('y');
title('Trigonometric Functions');
legend('Location', 'best');
grid on;

% Subplot 2: Scatter plot
subplot(2, 3, 2);
x_scatter = randn(100, 1);
y_scatter = 2*x_scatter + randn(100, 1)*0.5;
scatter(x_scatter, y_scatter, 50, 'filled', 'MarkerFaceAlpha', 0.6);
xlabel('X');
ylabel('Y');
title('Scatter Plot with Correlation');
grid on;

% Subplot 3: Histogram
subplot(2, 3, 3);
histogram(data_vector, 20, 'FaceColor', 'green', 'FaceAlpha', 0.7);
xlabel('Value');
ylabel('Frequency');
title('Data Distribution');
grid on;

% Subplot 4: Bar plot
subplot(2, 3, 4);
categories = {'A', 'B', 'C', 'D', 'E'};
values = [23, 45, 56, 78, 32];
bar(values, 'FaceColor', 'cyan');
set(gca, 'XTickLabel', categories);
xlabel('Category');
ylabel('Value');
title('Bar Chart');
grid on;

% Subplot 5: 3D surface
subplot(2, 3, 5);
[X, Y] = meshgrid(-2:0.2:2, -2:0.2:2);
Z = X.^2 + Y.^2;
surf(X, Y, Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Surface: z = x² + y²');
colorbar;

% Subplot 6: Pie chart
subplot(2, 3, 6);
pie_data = [30, 25, 20, 15, 10];
pie_labels = {'Category 1', 'Category 2', 'Category 3', 'Category 4', 'Category 5'};
pie(pie_data, pie_labels);
title('Pie Chart');

sgtitle('MATLAB Plotting Examples', 'FontSize', 16, 'FontWeight', 'bold');

%% 5. SOLVING DIFFERENTIAL EQUATIONS WITH ODE45
fprintf('\n=== 5. SOLVING DIFFERENTIAL EQUATIONS WITH ODE45 ===\n');

% Example 1: Simple exponential growth/decay
% dy/dt = -k*y, y(0) = y0
fprintf('Example 1: Exponential Decay\n');

% Define the ODE function
odefun1 = @(t, y) -0.5 * y; % k = 0.5

% Initial conditions and time span
y0_1 = 100;
tspan1 = [0, 10];

% Solve the ODE
[t1, y1] = ode45(odefun1, tspan1, y0_1);

% Plot the solution
figure('Position', [200, 200, 1000, 400]);

subplot(1, 2, 1);
plot(t1, y1, 'b-', 'LineWidth', 2);
xlabel('Time');
ylabel('y(t)');
title('Exponential Decay: dy/dt = -0.5y');
grid on;

% Example 2: Damped harmonic oscillator
% d²y/dt² + 2*ζ*ω*dydt + ω²*y = 0
fprintf('Example 2: Damped Harmonic Oscillator\n');

% Parameters
omega = 2; % Natural frequency
zeta = 0.1; % Damping ratio

% Convert to first-order system: y1 = y, y2 = dy/dt
% dy1/dt = y2
% dy2/dt = -2*zeta*omega*y2 - omega^2*y1
odefun2 = @(t, y) [y(2); -2*zeta*omega*y(2) - omega^2*y(1)];

% Initial conditions: y(0) = 1, dy/dt(0) = 0
y0_2 = [1; 0];
tspan2 = [0, 20];

% Solve the ODE
[t2, y2] = ode45(odefun2, tspan2, y0_2);

% Plot the solution
subplot(1, 2, 2);
plot(t2, y2(:,1), 'r-', 'LineWidth', 2);
xlabel('Time');
ylabel('y(t)');
title('Damped Harmonic Oscillator');
grid on;

% Example 3: Lotka-Volterra predator-prey model
fprintf('Example 3: Lotka-Volterra Predator-Prey Model\n');

% Parameters
alpha = 1.1; % Prey growth rate
beta = 0.4;  % Predation rate
gamma = 0.4; % Predator death rate
delta = 0.1; % Predator growth rate

% System: x = prey, y = predator
% dx/dt = alpha*x - beta*x*y
% dy/dt = delta*x*y - gamma*y
odefun3 = @(t, y) [alpha*y(1) - beta*y(1)*y(2); ...
                   delta*y(1)*y(2) - gamma*y(2)];

% Initial conditions
y0_3 = [10; 2]; % 10 prey, 2 predators
tspan3 = [0, 50];

% Solve the ODE
[t3, y3] = ode45(odefun3, tspan3, y0_3);

% Plot phase portrait and time series
figure('Position', [300, 300, 1200, 400]);

subplot(1, 2, 1);
plot(y3(:,1), y3(:,2), 'g-', 'LineWidth', 2);
xlabel('Prey Population');
ylabel('Predator Population');
title('Phase Portrait: Predator vs Prey');
grid on;

subplot(1, 2, 2);
plot(t3, y3(:,1), 'b-', 'LineWidth', 2, 'DisplayName', 'Prey');
hold on;
plot(t3, y3(:,2), 'r-', 'LineWidth', 2, 'DisplayName', 'Predator');
xlabel('Time');
ylabel('Population');
title('Population Dynamics Over Time');
legend('Location', 'best');
grid on;

% Display some results
fprintf('ODE45 Results Summary:\n');
fprintf('Exponential decay: y(10) = %.3f (analytical: %.3f)\n', ...
    y1(end), y0_1*exp(-0.5*10));
fprintf('Harmonic oscillator: final amplitude = %.3f\n', abs(y2(end,1)));
fprintf('Predator-prey: final prey = %.1f, final predator = %.1f\n', ...
    y3(end,1), y3(end,2));

fprintf('\nAll examples completed successfully!\n');