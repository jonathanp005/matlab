% Atmospheric Pressure Analysis
% Generate and plot atmospheric pressure data for 4 sensors over 31 days
% Each sensor measured 3 times per day (morning, noon, evening)

clear; clc; close all;

% Generate atmospheric pressure data
% 4 sensors (rows) × 3 measurements per day (columns) × 31 days (depth)
atmosphericPressure = zeros(4, 3, 31);

% Fill with random values between 900 and 1100
for day = 1:31
    for measurement = 1:3
        for sensor = 1:4
            atmosphericPressure(sensor, measurement, day) = 900 + 200*rand();
        end
    end
end

% Display data dimensions
fprintf('Data matrix dimensions: %d × %d × %d\n', size(atmosphericPressure, 1), size(atmosphericPressure, 2), size(atmosphericPressure, 3));
fprintf('Total measurements: %d\n', numel(atmosphericPressure));

% Calculate daily averages for each sensor
dailyAverages = zeros(4, 31);
for day = 1:31
    for sensor = 1:4
        % Average of 3 daily measurements for each sensor
        dailyAverages(sensor, day) = mean(atmosphericPressure(sensor, :, day));
    end
end

% Extract evening measurements for sensor 1 (measurement 3 = evening)
sensor1Evening = squeeze(atmosphericPressure(1, 3, :));

% Create the plot
figure('Position', [100, 100, 1200, 800]);
hold on;

% Plot evening measurements for sensor 1
plot(1:31, sensor1Evening, 'r-o', 'LineWidth', 2, 'MarkerSize', 6, ...
     'DisplayName', 'Sensor 1 - Evening Measurements');

% Customize the plot
xlabel('Day of Month', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Atmospheric Pressure (hPa)', 'FontSize', 12, 'FontWeight', 'bold');
title('Sensor 1 Evening Atmospheric Pressure Measurements - 31 Days', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 10);
grid on;
grid minor;

% Set axis limits and ticks
xlim([1, 31]);
ylim([900, 1100]);
xticks(1:2:31);
yticks(900:25:1100);

% Add statistics for sensor 1 evening measurements
meanPressure = mean(sensor1Evening);
stdPressure = std(sensor1Evening);
minPressure = min(sensor1Evening);
maxPressure = max(sensor1Evening);
text(0.02, 0.98, sprintf('Mean: %.1f hPa\nStd: %.1f hPa\nMin: %.1f hPa\nMax: %.1f hPa', ...
     meanPressure, stdPressure, minPressure, maxPressure), ...
     'Units', 'normalized', 'VerticalAlignment', 'top', 'FontSize', 10, ...
     'BackgroundColor', 'white', 'EdgeColor', 'black');

% Display summary statistics for sensor 1 evening measurements
fprintf('\nSensor 1 Evening Measurements Statistics:\n');
fprintf('Mean pressure: %.2f hPa\n', mean(sensor1Evening));
fprintf('Std deviation: %.2f hPa\n', std(sensor1Evening));
fprintf('Min pressure: %.2f hPa\n', min(sensor1Evening));
fprintf('Max pressure: %.2f hPa\n', max(sensor1Evening));
fprintf('Range: %.2f hPa\n', max(sensor1Evening) - min(sensor1Evening));

% Save the plot
saveas(gcf, 'sensor1_evening_pressure.png');
fprintf('\nPlot saved as sensor1_evening_pressure.png\n');