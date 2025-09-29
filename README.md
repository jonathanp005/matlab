# MATLAB Matrix Multiplication Archive

This archive contains a simple MATLAB script demonstrating matrix multiplication operations.

## Files

- `matrix_multiply.m` - Main MATLAB script with matrix multiplication examples
- `README.md` - This documentation file

## Usage

1. Extract the archive to your desired location
2. Open MATLAB
3. Navigate to the extracted directory
4. Run the script by typing: `matrix_multiply`

## What the Script Does

The `matrix_multiply.m` script demonstrates:

- Basic matrix multiplication using the `*` operator
- Matrix display and formatting
- Verification of calculations
- Examples with different matrix sizes (3x3, 2x3, 3x2)
- Element-wise multiplication using the `.*` operator
- Matrix property analysis

## Example Output

The script will display:
- Two 3x3 matrices (A and B)
- The result of A * B
- Verification calculations
- Additional examples with different matrix dimensions
- Matrix properties and sizes

## Requirements

- MATLAB (any recent version)
- No additional toolboxes required

## Matrix Multiplication Rules

- For matrices A (m×n) and B (p×q), multiplication A*B is only possible if n = p
- The result will be a matrix of size m×q
- Element (i,j) of the result is the dot product of row i of A and column j of B

## Notes

- The script includes clear comments explaining each operation
- All variables are displayed for educational purposes
- The script clears the workspace at the beginning for clean execution