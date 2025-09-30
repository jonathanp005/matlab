function [fig, T, Y] = predator_prey_model(y_0, t)
% Predator-prey model with carrying capacities
% 
% Inputs:
%   y_0 - initial values [y1_0, y2_0] where y1=prey, y2=predator
%   t - time interval [t_0, t_max]
% 
% Outputs:
%   fig - figure handler
%   T - time vector of the solution
%   Y - value vector of the solution [y1, y2]
% 
% System of equations:
%   dy1/dt = (1 - y2/u2) * y1
%   dy2/dt = -(1 - y1/u1) * y2
% 
% Where:
%   y1 - number of prey animals
%   y2 - number of predator animals
%   u1 - prey carrying capacity (fixed at 100)
%   u2 - predator carrying capacity (fixed at 50)

    % Fixed parameters
    u1 = 100;  % prey carrying capacity
    u2 = 50;   % predator carrying capacity
    
    % Anonymous function for the equation system
    dydt = @(t, y) [
        (1 - y(2)/u2) * y(1);      % dy1/dt = (1 - y2/u2) * y1
        -(1 - y(1)/u1) * y(2)      % dy2/dt = -(1 - y1/u1) * y2
    ];
    
    % Solve the system of ODEs
    [T, Y] = ode45(dydt, t, y_0);
    
    % Create the figure
    fig = figure;
    
    % Plot 1: Population dynamics over time
    subplot(1, 2, 1);
    plot(T, Y(:, 1), 'b-', 'LineWidth', 2, 'DisplayName', 'Prey (y1)');
    hold on;
    plot(T, Y(:, 2), 'r-', 'LineWidth', 2, 'DisplayName', 'Predator (y2)');
    xlabel('Time');
    ylabel('Population');
    title('Population Dynamics Over Time');
    legend('Location', 'best');
    grid on;
    
    % Plot 2: Phase plane (predator vs prey)
    subplot(1, 2, 2);
    plot(Y(:, 1), Y(:, 2), 'k-', 'LineWidth', 1.5);
    hold on;
    plot(Y(1, 1), Y(1, 2), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g', 'DisplayName', 'Start');
    plot(Y(end, 1), Y(end, 2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'End');
    xlabel('Prey Population (y1)');
    ylabel('Predator Population (y2)');
    title('Phase Plane (Predator vs Prey)');
    legend('Location', 'best');
    grid on;
    
    % Add overall title
    sgtitle('Predator-Prey Model with Carrying Capacities', 'FontSize', 14, 'FontWeight', 'bold');
    
    % Display model information
    fprintf('Predator-Prey Model Results:\n');
    fprintf('Initial conditions: Prey = %.1f, Predator = %.1f\n', y_0(1), y_0(2));
    fprintf('Final conditions: Prey = %.1f, Predator = %.1f\n', Y(end, 1), Y(end, 2));
    fprintf('Time span: %.1f to %.1f\n', t(1), t(2));
    fprintf('Carrying capacities: u1 (prey) = %.1f, u2 (predator) = %.1f\n', u1, u2);
    
end