# MATLAB Tabular Data Processing Examples

This repository contains comprehensive examples for processing tabular data in MATLAB, designed for exam preparation and learning.

## Files Overview

### 1. `matlab_tabular_data_examples.m`
**Main comprehensive examples file** covering all essential tabular data operations:

- **Basic Table Operations**: Creating tables, accessing data, table properties
- **Reading and Writing**: CSV, Excel, and text file operations
- **Data Manipulation**: Filtering, sorting, grouping, and aggregation
- **Statistical Analysis**: Mean, median, correlation, t-tests
- **Data Visualization**: Histograms, scatter plots, box plots, bar charts
- **Advanced Operations**: Table joins, pivot tables, data cleaning
- **String Operations**: Text manipulation on table data
- **Date/Time Operations**: Working with datetime data
- **Exporting Results**: Saving processed data

### 2. `matlab_exam_practice_problems.m`
**Practice problems** with real-world scenarios:

- **Problem 1**: Student Grade Analysis - Calculate averages, letter grades, statistics by gender
- **Problem 2**: Sales Data Analysis - Monthly sales, quarterly totals, category performance
- **Problem 3**: Weather Data Processing - Temperature analysis, extreme weather detection
- **Problem 4**: Employee Performance Review - Performance scoring, ranking, department analysis
- **Problem 5**: Customer Purchase Analysis - Customer segmentation, lifetime value calculation
- **Problem 6**: Data Quality Assessment - Missing data handling, outlier detection, data cleaning

### 3. `matlab_table_functions_reference.m`
**Quick reference guide** for common table operations:

- Function syntax and usage examples
- Table creation methods
- Data access patterns
- Manipulation techniques
- Statistical functions
- Conversion methods
- Complete function summary

## Key Learning Objectives

After working through these examples, you should be able to:

### Basic Operations
- Create tables from different data sources
- Read and write tables to/from files
- Access table data using various indexing methods
- Understand table properties and metadata

### Data Manipulation
- Filter data using logical conditions
- Sort tables by single or multiple columns
- Group data and perform aggregations
- Handle missing data appropriately

### Statistical Analysis
- Calculate descriptive statistics
- Perform correlation analysis
- Conduct hypothesis tests
- Generate summary reports

### Advanced Techniques
- Join tables using different join types
- Create pivot tables for data summarization
- Clean and preprocess data
- Work with datetime and string data

## Exam Preparation Tips

### 1. Practice Common Patterns
- **Filtering**: `T(condition, :)` for row filtering
- **Sorting**: `sortrows(T, 'column')` for single column sorting
- **Grouping**: `groupsummary(T, 'group_var', 'function', 'data_var')`
- **Joins**: `innerjoin(T1, T2, 'Keys', 'key_column')`

### 2. Memorize Key Functions
- `table()` - Create tables
- `readtable()` / `writetable()` - File I/O
- `sortrows()` - Sort data
- `groupsummary()` - Group and aggregate
- `ismissing()` / `rmmissing()` - Handle missing data
- `innerjoin()` / `outerjoin()` - Join tables

### 3. Understand Data Types
- **Categorical**: For grouping variables
- **Datetime**: For time series data
- **String**: For text data
- **Double**: For numeric data

### 4. Common Exam Scenarios
- **Data cleaning**: Remove outliers, handle missing values
- **Data summarization**: Calculate statistics by groups
- **Data visualization**: Create appropriate plots
- **Data export**: Save results in different formats

## Running the Examples

1. **Start with the main examples**: Run `matlab_tabular_data_examples.m` to see comprehensive demonstrations
2. **Practice with problems**: Work through `matlab_exam_practice_problems.m` step by step
3. **Use the reference**: Consult `matlab_table_functions_reference.m` for quick function lookup

## Sample Data

The examples use realistic sample data including:
- Employee information (names, ages, salaries, departments)
- Student grades (multiple subjects, gender analysis)
- Sales data (monthly, by category)
- Weather data (temperature, humidity, pressure)
- Customer data (purchase patterns, demographics)

## Common Pitfalls to Avoid

1. **Indexing errors**: Remember that table indexing uses `{}` for cell access and `()` for table access
2. **Data type mismatches**: Ensure consistent data types when performing operations
3. **Missing data**: Always check for and handle missing values appropriately
4. **Variable names**: Use consistent naming conventions and check for spaces/special characters
5. **File paths**: Use absolute paths or ensure files are in the MATLAB path

## Additional Resources

- MATLAB Documentation: [Tables and Categorical Arrays](https://www.mathworks.com/help/matlab/tables.html)
- MATLAB Examples: [Working with Tables](https://www.mathworks.com/help/matlab/examples.html?category=working-with-tables)
- MATLAB Central: [File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/) for additional table utilities

## Exam Success Strategy

1. **Understand the concepts**: Don't just memorize syntax
2. **Practice regularly**: Work through examples multiple times
3. **Test your knowledge**: Try to solve problems without looking at solutions
4. **Focus on common patterns**: Most exam questions follow similar patterns
5. **Time management**: Practice working efficiently under time constraints

Good luck with your exam preparation!