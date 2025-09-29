%% MATLAB Tabular Data Processing Examples
% This file contains comprehensive examples for processing tabular data in MATLAB
% Suitable for exam preparation and learning

clear; clc; close all;

%% 1. BASIC TABLE OPERATIONS

fprintf('=== 1. BASIC TABLE OPERATIONS ===\n\n');

% Create sample data
names = {'Alice'; 'Bob'; 'Charlie'; 'Diana'; 'Eve'};
ages = [25; 30; 35; 28; 32];
salaries = [50000; 60000; 70000; 55000; 65000];
departments = {'IT'; 'HR'; 'IT'; 'Finance'; 'HR'};

% Create a table
T = table(names, ages, salaries, departments, ...
    'VariableNames', {'Name', 'Age', 'Salary', 'Department'});

fprintf('Original Table:\n');
disp(T);

% Access table properties
fprintf('Table size: %d rows, %d columns\n', height(T), width(T));
fprintf('Variable names: %s\n', strjoin(T.Properties.VariableNames, ', '));

% Access specific columns
fprintf('\nNames column:\n');
disp(T.Name);

% Access specific rows
fprintf('First 3 rows:\n');
disp(T(1:3, :));

% Access specific cells
fprintf('Age of first person: %d\n', T.Age(1));

%% 2. READING AND WRITING TABULAR DATA

fprintf('\n=== 2. READING AND WRITING TABULAR DATA ===\n\n');

% Write table to CSV file
writetable(T, 'employee_data.csv');

% Read table from CSV file
T_read = readtable('employee_data.csv');

fprintf('Table read from CSV:\n');
disp(T_read);

% Write to Excel file
writetable(T, 'employee_data.xlsx', 'Sheet', 'Employees');

% Read from Excel file
T_excel = readtable('employee_data.xlsx', 'Sheet', 'Employees');

fprintf('Table read from Excel:\n');
disp(T_excel);

%% 3. DATA MANIPULATION - FILTERING

fprintf('\n=== 3. DATA MANIPULATION - FILTERING ===\n\n');

% Filter by department
IT_employees = T(strcmp(T.Department, 'IT'), :);
fprintf('IT Department employees:\n');
disp(IT_employees);

% Filter by age (older than 30)
older_employees = T(T.Age > 30, :);
fprintf('Employees older than 30:\n');
disp(older_employees);

% Filter by salary range
high_salary = T(T.Salary >= 60000, :);
fprintf('High salary employees (>= 60000):\n');
disp(high_salary);

% Multiple conditions
IT_high_salary = T(strcmp(T.Department, 'IT') & T.Salary >= 60000, :);
fprintf('IT employees with high salary:\n');
disp(IT_high_salary);

%% 4. DATA MANIPULATION - SORTING

fprintf('\n=== 4. DATA MANIPULATION - SORTING ===\n\n');

% Sort by age (ascending)
T_sorted_age = sortrows(T, 'Age');
fprintf('Table sorted by age (ascending):\n');
disp(T_sorted_age);

% Sort by salary (descending)
T_sorted_salary = sortrows(T, 'Salary', 'descend');
fprintf('Table sorted by salary (descending):\n');
disp(T_sorted_salary);

% Sort by multiple columns
T_sorted_multi = sortrows(T, {'Department', 'Salary'}, {'ascend', 'descend'});
fprintf('Table sorted by department (asc) then salary (desc):\n');
disp(T_sorted_multi);

%% 5. DATA MANIPULATION - GROUPING AND AGGREGATION

fprintf('\n=== 5. DATA MANIPULATION - GROUPING AND AGGREGATION ===\n\n');

% Group by department and calculate statistics
department_stats = groupsummary(T, 'Department', {'mean', 'std', 'count'}, 'Salary');
fprintf('Department salary statistics:\n');
disp(department_stats);

% Group by department and age groups
T.AgeGroup = discretize(T.Age, [0, 30, 35, Inf], 'categorical', {'Young', 'Middle', 'Senior'});
age_group_stats = groupsummary(T, {'Department', 'AgeGroup'}, 'mean', 'Salary');
fprintf('Salary by department and age group:\n');
disp(age_group_stats);

% Calculate summary statistics for all numeric columns
summary_stats = groupsummary(T, [], {'mean', 'std', 'min', 'max'}, {'Age', 'Salary'});
fprintf('Overall summary statistics:\n');
disp(summary_stats);

%% 6. STATISTICAL ANALYSIS

fprintf('\n=== 6. STATISTICAL ANALYSIS ===\n\n');

% Basic statistics
fprintf('Age statistics:\n');
fprintf('  Mean: %.2f\n', mean(T.Age));
fprintf('  Median: %.2f\n', median(T.Age));
fprintf('  Standard deviation: %.2f\n', std(T.Age));
fprintf('  Range: %d to %d\n', min(T.Age), max(T.Age));

fprintf('\nSalary statistics:\n');
fprintf('  Mean: $%.2f\n', mean(T.Salary));
fprintf('  Median: $%.2f\n', median(T.Salary));
fprintf('  Standard deviation: $%.2f\n', std(T.Salary));

% Correlation analysis
correlation_matrix = corrcoef(T.Age, T.Salary);
fprintf('\nCorrelation between age and salary: %.3f\n', correlation_matrix(1,2));

% T-test example (comparing salaries between departments)
IT_salaries = T.Salary(strcmp(T.Department, 'IT'));
HR_salaries = T.Salary(strcmp(T.Department, 'HR'));

if length(IT_salaries) > 1 && length(HR_salaries) > 1
    [h, p] = ttest2(IT_salaries, HR_salaries);
    fprintf('T-test p-value (IT vs HR salaries): %.4f\n', p);
end

%% 7. DATA VISUALIZATION

fprintf('\n=== 7. DATA VISUALIZATION ===\n\n');

% Create figure with subplots
figure('Position', [100, 100, 1200, 800]);

% Histogram of ages
subplot(2, 3, 1);
histogram(T.Age, 'BinWidth', 5);
title('Age Distribution');
xlabel('Age');
ylabel('Frequency');

% Histogram of salaries
subplot(2, 3, 2);
histogram(T.Salary, 'BinWidth', 5000);
title('Salary Distribution');
xlabel('Salary');
ylabel('Frequency');

% Scatter plot: Age vs Salary
subplot(2, 3, 3);
scatter(T.Age, T.Salary, 100, 'filled');
title('Age vs Salary');
xlabel('Age');
ylabel('Salary');

% Box plot by department
subplot(2, 3, 4);
boxplot(T.Salary, T.Department);
title('Salary by Department');
ylabel('Salary');

% Bar chart of average salary by department
subplot(2, 3, 5);
dept_avg = groupsummary(T, 'Department', 'mean', 'Salary');
bar(dept_avg.Department, dept_avg.mean_Salary);
title('Average Salary by Department');
ylabel('Average Salary');

% Pie chart of department distribution
subplot(2, 3, 6);
dept_counts = groupsummary(T, 'Department', 'count');
pie(dept_counts.GroupCount, dept_counts.Department);
title('Department Distribution');

sgtitle('Employee Data Analysis Dashboard');

%% 8. ADVANCED OPERATIONS - TABLE JOINS

fprintf('\n=== 8. ADVANCED OPERATIONS - TABLE JOINS ===\n\n');

% Create a second table with additional employee information
employee_ids = [1; 2; 3; 4; 5];
hire_dates = datetime({'2020-01-15'; '2019-03-20'; '2021-06-10'; '2020-11-05'; '2019-09-12'});
performance_scores = [85; 92; 78; 88; 95];

T2 = table(employee_ids, hire_dates, performance_scores, ...
    'VariableNames', {'ID', 'HireDate', 'PerformanceScore'});

fprintf('Second table (employee details):\n');
disp(T2);

% Add ID column to first table
T.ID = (1:height(T))';

% Inner join
T_joined = innerjoin(T, T2, 'Keys', 'ID');
fprintf('Joined table:\n');
disp(T_joined);

%% 9. ADVANCED OPERATIONS - PIVOT TABLES

fprintf('\n=== 9. ADVANCED OPERATIONS - PIVOT TABLES ===\n\n');

% Create pivot table: Department vs Age Group
pivot_table = unstack(groupsummary(T, {'Department', 'AgeGroup'}, 'mean', 'Salary'), ...
    'mean_Salary', 'AgeGroup');
fprintf('Pivot table: Average salary by Department and Age Group\n');
disp(pivot_table);

%% 10. DATA CLEANING AND PREPROCESSING

fprintf('\n=== 10. DATA CLEANING AND PREPROCESSING ===\n\n');

% Create table with some missing data
T_messy = T;
T_messy.Salary(3) = NaN;  % Add missing value
T_messy.Age(5) = NaN;     % Add another missing value

fprintf('Table with missing data:\n');
disp(T_messy);

% Check for missing values
missing_salary = ismissing(T_messy.Salary);
missing_age = ismissing(T_messy.Age);

fprintf('Missing salary values: %d\n', sum(missing_salary));
fprintf('Missing age values: %d\n', sum(missing_age));

% Remove rows with missing values
T_clean = rmmissing(T_messy);
fprintf('Table after removing missing values:\n');
disp(T_clean);

% Fill missing values with mean
T_filled = T_messy;
T_filled.Salary(missing_salary) = mean(T_messy.Salary, 'omitnan');
T_filled.Age(missing_age) = mean(T_messy.Age, 'omitnan');

fprintf('Table with filled missing values:\n');
disp(T_filled);

%% 11. STRING OPERATIONS ON TABULAR DATA

fprintf('\n=== 11. STRING OPERATIONS ON TABULAR DATA ===\n\n');

% Convert names to uppercase
T_upper = T;
T_upper.Name = upper(T_upper.Name);
fprintf('Names in uppercase:\n');
disp(T_upper.Name);

% Find names containing 'a'
names_with_a = contains(T.Name, 'a', 'IgnoreCase', true);
fprintf('Names containing ''a'': %s\n', strjoin(T.Name(names_with_a), ', '));

% Extract first letter of each name
first_letters = extract(T.Name, 1);
fprintf('First letters: %s\n', strjoin(first_letters, ', '));

%% 12. DATE AND TIME OPERATIONS

fprintf('\n=== 12. DATE AND TIME OPERATIONS ===\n\n');

% Calculate years of service
current_date = datetime('now');
years_of_service = years(current_date - T_joined.HireDate);
T_joined.YearsOfService = years_of_service;

fprintf('Years of service:\n');
disp(T_joined(:, {'Name', 'HireDate', 'YearsOfService'}));

% Find employees hired in 2020
hired_2020 = T_joined(year(T_joined.HireDate) == 2020, :);
fprintf('Employees hired in 2020:\n');
disp(hired_2020(:, {'Name', 'HireDate'}));

%% 13. EXPORTING RESULTS

fprintf('\n=== 13. EXPORTING RESULTS ===\n\n');

% Export summary statistics
writetable(department_stats, 'department_summary.csv');
fprintf('Department summary exported to department_summary.csv\n');

% Export joined table
writetable(T_joined, 'complete_employee_data.xlsx', 'Sheet', 'Complete Data');
fprintf('Complete employee data exported to complete_employee_data.xlsx\n');

% Create a summary report
fprintf('\n=== SUMMARY REPORT ===\n');
fprintf('Total employees: %d\n', height(T));
fprintf('Departments: %s\n', strjoin(unique(T.Department), ', '));
fprintf('Average age: %.1f years\n', mean(T.Age));
fprintf('Average salary: $%.2f\n', mean(T.Salary));
fprintf('Salary range: $%d - $%d\n', min(T.Salary), max(T.Salary));

% Clean up temporary files
delete('employee_data.csv');
delete('employee_data.xlsx');

fprintf('\n=== EXAMPLES COMPLETED ===\n');
fprintf('All examples have been executed successfully!\n');