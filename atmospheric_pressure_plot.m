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

% Create the plot
figure('Position', [100, 100, 1200, 800]);
hold on;

% Define colors for each sensor
colors = ['r', 'g', 'b', 'm'];
sensorNames = {'Sensor 1', 'Sensor 2', 'Sensor 3', 'Sensor 4'};
measurementTimes = {'Morning', 'Noon', 'Evening'};

% Plot daily averages for each sensor
for sensor = 1:4
    plot(1:31, dailyAverages(sensor, :), 'Color', colors(sensor), 'LineWidth', 2, ...
         'DisplayName', [sensorNames{sensor} ' (Daily Average)']);
end

% Add individual measurement points (optional - can be commented out for cleaner plot)
% for sensor = 1:4
%     for measurement = 1:3
%         scatter(1:31, squeeze(atmosphericPressure(sensor, measurement, :)), ...
%                 20, colors(sensor), 'filled', 'Alpha', 0.3);
%     end
% end

% Customize the plot
xlabel('Day of Month', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Atmospheric Pressure (hPa)', 'FontSize', 12, 'FontWeight', 'bold');
title('Atmospheric Pressure Measurements Over 31 Days', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 10);
grid on;
grid minor;

% Set axis limits and ticks
xlim([1, 31]);
ylim([900, 1100]);
xticks(1:2:31);
yticks(900:25:1100);

% Add some statistics to the plot
meanPressure = mean(dailyAverages(:));
stdPressure = std(dailyAverages(:));
text(0.02, 0.98, sprintf('Mean Pressure: %.1f hPa\nStd Deviation: %.1f hPa', meanPressure, stdPressure), ...
     'Units', 'normalized', 'VerticalAlignment', 'top', 'FontSize', 10, ...
     'BackgroundColor', 'white', 'EdgeColor', 'black');

% Display summary statistics
fprintf('\nSummary Statistics:\n');
fprintf('Overall mean pressure: %.2f hPa\n', mean(atmosphericPressure(:)));
fprintf('Overall std deviation: %.2f hPa\n', std(atmosphericPressure(:)));
fprintf('Min pressure: %.2f hPa\n', min(atmosphericPressure(:)));
fprintf('Max pressure: %.2f hPa\n', max(atmosphericPressure(:)));

% Display sensor-specific statistics
fprintf('\nSensor-specific daily averages:\n');
for sensor = 1:4
    fprintf('%s: Mean = %.2f hPa, Std = %.2f hPa\n', sensorNames{sensor}, ...
            mean(dailyAverages(sensor, :)), std(dailyAverages(sensor, :)));
end

% Save the plot
saveas(gcf, 'atmospheric_pressure_plot.png');
fprintf('\nPlot saved as atmospheric_pressure_plot.png\n');