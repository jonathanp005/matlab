%% MATLAB Table Functions Reference Guide
% Quick reference for common table operations in MATLAB
% Useful for exam preparation and quick lookup

clear; clc;

%% 1. TABLE CREATION AND BASIC OPERATIONS

fprintf('=== 1. TABLE CREATION AND BASIC OPERATIONS ===\n\n');

% Create table from arrays
names = {'Alice'; 'Bob'; 'Charlie'};
ages = [25; 30; 35];
salaries = [50000; 60000; 70000];

% Method 1: Using table() function
T = table(names, ages, salaries, 'VariableNames', {'Name', 'Age', 'Salary'});

% Method 2: From workspace variables
T2 = table(names, ages, salaries);

% Method 3: Empty table with specified variables
T3 = table('Size', [0, 3], 'VariableTypes', {'string', 'double', 'double'}, ...
    'VariableNames', {'Name', 'Age', 'Salary'});

fprintf('Table creation examples:\n');
disp(T);

%% 2. READING AND WRITING TABLES

fprintf('\n=== 2. READING AND WRITING TABLES ===\n\n');

% Write to different formats
writetable(T, 'data.csv');           % CSV file
writetable(T, 'data.xlsx');          % Excel file
writetable(T, 'data.txt');           % Text file

% Read from different formats
T_csv = readtable('data.csv');
T_excel = readtable('data.xlsx');
T_text = readtable('data.txt');

% Read with options
T_options = readtable('data.csv', 'ReadVariableNames', true, 'Delimiter', ',');

fprintf('Reading/writing operations completed\n');

%% 3. TABLE ACCESS AND INDEXING

fprintf('\n=== 3. TABLE ACCESS AND INDEXING ===\n\n');

% Access entire table
fprintf('Entire table:\n');
disp(T);

% Access specific columns
fprintf('Name column: %s\n', strjoin(T.Name, ', '));
fprintf('Age column: %s\n', mat2str(T.Age));

% Access specific rows
fprintf('First row:\n');
disp(T(1, :));

% Access specific cells
fprintf('Age of first person: %d\n', T.Age(1));
fprintf('Salary of second person: %d\n', T{2, 'Salary'});

% Access using logical indexing
young_employees = T(T.Age < 30, :);
fprintf('Young employees:\n');
disp(young_employees);

%% 4. TABLE MANIPULATION

fprintf('\n=== 4. TABLE MANIPULATION ===\n\n');

% Add new column
T.Department = {'IT'; 'HR'; 'IT'};
fprintf('Table with new department column:\n');
disp(T);

% Add new row
new_row = {'Diana', 28, 55000, 'Finance'};
T = [T; new_row];
fprintf('Table with new row:\n');
disp(T);

% Remove column
T.Department = [];
fprintf('Table after removing department column:\n');
disp(T);

% Remove row
T(4, :) = [];
fprintf('Table after removing last row:\n');
disp(T);

%% 5. SORTING AND FILTERING

fprintf('\n=== 5. SORTING AND FILTERING ===\n\n');

% Sort by single column
T_sorted = sortrows(T, 'Age');
fprintf('Sorted by age:\n');
disp(T_sorted);

% Sort by multiple columns
T_sorted_multi = sortrows(T, {'Age', 'Salary'}, {'ascend', 'descend'});
fprintf('Sorted by age (asc) then salary (desc):\n');
disp(T_sorted_multi);

% Filter using logical conditions
high_salary = T(T.Salary > 60000, :);
fprintf('High salary employees:\n');
disp(high_salary);

% Filter using ismember
IT_employees = T(ismember(T.Department, 'IT'), :);

%% 6. GROUPING AND AGGREGATION

fprintf('\n=== 6. GROUPING AND AGGREGATION ===\n\n');

% Add department column back for grouping
T.Department = {'IT'; 'HR'; 'IT'};

% Group by department and calculate statistics
dept_stats = groupsummary(T, 'Department', {'mean', 'std', 'count'}, 'Salary');
fprintf('Department statistics:\n');
disp(dept_stats);

% Group by multiple columns
T.AgeGroup = discretize(T.Age, [0, 30, 40, Inf], 'categorical', {'Young', 'Middle', 'Senior'});
age_dept_stats = groupsummary(T, {'Department', 'AgeGroup'}, 'mean', 'Salary');
fprintf('Statistics by department and age group:\n');
disp(age_dept_stats);

%% 7. TABLE JOINS

fprintf('\n=== 7. TABLE JOINS ===\n\n');

% Create second table
employee_ids = [1; 2; 3];
hire_dates = datetime({'2020-01-15'; '2019-03-20'; '2021-06-10'});
performance_scores = [85; 92; 78];

T2 = table(employee_ids, hire_dates, performance_scores, ...
    'VariableNames', {'ID', 'HireDate', 'PerformanceScore'});

% Add ID to first table
T.ID = (1:height(T))';

% Inner join
T_joined = innerjoin(T, T2, 'Keys', 'ID');
fprintf('Inner join result:\n');
disp(T_joined);

% Left join
T_left = outerjoin(T, T2, 'Keys', 'ID', 'MergeKeys', true);
fprintf('Left join result:\n');
disp(T_left);

%% 8. PIVOT TABLES

fprintf('\n=== 8. PIVOT TABLES ===\n\n');

% Create pivot table
pivot_result = unstack(groupsummary(T, {'Department', 'AgeGroup'}, 'mean', 'Salary'), ...
    'mean_Salary', 'AgeGroup');
fprintf('Pivot table result:\n');
disp(pivot_result);

%% 9. MISSING DATA HANDLING

fprintf('\n=== 9. MISSING DATA HANDLING ===\n\n');

% Create table with missing data
T_missing = T;
T_missing.Salary(2) = NaN;
T_missing.Age(3) = NaN;

fprintf('Table with missing data:\n');
disp(T_missing);

% Check for missing values
missing_salary = ismissing(T_missing.Salary);
missing_age = ismissing(T_missing.Age);

fprintf('Missing salary values: %d\n', sum(missing_salary));
fprintf('Missing age values: %d\n', sum(missing_age));

% Remove rows with missing values
T_clean = rmmissing(T_missing);
fprintf('Table after removing missing values:\n');
disp(T_clean);

% Fill missing values
T_filled = T_missing;
T_filled.Salary(missing_salary) = mean(T_missing.Salary, 'omitnan');
T_filled.Age(missing_age) = mean(T_missing.Age, 'omitnan');

fprintf('Table with filled missing values:\n');
disp(T_filled);

%% 10. STRING OPERATIONS

fprintf('\n=== 10. STRING OPERATIONS ===\n\n');

% String manipulation
T_string = T;
T_string.Name = upper(T_string.Name);
fprintf('Names in uppercase: %s\n', strjoin(T_string.Name, ', '));

% Find names containing specific text
names_with_a = contains(T.Name, 'a', 'IgnoreCase', true);
fprintf('Names containing ''a'': %s\n', strjoin(T.Name(names_with_a), ', '));

% Extract parts of strings
first_letters = extract(T.Name, 1);
fprintf('First letters: %s\n', strjoin(first_letters, ', '));

%% 11. DATE AND TIME OPERATIONS

fprintf('\n=== 11. DATE AND TIME OPERATIONS ===\n\n');

% Add date column
T_dates = T;
T_dates.HireDate = datetime({'2020-01-15'; '2019-03-20'; '2021-06-10'});

% Calculate time differences
current_date = datetime('now');
years_of_service = years(current_date - T_dates.HireDate);
T_dates.YearsOfService = years_of_service;

fprintf('Years of service:\n');
disp(T_dates(:, {'Name', 'HireDate', 'YearsOfService'}));

% Filter by date
recent_hires = T_dates(year(T_dates.HireDate) >= 2020, :);
fprintf('Recent hires (2020+):\n');
disp(recent_hires(:, {'Name', 'HireDate'}));

%% 12. STATISTICAL FUNCTIONS

fprintf('\n=== 12. STATISTICAL FUNCTIONS ===\n\n');

% Basic statistics
fprintf('Age statistics:\n');
fprintf('  Mean: %.2f\n', mean(T.Age));
fprintf('  Median: %.2f\n', median(T.Age));
fprintf('  Std: %.2f\n', std(T.Age));
fprintf('  Min: %d\n', min(T.Age));
fprintf('  Max: %d\n', max(T.Age));

% Correlation
correlation = corrcoef(T.Age, T.Salary);
fprintf('Correlation (Age vs Salary): %.3f\n', correlation(1,2));

% Quantiles
age_quantiles = quantile(T.Age, [0.25, 0.5, 0.75]);
fprintf('Age quantiles (25%%, 50%%, 75%%): %.1f, %.1f, %.1f\n', age_quantiles);

%% 13. TABLE PROPERTIES AND METADATA

fprintf('\n=== 13. TABLE PROPERTIES AND METADATA ===\n\n');

% Table properties
fprintf('Table size: %d rows, %d columns\n', height(T), width(T));
fprintf('Variable names: %s\n', strjoin(T.Properties.VariableNames, ', '));
fprintf('Variable types: %s\n', strjoin(T.Properties.VariableTypes, ', '));

% Add description
T.Properties.Description = 'Employee data table';
fprintf('Table description: %s\n', T.Properties.Description);

% Add variable descriptions
T.Properties.VariableDescriptions = {'Employee name', 'Age in years', 'Annual salary'};
fprintf('Variable descriptions: %s\n', strjoin(T.Properties.VariableDescriptions, ', '));

%% 14. CONVERSION FUNCTIONS

fprintf('\n=== 14. CONVERSION FUNCTIONS ===\n\n');

% Convert to array
age_array = table2array(T(:, 'Age'));
fprintf('Age as array: %s\n', mat2str(age_array));

% Convert to cell array
T_cell = table2cell(T);
fprintf('Table as cell array (first row): %s\n', strjoin(T_cell(1, :), ', '));

% Convert to struct
T_struct = table2struct(T);
fprintf('Table as struct (first element): Name=%s, Age=%d, Salary=%d\n', ...
    T_struct(1).Name, T_struct(1).Age, T_struct(1).Salary);

%% 15. USEFUL FUNCTIONS SUMMARY

fprintf('\n=== 15. USEFUL FUNCTIONS SUMMARY ===\n\n');

fprintf('Table Creation:\n');
fprintf('  table() - Create table from arrays\n');
fprintf('  array2table() - Convert array to table\n');
fprintf('  cell2table() - Convert cell array to table\n\n');

fprintf('File I/O:\n');
fprintf('  readtable() - Read table from file\n');
fprintf('  writetable() - Write table to file\n\n');

fprintf('Data Manipulation:\n');
fprintf('  sortrows() - Sort table rows\n');
fprintf('  groupsummary() - Group and aggregate data\n');
fprintf('  innerjoin() - Inner join tables\n');
fprintf('  outerjoin() - Outer join tables\n');
fprintf('  unstack() - Create pivot table\n\n');

fprintf('Data Cleaning:\n');
fprintf('  ismissing() - Check for missing values\n');
fprintf('  rmmissing() - Remove missing values\n');
fprintf('  fillmissing() - Fill missing values\n\n');

fprintf('Table Properties:\n');
fprintf('  height() - Number of rows\n');
fprintf('  width() - Number of columns\n');
fprintf('  summary() - Table summary\n\n');

% Clean up temporary files
delete('data.csv');
delete('data.xlsx');
delete('data.txt');

fprintf('=== REFERENCE GUIDE COMPLETED ===\n');