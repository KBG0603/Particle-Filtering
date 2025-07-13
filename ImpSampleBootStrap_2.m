
% meas_related = {meas_data, Meas_prob, ub,lb, MeasCov }
% meas_data = measurement data taken at each time step,  Meas_prob =
% probability for which the sensor works, MeasCov is the covariance of the
% measurement noise in that case, when the sensor does not work it returns
% a random measurement outcome uniformly distributed between [lb,ub]

function [SX, W] = ImpSamplingBootstrap( PrevSample, N, U_DT, meas_related, k)


sx =[0 1;1 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Sample update part


SX =  PrevSample; %%% Sample at k-1


%%%% New samples according to posteriror distribution X_k^(i) ~ P(X_k | X_{k-1}^(i) )   


for ii = 1: N
SX_new(:,ii) = U_DT*SX(:,ii) ;

end




SX = SX_new;

clear SX_new



% % Propagate through the dynamic model
% 
% DT  = 0.01; g = 9.81;
% SX = [SX(1,:)+SX(2,:)*DT; SX(2,:)-g*sin(SX(1,:))*DT];
% 
% 
% QL = chol(Cov,'lower');
% 
%         % Add the process noise
%         SX = SX + QL * randn(size(SX));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Weight update part

meas_data = meas_related{1};
Meas_prob = meas_related{2};
ub = meas_related{3};
lb = meas_related{4};
MeasCov = meas_related{5};

% Draw indicator (see where the random fault in sensors have occured, this is equivalent to sampling from a biased coin, or we can use our favourtite Roulette wheel sampling)

Prob = [Meas_prob, 1 - Meas_prob];

sample = Roulette_Wheel(Prob,N);



% Compute the weights
 ind_correct = find(sample == 1); %%% indices for samples for which correct measurement is taken
 ind_error = find(sample == 2);   %%% indices for samples for which a random measurement is taken
        

%%%% Measurement model where the sensor worked: 
% y_k = sin(x_{k,1}^(i)) + r_k where r_k ~ N(0,R)
%%% Corresponding probablistic model P(y_k|x_k) = N(sin(x_{k,1}^(i)), R)
%%% In bootstrap filter, weight W_k^{i} is proportitonal to P(y_k|x_k) 


R = MeasCov;

for iter = 1:length(ind_correct)
    ii = ind_correct(iter);
    valid_meas(iter) = SX(:,ii)'*sx*SX(:,ii);
end

W(ind_correct) = 1/(sqrt(2*pi)* det(R^(-1))) * exp(-1/2* ( meas_data(k) - valid_meas )* R^(-1) * transpose( meas_data(k) - valid_meas ) ); %%% Kept it to multivariate Gaussian distribution for the sake of full generality

%%%% When the sensor doesn't work, it returns a random number from a uniform distribution, i.e. P(y_k|x_k) = p(y_k) = U[lb, ub ] 

W(ind_error) = 1/abs(ub-lb);

W = W/sum(W); % Normalize to a probability

end