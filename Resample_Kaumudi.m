%%% Resampling algorithm


function [new_Sample_set, new_weight]  = Resample_Kaumudi(Weight, Sample_set)
Weight = Weight/sum(Weight);
N = length(Weight);
Ind = Roulette_Wheel(Weight, N);
new_Sample_set = Sample_set(:,Ind);
new_weight = 1/N*eye(1,N);
end