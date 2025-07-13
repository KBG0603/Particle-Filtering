%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Simulate faulty Spin Observable data 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear all
    clc
    id = eye(2);
    sx = [0 1;1 0];
    sy = [0 -1i; 1i 0];
    sz = [1 0; 0 -1];
    % Remember to comment these out when benchmarking!
    fprintf('!! Using fixed random stream !!\n');
    rand('state',1)
    randn('state',1)
    % <---
    
    DT = 0.01;
    Omega_0 = 2 * pi; % Larmor frequency (rad/s), ~1 Hz oscillation
    Omega_c = 0.5 * Omega_0; % Constant control field
    Omega_f = 0 * Omega_0; % Oscillation frequency of the control field (omega_0=omega_f signifies resonance)
    
    Del_Omega =  Omega_0 - Omega_f;
    Omega_eff = sqrt(Omega_c^2 + Del_Omega^2);

    Theta = atan(Omega_c/Del_Omega);

    H = 1/2*[Del_Omega, Omega_c; Omega_c, -Del_Omega];

   % U_DT = id-1i* H * DT ; % Taylor approximation of exp(-1i*H*DT)
    U_DT = expm(-1i*H*DT);




    
    % Q  = 0.01*[DT^3/3 DT^2/2; DT^2/2 DT];
    R  = 0.1;
   
    % m0 = [1.6;0]; % Slightly off
    % P0 = 0.1*eye(2);
        
    ket_0 = [1;0];
    ket_1 = [0;1];


    steps = 500;

    %QL = chol(Q,'lower');
   
    T = [];
    X = [];
    Y = [];
    Y_st =[];
    t = 0;
    x = ket_0;

    for k=1:steps
        x = U_DT*x;
        % w = QL * randn(2,1);
        % x = x + w;

       % y_st = abs( (abs(x(1))^2 - abs(x(2))^2) *Omega_c/Omega_eff - ( conj(x(1))*x(2) + conj(x(2))*x(1) ) * Del_Omega/Omega_eff );
       %y_st = abs(ket_1' * x)^2;
       y_st = x'*sx*x;
       y = y_st + sqrt(R)*randn;
        t = t + DT;
        X = [X x];
        Y_st=[Y_st, y_st];
        Y = [Y y];
        T = [T t];
    end
  
  cp = 0.5;
  C = rand(size(Y)) < cp;
  ind = find(C);
  Y(ind) = 4*rand(size(ind))-2;
 

for iter = 1:length(T)
t = T(iter);
Theoretical_pred(iter) = 2*Del_Omega*Omega_c/Omega_eff^2 * sin(Omega_eff*t/2)^2;
end

%   % Plot the data    
%  % plot(T,Y,'g.',T,X(1,:),'r-');
% 
%   plot(T,Y,'g.',T,Y_st,'r-');
% 
% hold on
% plot(T,Theoretical_pred, 'b')
% 
% hold off
