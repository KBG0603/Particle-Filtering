%%% Resampling algorithm


function [new_Sample_set, new_weight]  = resample(Weight, Sample_set)
Weight = Weight/sum(Weight);
N = length(Weight);
Ind = roulette_wheel(Weight, N);
new_Sample_set = Sample_set(:,Ind);
new_weight = 1/N*eye(1,N);
end
