%% MATLAB Tabular Data Processing - Exam Practice Problems
% This file contains practice problems for exam preparation

clear; clc; close all;

%% Problem 1: Student Grade Analysis
% Create a table with student data and perform various analyses

fprintf('=== PROBLEM 1: STUDENT GRADE ANALYSIS ===\n\n');

% Sample student data
student_names = {'John Smith'; 'Jane Doe'; 'Mike Johnson'; 'Sarah Wilson'; 'David Brown'; ...
                'Lisa Garcia'; 'Tom Anderson'; 'Emma Davis'; 'Chris Lee'; 'Anna Martinez'};
math_scores = [85; 92; 78; 88; 95; 82; 90; 87; 93; 89];
english_scores = [88; 85; 92; 90; 87; 94; 86; 91; 89; 93];
science_scores = [90; 87; 85; 92; 88; 91; 89; 86; 94; 87];
genders = {'M'; 'F'; 'M'; 'F'; 'M'; 'F'; 'M'; 'F'; 'M'; 'F'};

% Create student table
students = table(student_names, math_scores, english_scores, science_scores, genders, ...
    'VariableNames', {'Name', 'Math', 'English', 'Science', 'Gender'});

fprintf('Student data:\n');
disp(students);

% Calculate average score for each student
students.Average = (students.Math + students.English + students.Science) / 3;

% Determine letter grades
students.LetterGrade = cell(height(students), 1);
for i = 1:height(students)
    if students.Average(i) >= 90
        students.LetterGrade{i} = 'A';
    elseif students.Average(i) >= 80
        students.LetterGrade{i} = 'B';
    elseif students.Average(i) >= 70
        students.LetterGrade{i} = 'C';
    elseif students.Average(i) >= 60
        students.Average(i) = 'D';
    else
        students.LetterGrade{i} = 'F';
    end
end

fprintf('Students with calculated averages and grades:\n');
disp(students);

% Find top 3 students
top_students = sortrows(students, 'Average', 'descend');
fprintf('Top 3 students:\n');
disp(top_students(1:3, {'Name', 'Average', 'LetterGrade'}));

% Statistics by gender
gender_stats = groupsummary(students, 'Gender', {'mean', 'std'}, {'Math', 'English', 'Science', 'Average'});
fprintf('Statistics by gender:\n');
disp(gender_stats);

%% Problem 2: Sales Data Analysis
% Analyze monthly sales data with multiple product categories

fprintf('\n=== PROBLEM 2: SALES DATA ANALYSIS ===\n\n');

% Generate sales data
months = {'Jan'; 'Feb'; 'Mar'; 'Apr'; 'May'; 'Jun'; 'Jul'; 'Aug'; 'Sep'; 'Oct'; 'Nov'; 'Dec'};
electronics_sales = [12000; 15000; 18000; 16000; 20000; 22000; 25000; 23000; 19000; 17000; 14000; 16000];
clothing_sales = [8000; 9000; 12000; 15000; 18000; 16000; 14000; 13000; 11000; 10000; 12000; 15000];
books_sales = [3000; 3500; 4000; 4500; 5000; 4800; 4200; 3800; 3600; 4000; 4500; 5000];

sales_data = table(months, electronics_sales, clothing_sales, books_sales, ...
    'VariableNames', {'Month', 'Electronics', 'Clothing', 'Books'});

fprintf('Sales data:\n');
disp(sales_data);

% Calculate total sales for each month
sales_data.Total = sales_data.Electronics + sales_data.Clothing + sales_data.Books;

% Find best and worst performing months
[~, best_month_idx] = max(sales_data.Total);
[~, worst_month_idx] = min(sales_data.Total);

fprintf('Best performing month: %s (Total: $%d)\n', ...
    sales_data.Month{best_month_idx}, sales_data.Total(best_month_idx));
fprintf('Worst performing month: %s (Total: $%d)\n', ...
    sales_data.Month{worst_month_idx}, sales_data.Total(worst_month_idx));

% Calculate quarterly totals
Q1_total = sum(sales_data.Total(1:3));
Q2_total = sum(sales_data.Total(4:6));
Q3_total = sum(sales_data.Total(7:9));
Q4_total = sum(sales_data.Total(10:12));

fprintf('Quarterly totals:\n');
fprintf('Q1: $%d\n', Q1_total);
fprintf('Q2: $%d\n', Q2_total);
fprintf('Q3: $%d\n', Q3_total);
fprintf('Q4: $%d\n', Q4_total);

% Find the best performing category
category_totals = [sum(sales_data.Electronics), sum(sales_data.Clothing), sum(sales_data.Books)];
category_names = {'Electronics', 'Clothing', 'Books'};
[~, best_category_idx] = max(category_totals);

fprintf('Best performing category: %s (Total: $%d)\n', ...
    category_names{best_category_idx}, category_totals(best_category_idx));

%% Problem 3: Weather Data Processing
% Process and analyze weather station data

fprintf('\n=== PROBLEM 3: WEATHER DATA PROCESSING ===\n\n');

% Generate weather data
dates = datetime(2023, 1, 1):days(1):datetime(2023, 1, 31);
temperatures = 20 + 10*sin(2*pi*(1:31)/31) + 5*randn(1, 31);
humidity = 60 + 20*rand(1, 31);
pressure = 1013 + 10*randn(1, 31);
wind_speed = 5 + 3*rand(1, 31);

weather = table(dates', temperatures', humidity', pressure', wind_speed', ...
    'VariableNames', {'Date', 'Temperature', 'Humidity', 'Pressure', 'WindSpeed'});

fprintf('Weather data (first 10 days):\n');
disp(weather(1:10, :));

% Calculate daily weather conditions
weather.Condition = cell(height(weather), 1);
for i = 1:height(weather)
    if weather.Temperature(i) > 25 && weather.Humidity(i) < 70
        weather.Condition{i} = 'Sunny';
    elseif weather.Temperature(i) < 15
        weather.Condition{i} = 'Cold';
    elseif weather.Humidity(i) > 80
        weather.Condition{i} = 'Humid';
    else
        weather.Condition{i} = 'Mild';
    end
end

% Find extreme weather days
hot_days = weather(weather.Temperature > 30, :);
cold_days = weather(weather.Temperature < 10, :);
windy_days = weather(weather.WindSpeed > 8, :);

fprintf('Extreme weather days:\n');
fprintf('Hot days (>30°C): %d\n', height(hot_days));
fprintf('Cold days (<10°C): %d\n', height(cold_days));
fprintf('Windy days (>8 m/s): %d\n', height(windy_days));

% Monthly statistics
fprintf('Monthly weather statistics:\n');
fprintf('Average temperature: %.1f°C\n', mean(weather.Temperature));
fprintf('Temperature range: %.1f°C to %.1f°C\n', min(weather.Temperature), max(weather.Temperature));
fprintf('Average humidity: %.1f%%\n', mean(weather.Humidity));
fprintf('Average wind speed: %.1f m/s\n', mean(weather.WindSpeed));

%% Problem 4: Employee Performance Review
% Analyze employee performance data with multiple criteria

fprintf('\n=== PROBLEM 4: EMPLOYEE PERFORMANCE REVIEW ===\n\n');

% Employee performance data
emp_names = {'Alice Johnson'; 'Bob Smith'; 'Carol Davis'; 'David Wilson'; 'Eva Brown'; ...
            'Frank Miller'; 'Grace Lee'; 'Henry Taylor'; 'Ivy Chen'; 'Jack Anderson'};
departments = {'Engineering'; 'Marketing'; 'Engineering'; 'Sales'; 'HR'; ...
              'Engineering'; 'Marketing'; 'Sales'; 'Engineering'; 'HR'};
years_experience = [5; 3; 8; 2; 6; 4; 7; 1; 9; 3];
projects_completed = [12; 8; 15; 5; 10; 9; 11; 3; 18; 7];
customer_rating = [4.5; 4.2; 4.8; 3.9; 4.6; 4.3; 4.7; 3.5; 4.9; 4.1];
salary = [75000; 55000; 95000; 45000; 65000; 70000; 60000; 40000; 100000; 50000];

employees = table(emp_names, departments, years_experience, projects_completed, ...
    customer_rating, salary, 'VariableNames', ...
    {'Name', 'Department', 'Experience', 'Projects', 'Rating', 'Salary'});

fprintf('Employee performance data:\n');
disp(employees);

% Calculate performance score (weighted combination)
employees.PerformanceScore = 0.3 * employees.Projects + ...
                           0.4 * employees.Rating * 10 + ...
                           0.3 * employees.Experience;

% Rank employees by performance
employees_ranked = sortrows(employees, 'PerformanceScore', 'descend');
employees_ranked.Rank = (1:height(employees_ranked))';

fprintf('Employees ranked by performance:\n');
disp(employees_ranked(:, {'Rank', 'Name', 'Department', 'PerformanceScore'}));

% Department analysis
dept_analysis = groupsummary(employees, 'Department', ...
    {'mean', 'count'}, {'PerformanceScore', 'Salary'});
fprintf('Department analysis:\n');
disp(dept_analysis);

% Identify top performers (top 25%)
top_25_percent = round(height(employees) * 0.25);
top_performers = employees_ranked(1:top_25_percent, :);
fprintf('Top 25%% performers:\n');
disp(top_performers(:, {'Name', 'Department', 'PerformanceScore'}));

% Salary vs Performance correlation
correlation = corrcoef(employees.Salary, employees.PerformanceScore);
fprintf('Correlation between salary and performance: %.3f\n', correlation(1,2));

%% Problem 5: Customer Purchase Analysis
% Analyze customer purchase patterns and behavior

fprintf('\n=== PROBLEM 5: CUSTOMER PURCHASE ANALYSIS ===\n\n');

% Generate customer purchase data
customer_ids = (1:50)';
ages = randi([18, 65], 50, 1);
genders = cell(50, 1);
genders(rand(50, 1) > 0.5) = {'M'};
genders(rand(50, 1) <= 0.5) = {'F'};
purchase_amounts = 50 + 200 * rand(50, 1);
purchase_frequency = randi([1, 12], 50, 1);
membership_years = randi([0, 5], 50, 1);

customers = table(customer_ids, ages, genders, purchase_amounts, ...
    purchase_frequency, membership_years, 'VariableNames', ...
    {'CustomerID', 'Age', 'Gender', 'PurchaseAmount', 'Frequency', 'MembershipYears'});

fprintf('Customer data (first 10 customers):\n');
disp(customers(1:10, :));

% Calculate customer lifetime value (CLV)
customers.CLV = customers.PurchaseAmount .* customers.Frequency .* (customers.MembershipYears + 1);

% Segment customers by value
customers.Segment = cell(height(customers), 1);
for i = 1:height(customers)
    if customers.CLV(i) > 2000
        customers.Segment{i} = 'High Value';
    elseif customers.CLV(i) > 1000
        customers.Segment{i} = 'Medium Value';
    else
        customers.Segment{i} = 'Low Value';
    end
end

% Analyze segments
segment_analysis = groupsummary(customers, 'Segment', ...
    {'mean', 'count'}, {'Age', 'PurchaseAmount', 'Frequency', 'CLV'});
fprintf('Customer segment analysis:\n');
disp(segment_analysis);

% Gender analysis
gender_analysis = groupsummary(customers, 'Gender', ...
    {'mean', 'count'}, {'Age', 'PurchaseAmount', 'CLV'});
fprintf('Gender analysis:\n');
disp(gender_analysis);

% Find top 10 customers by CLV
top_customers = sortrows(customers, 'CLV', 'descend');
fprintf('Top 10 customers by CLV:\n');
disp(top_customers(1:10, {'CustomerID', 'Age', 'Gender', 'CLV', 'Segment'}));

%% Problem 6: Data Quality Assessment
% Assess and clean data quality issues

fprintf('\n=== PROBLEM 6: DATA QUALITY ASSESSMENT ===\n\n');

% Create dataset with quality issues
problematic_data = customers;
% Introduce missing values
problematic_data.Age(rand(50, 1) < 0.1) = NaN;
problematic_data.PurchaseAmount(rand(50, 1) < 0.05) = NaN;
% Introduce outliers
problematic_data.PurchaseAmount(1) = 10000; % Extreme outlier
problematic_data.Age(2) = 150; % Impossible age

fprintf('Data quality issues introduced:\n');
fprintf('Missing ages: %d\n', sum(ismissing(problematic_data.Age)));
fprintf('Missing purchase amounts: %d\n', sum(ismissing(problematic_data.PurchaseAmount)));

% Identify outliers using IQR method
Q1_age = quantile(problematic_data.Age, 0.25);
Q3_age = quantile(problematic_data.Age, 0.75);
IQR_age = Q3_age - Q1_age;
age_outliers = problematic_data.Age < (Q1_age - 1.5*IQR_age) | ...
               problematic_data.Age > (Q3_age + 1.5*IQR_age);

Q1_amount = quantile(problematic_data.PurchaseAmount, 0.25);
Q3_amount = quantile(problematic_data.PurchaseAmount, 0.75);
IQR_amount = Q3_amount - Q1_amount;
amount_outliers = problematic_data.PurchaseAmount < (Q1_amount - 1.5*IQR_amount) | ...
                 problematic_data.PurchaseAmount > (Q3_amount + 1.5*IQR_amount);

fprintf('Age outliers detected: %d\n', sum(age_outliers));
fprintf('Purchase amount outliers detected: %d\n', sum(amount_outliers));

% Clean the data
cleaned_data = problematic_data;
% Remove rows with missing critical data
cleaned_data = rmmissing(cleaned_data, 'DataVariables', {'Age', 'PurchaseAmount'});
% Cap outliers
cleaned_data.Age(cleaned_data.Age > 100) = 100;
cleaned_data.PurchaseAmount(cleaned_data.PurchaseAmount > 500) = 500;

fprintf('Data after cleaning:\n');
fprintf('Original rows: %d\n', height(problematic_data));
fprintf('Cleaned rows: %d\n', height(cleaned_data));
fprintf('Rows removed: %d\n', height(problematic_data) - height(cleaned_data));

%% Summary of All Problems
fprintf('\n=== SUMMARY OF ALL PROBLEMS ===\n');
fprintf('Problem 1: Student Grade Analysis - Completed\n');
fprintf('Problem 2: Sales Data Analysis - Completed\n');
fprintf('Problem 3: Weather Data Processing - Completed\n');
fprintf('Problem 4: Employee Performance Review - Completed\n');
fprintf('Problem 5: Customer Purchase Analysis - Completed\n');
fprintf('Problem 6: Data Quality Assessment - Completed\n');
fprintf('\nAll practice problems completed successfully!\n');