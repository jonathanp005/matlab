function [fig, T, Y] = LotkaVolterra(y_0, t)
% elsorendu, ketvaltozos differencialegynelet megoldasa,
% Lotka-Volterra ragadozo-zsakmany modell
% 
% Inputs:
%   y_0 - initial conditions [prey, predator]
%   t - time span [t_start, t_end]
% 
% Outputs:
%   fig - figure handle
%   T - time vector
%   Y - solution matrix [prey, predator]

    % Model parameters
    alpha = 1.1;  % prey growth rate
    beta = 0.4;   % predation rate
    gamma = 0.4;  % predator death rate
    delta = 0.1;  % predator growth rate from prey consumption
    
    % Define the system of differential equations
    function dydt = lotka_volterra_ode(t, y)
        prey = y(1);
        predator = y(2);
        
        dydt = zeros(2, 1);
        dydt(1) = alpha * prey - beta * prey * predator;  % prey equation
        dydt(2) = delta * prey * predator - gamma * predator;  % predator equation
    end
    
    % Solve the system of ODEs
    [T, Y] = ode45(@lotka_volterra_ode, t, y_0);
    
    % Create the figure
    fig = figure;
    
    % Plot 1: Population dynamics over time
    subplot(2, 2, 1);
    plot(T, Y(:, 1), 'b-', 'LineWidth', 2, 'DisplayName', 'Prey');
    hold on;
    plot(T, Y(:, 2), 'r-', 'LineWidth', 2, 'DisplayName', 'Predator');
    xlabel('Time');
    ylabel('Population');
    title('Population Dynamics Over Time');
    legend('Location', 'best');
    grid on;
    
    % Plot 2: Phase plane (predator vs prey)
    subplot(2, 2, 2);
    plot(Y(:, 1), Y(:, 2), 'k-', 'LineWidth', 1.5);
    hold on;
    plot(Y(1, 1), Y(1, 2), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g', 'DisplayName', 'Start');
    plot(Y(end, 1), Y(end, 2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'End');
    xlabel('Prey Population');
    ylabel('Predator Population');
    title('Phase Plane (Predator vs Prey)');
    legend('Location', 'best');
    grid on;
    
    % Plot 3: Prey population over time (detailed)
    subplot(2, 2, 3);
    plot(T, Y(:, 1), 'b-', 'LineWidth', 2);
    xlabel('Time');
    ylabel('Prey Population');
    title('Prey Population Over Time');
    grid on;
    
    % Plot 4: Predator population over time (detailed)
    subplot(2, 2, 4);
    plot(T, Y(:, 2), 'r-', 'LineWidth', 2);
    xlabel('Time');
    ylabel('Predator Population');
    title('Predator Population Over Time');
    grid on;
    
    % Add overall title
    sgtitle('Lotka-Volterra Predator-Prey Model', 'FontSize', 14, 'FontWeight', 'bold');
    
    % Display some statistics
    fprintf('Lotka-Volterra Model Results:\n');
    fprintf('Initial conditions: Prey = %.1f, Predator = %.1f\n', y_0(1), y_0(2));
    fprintf('Final conditions: Prey = %.1f, Predator = %.1f\n', Y(end, 1), Y(end, 2));
    fprintf('Time span: %.1f to %.1f\n', t(1), t(2));
    fprintf('Model parameters: α=%.1f, β=%.1f, γ=%.1f, δ=%.1f\n', alpha, beta, gamma, delta);
    
end