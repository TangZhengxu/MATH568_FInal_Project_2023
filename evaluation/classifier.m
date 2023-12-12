function [TPR,FPR]=classifier(KC_responses, th)
KC_d = [45,45];
KC_n = KC_d(1)*KC_d(2);
odor_N = 110;
TP = zeros(110,1);
FP = zeros(110,1);
FN = zeros(110,1);
TN = zeros(110,1);
for training_odor = 1:odor_N

    gaussian_noise = 0.5*randn(odor_N, KC_n);
    KC_noisy = KC_responses+ gaussian_noise;
    KC_noisy(KC_noisy<0) = 0;
    dis = zeros(odor_N, 1);
    for odor_i = 1:odor_N
        dis(odor_i) = pdist2(KC_noisy(odor_i,:),KC_responses(training_odor,:), 'euclidean');
    end
    norm_dis = dis/max(dis);
    class = norm_dis<th;
    TP(training_odor) = class(training_odor);
    FP(training_odor) = sum(class);
    FN(training_odor) = 1-TP(training_odor);
    TN(training_odor) = 110 - FP(training_odor);
end
TPR = sum(TP)/(sum(TP)+sum(FN));
FPR = sum(FP)/(sum(FP)+sum(TN));
end
