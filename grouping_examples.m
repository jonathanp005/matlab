%% MATLAB Grouping Examples - Corrected Methods
% This script shows different ways to group data and display names by department

clear; clc;

% Create sample tabular data
data = table();
data.Name = {'Alice'; 'Bob'; 'Charlie'; 'Diana'; 'Eve'};
data.Age = [25; 30; 35; 28; 32];
data.Salary = [50000; 60000; 70000; 55000; 65000];
data.Department = {'Engineering'; 'Sales'; 'Engineering'; 'Marketing'; 'Sales'};

fprintf('Original data:\n');
disp(data);

%% Method 1: Using a loop with strcmp (Most straightforward)
fprintf('\n=== Method 1: Loop with strcmp ===\n');
departments = unique(data.Department);
for i = 1:length(departments)
    dept_data = data(strcmp(data.Department, departments{i}), :);
    names = dept_data.Name;
    fprintf('%s: %s\n', departments{i}, strjoin(names, ', '));
end

%% Method 2: Using findgroups and splitapply
fprintf('\n=== Method 2: findgroups and splitapply ===\n');
% Create groups
[groups, department_names] = findgroups(data.Department);

% Define a function to concatenate names
concatenateNames = @(names) strjoin(names, ', ');

% Apply the function to each group
grouped_names = splitapply(concatenateNames, data.Name, groups);

% Display results
for i = 1:length(department_names)
    fprintf('%s: %s\n', department_names{i}, grouped_names{i});
end

%% Method 3: Using groupsummary with custom function
fprintf('\n=== Method 3: groupsummary with custom function ===\n');
% Define a custom function to concatenate names
function result = concatNames(names)
    result = strjoin(names, ', ');
end

% Use groupsummary with the custom function
try
    grouped_data = groupsummary(data, 'Department', @concatNames, 'Name');
    fprintf('Names grouped by department:\n');
    for i = 1:height(grouped_data)
        fprintf('%s: %s\n', grouped_data.Department{i}, grouped_data.fun1_Name{i});
    end
catch ME
    fprintf('Error with groupsummary: %s\n', ME.message);
    fprintf('Using alternative approach...\n');
end

%% Method 4: Using varfun (Alternative approach)
fprintf('\n=== Method 4: varfun approach ===\n');
% Group by department and apply a function to names
try
    result = varfun(@(x) strjoin(x, ', '), data, 'GroupingVariables', 'Department', 'InputVariables', 'Name');
    fprintf('Names grouped by department:\n');
    for i = 1:height(result)
        fprintf('%s: %s\n', result.Department{i}, result.Fun_Name{i});
    end
catch ME
    fprintf('Error with varfun: %s\n', ME.message);
end

%% Method 5: Using accumarray (Most flexible)
fprintf('\n=== Method 5: accumarray approach ===\n');
% Get unique departments and their indices
[unique_depts, ~, idx] = unique(data.Department);

% Use accumarray to group names
grouped_names = accumarray(idx, (1:height(data))', [], @(x) strjoin(data.Name(x), ', '));

% Display results
for i = 1:length(unique_depts)
    fprintf('%s: %s\n', unique_depts{i}, grouped_names{i});
end

%% Method 6: Simple groupsummary for statistics (This works correctly)
fprintf('\n=== Method 6: groupsummary for statistics ===\n');
% This is the correct way to use groupsummary for numerical data
dept_stats = groupsummary(data, 'Department', {'mean', 'count', 'std'}, 'Salary');
fprintf('Department statistics:\n');
disp(dept_stats);

%% Method 7: Using categorical data for better performance
fprintf('\n=== Method 7: Using categorical data ===\n');
% Convert department to categorical for better performance
data_cat = data;
data_cat.Department = categorical(data.Department);

% Group by categorical department
departments_cat = categories(data_cat.Department);
for i = 1:length(departments_cat)
    dept_data = data_cat(data_cat.Department == departments_cat{i}, :);
    names = dept_data.Name;
    fprintf('%s: %s\n', departments_cat{i}, strjoin(names, ', '));
end

fprintf('\nAll grouping methods completed!\n');