% Hamiltonian-based Noisy SHO Estimation with Particle Filter
clear all; close all;

Hamiltonian_spin_data;


% Parameters
N = 10000;

Q = 0.05;

meas_related{1} = Y;
meas_related{2} = cp;
meas_related{3} = 2;
meas_related{4} = -2;
meas_related{5} = R;


m0 = ket_0;


% Initial sample set

SX = [];

for iter = 1:N
Phi = gauss_rnd(0,Q,1);
St = [cos(Phi);sin(Phi)];

SX=[SX,St];
end



%SX = gauss_rnd(ket_0, Q, N);

% Particle Filtering
MM = zeros(1, length(Y));


for k = 1:length(Y)

    [SX, W] = ImpSampleBootStrap_2( SX, N, U_DT, meas_related, k);


    % Resampling


    [SX, new_weight] = Resample_Kaumudi(W,SX);

    Y_est = zeros(1,N);
    for iter = 1:N
        Y_est(iter) = SX(:,iter)'* sx * SX(:,iter);
    end
    % Mean estimate
    m = mean(Y_est);
    MM(k) = m;
end



% plotting
figure('Position', [100, 100, 800, 400]);
plot(T, Y, 'k.', 'MarkerSize', 10, 'DisplayName', 'Measurement data');
hold on;
plot(T, Theoretical_pred, 'r-', 'LineWidth', 2, 'DisplayName', 'Observable Value');
plot(T, MM, 'b-.', 'LineWidth', 3, 'DisplayName', 'PF Estimate');
xlabel('Time (s)');
ylabel('Oscillation Amplitude (rad)');
title('Tracking Spin observable with Particle Filter');
grid on;
legend('show', 'Location', 'best');
fprintf('PF estimate.\n');
rmse = sqrt(mean((Theoretical_pred - MM).^2));
fprintf('RMSE of Particle Filter: %.2f\n', rmse);

saveas(gcf, 'SpinObservable_0_1w0.svg');

% % Custom gauss_rnd function
% function X = gauss_rnd(m, P, N)
% L = chol(P, 'lower');
% Z = randn(length(m), N);
% X = repmat(m, 1, N) + L * Z;
% end
