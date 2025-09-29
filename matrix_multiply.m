% Matrix Multiplication Example
% This script demonstrates basic matrix multiplication in MATLAB

% Clear workspace and command window
clear; clc;

fprintf('=== Matrix Multiplication Example ===\n\n');

% Define two matrices
A = [1 2 3; 4 5 6; 7 8 9];  % 3x3 matrix
B = [2 0 1; 1 2 0; 0 1 2];  % 3x3 matrix

% Display the matrices
fprintf('Matrix A (3x3):\n');
disp(A);

fprintf('Matrix B (3x3):\n');
disp(B);

% Perform matrix multiplication
C = A * B;

% Display the result
fprintf('Result C = A * B:\n');
disp(C);

% Verify with manual calculation for first element
fprintf('Verification - First element of C:\n');
fprintf('C(1,1) = A(1,:) * B(:,1) = [%d %d %d] * [%d; %d; %d] = %d\n', ...
    A(1,1), A(1,2), A(1,3), B(1,1), B(2,1), B(3,1), C(1,1));

% Additional examples with different sizes
fprintf('\n=== Additional Examples ===\n');

% 2x3 and 3x2 matrices
D = [1 2 3; 4 5 6];  % 2x3 matrix
E = [1 2; 3 4; 5 6]; % 3x2 matrix

fprintf('Matrix D (2x3):\n');
disp(D);
fprintf('Matrix E (3x2):\n');
disp(E);

F = D * E;  % Result will be 2x2
fprintf('Result F = D * E (2x2):\n');
disp(F);

% Element-wise multiplication (Hadamard product)
fprintf('\nElement-wise multiplication A .* B:\n');
G = A .* B;
disp(G);

% Matrix properties
fprintf('\n=== Matrix Properties ===\n');
fprintf('Size of A: %dx%d\n', size(A,1), size(A,2));
fprintf('Size of B: %dx%d\n', size(B,1), size(B,2));
fprintf('Size of C: %dx%d\n', size(C,1), size(C,2));

% Check if matrices are square
if size(A,1) == size(A,2)
    fprintf('Matrix A is square\n');
end

if size(B,1) == size(B,2)
    fprintf('Matrix B is square\n');
end

fprintf('\nMatrix multiplication completed successfully!\n');