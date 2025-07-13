% Sampling from a Multivariate Gaussian distribution given a mean vector 'm', Covariance matrix 'P' 
% and number of samples 'N'
%%% Let m be a k-dimensional real vector, and P be a k x k real invertible matrix
%%% Idea: 
%%%  1) Decompose the covariance matrix P using Cholesky decomposition: P = L* transpose(L), 
%%%  2) Generate Z = [z1 z2 .... zN] where each z_i is a k-dimensional vector 
%%%     sampled from a standard k-dimensional Gaussian distribution, mean 0
%%%     and covariance matrix Identity
%%%  3) Return X = [x1 x2 .... xN], where x_i = m + L*z_i

%%% Why does it work? Note E[x_i] = E[m + L*z_i] = m + L*E[z_i] = m (as E[z_i] = 0)
%%%  E[ ( x_i - m) transpose(x_i - m) ] = L * E[z_i * transpose(z_i) ] * transpose(L) = L * Id * transpose(L) = P 

function X = gauss_rnd(m, P, N)
    L = chol(P, 'lower'); % Cholesky decomposition
    Z = randn(length(m), N); % Standard normal samples
    X = repmat(m, 1, N) + L * Z; % Shift and scale
end