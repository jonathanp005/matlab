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

% Define pressure limits
lowerLimit = 930;
upperLimit = 1060;

% Plot white dotted line for sensor 1 evening measurements
plot(1:31, sensor1Evening, 'w:', 'LineWidth', 2, ...
     'DisplayName', 'Sensor 1 - Evening Measurements');

% Color points based on pressure limits
for day = 1:31
    if sensor1Evening(day) < lowerLimit || sensor1Evening(day) > upperLimit
        % Points outside range - white filled
        scatter(day, sensor1Evening(day), 50, 'w', 'filled', 'MarkerEdgeColor', 'k');
    else
        % Points inside range - green filled
        scatter(day, sensor1Evening(day), 50, 'g', 'filled', 'MarkerEdgeColor', 'k');
    end
end

% Add pressure limit lines
yline(lowerLimit, '--', 'Color', [1, 0.75, 0.8], 'LineWidth', 2, ...
      'DisplayName', 'Lower Limit (930 hPa)');
yline(upperLimit, '--', 'Color', [1, 0.75, 0.8], 'LineWidth', 2, ...
      'DisplayName', 'Upper Limit (1060 hPa)');

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

% Set background color to dark for better contrast with white line
set(gca, 'Color', [0.1, 0.1, 0.1]);
set(gcf, 'Color', [0.1, 0.1, 0.1]);

% Add statistics for sensor 1 evening measurements
meanPressure = mean(sensor1Evening);
stdPressure = std(sensor1Evening);
minPressure = min(sensor1Evening);
maxPressure = max(sensor1Evening);

% Count points inside and outside the range
pointsInside = sum(sensor1Evening >= lowerLimit & sensor1Evening <= upperLimit);
pointsOutside = 31 - pointsInside;

text(0.02, 0.98, sprintf('Mean: %.1f hPa\nStd: %.1f hPa\nMin: %.1f hPa\nMax: %.1f hPa\n\nGreen points (in range): %d\nWhite points (out of range): %d', ...
     meanPressure, stdPressure, minPressure, maxPressure, pointsInside, pointsOutside), ...
     'Units', 'normalized', 'VerticalAlignment', 'top', 'FontSize', 10, ...
     'BackgroundColor', 'white', 'EdgeColor', 'black', 'Color', 'black');

% Display summary statistics for sensor 1 evening measurements
fprintf('\nSensor 1 Evening Measurements Statistics:\n');
fprintf('Mean pressure: %.2f hPa\n', mean(sensor1Evening));
fprintf('Std deviation: %.2f hPa\n', std(sensor1Evening));
fprintf('Min pressure: %.2f hPa\n', min(sensor1Evening));
fprintf('Max pressure: %.2f hPa\n', max(sensor1Evening));
fprintf('Range: %.2f hPa\n', max(sensor1Evening) - min(sensor1Evening));
fprintf('Points within range (930-1060 hPa): %d\n', pointsInside);
fprintf('Points outside range: %d\n', pointsOutside);

% Save the plot
saveas(gcf, 'sensor1_evening_pressure.png');
fprintf('\nPlot saved as sensor1_evening_pressure.png\n');