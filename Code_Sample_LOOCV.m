%%%%%This is a homework assignment for a PhD level Microeconometrics course
%%%%%at North Carolina State University. The "Wage" dataset contains hourly
%%%%%wage and ASVAB score, a proxy used to approximate ability. In this
%%%%%assignment, I use leave-one-out cross validation to estimate the
%%%%%relationship between ASVAB score and wage. Please note the
%%%%%"Mean_Squared_Errors.m" file and the "wage.xlsx" file must be uploaded to your MATLAB
%%%%%directory, or the objective function will not run. 

%Import Excel data
data = xlsread('wage.xlsx');

%Data setup. X = ASVAB Score, Y = Wage
Y_1a = data(:,1);   
X = data(:,2);
N = length(Y_1a);

%Bandwidth selection
H = 1.111;

%Leave one out cross validation using unconstrained optimization
OPTIONS = optimset('MaxIter', 1000,'MaxFunEvals', 1e5, 'Display', 'off');[H] = fminunc(@(H)Mean_Squared_Errors(Y_1a, X,H), H, OPTIONS);
H 

%Gaussian Kernel function setup
Kernel = normpdf((X-X')/H);
F_Hat = (sum(Kernel));
m_hat = (Y_1a'*Kernel);
Y_Hat = (m_hat./F_Hat)';

%Scatterplot of Leave-One-Out Cross Validation nonparametric regression. We see that wage tends to
%peak around the 50-60th percentile of ASVAB scores
scatter(X,Y_Hat)

