%%% Roulette Wheel Selection
%%% See  [ https://keithschwarz.com/darts-dice-coins/ for] details

%%% Given a discrete Probability distribution 'Prob', the function returns N samples 

function y = Roulette_Wheel(Prob , N)

%Cumulative distribution
A  = cumsum(Prob);
% Generation of N samples
sample = zeros(1,N);
for iter = 1:N
    x =  rand; % uniform random number in [0,1)
    sample(iter)  = find(A>x, 1,'first'); % The smallest element in A greater than x
end

y = sample;
end