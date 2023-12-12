load("simulation_results/main_simulation_seed1/simulation_2.mat")
n = 100;
th_series = linspace(0,1,n);
TPR_series = zeros(n,12);
FPR_series = zeros(n,12);
figure(1)
hold on
for exp_i = 1:12
% exp_i = 1;
KC_responses = experiment(exp_i).KC_response;
for th_i = 1:n
    th = th_series(th_i);
    [TPR,FPR] = classifier(KC_responses,th);

    TPR_series(th_i,exp_i) = TPR;
    FPR_series(th_i,exp_i) = FPR;
end

end
save("FPR_series_2.mat","FPR_series");
save("TPR_series_2.mat","TPR_series");
figure(1)
plot(FPR_series(:,1:6), TPR_series(:,1:6),"LineWidth",2)
colororder(["#1D697C";"#60281E";"#9B533F";"#E35C38";"#E68364";"#F58F84"])
legend("No inhibition","gsyn=-0.2","gsyn=-0.1","gsyn=-0.05","gsyn=-0.02","gsyn=-0.01")
xlabel("False Postive Rate")
ylabel("True Postive Rate")
title("Full random connectivity mode ROC")

figure(2)
plot(FPR_series(:,7:12), TPR_series(:,7:12),"LineWidth",2)
colororder(["#1D697C";"#60281E";"#9B533F";"#E35C38";"#E68364";"#F58F84"])
legend("No inhibition","gsyn=-0.2","gsyn=-0.1","gsyn=-0.05","gsyn=-0.02","gsyn=-0.01")
xlabel("False Postive Rate")
ylabel("True Postive Rate")
title("Local random connectivity mode ROC")

load("FPR_series.mat");
load("TPR_series.mat");

figure(3)
plot(FPR_series(:,1:6), TPR_series(:,1:6),"LineWidth",2)
colororder(["#1D697C";"#60281E";"#9B533F";"#E35C38";"#E68364";"#ff3500"])
legend("No inhibition","\sigma=5","\sigma=10","\sigma=20","\sigma=38","Global")
xlabel("False Postive Rate")
ylabel("True Postive Rate")
title("Full random connectivity mode ROC")


figure(4)
plot(FPR_series(:,7:12), TPR_series(:,7:12),"LineWidth",2)
colororder(["#1D697C";"#60281E";"#9B533F";"#E35C38";"#E68364";"#ff3500"])
legend("No inhibition","\sigma=5","\sigma=10","\sigma=20","\sigma=38","Global")
xlabel("False Postive Rate")
ylabel("True Postive Rate")
title("Local random connectivity mode ROC")
