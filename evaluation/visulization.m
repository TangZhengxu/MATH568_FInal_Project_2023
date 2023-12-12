% load analysis
load("simulation_results/main_simulation_seed1/simulation_2.mat")
% plot sparsity vs gsyn
exp_range = [2 3 4 5 6 1 8 9 10 11 12 7];
gsyn_range = [-0.2 -0.1 -0.05 -0.02 -0.01 0];
fractions = zeros(12,1);
fractions_err = zeros(12,1);
sparsnesses = zeros(12,1);
sparsnesses_err = zeros(12,1);
no_responding = zeros(12,1);
inter_odor_corr = zeros(12,110,110);
for exp_i = 1:12
    fraction = experiment(exp_range(exp_i)).fraction;
    sparseness = experiment(exp_range(exp_i)).sparseness;
    fractions(exp_i) = mean(fraction);
    fractions_err(exp_i) = std(fraction);
    sparsnesses(exp_i) = mean(sparseness);
    sparsnesses_err(exp_i) = std(sparseness);
    no_responding(exp_i) = sum(fraction==0);
    inter_odor_corr(exp_i,:,:) = corrcoef(experiment(exp_range(exp_i)).KC_response');
end
figure(1)
hold on
errorbar(gsyn_range,fractions(1:6),fractions_err(1:6),"LineWidth",2)
errorbar(gsyn_range,fractions(7:12),fractions_err(7:12),"LineWidth",2)
set ( gca, 'xdir', 'reverse' )
xlabel("gSyn")
ylabel("Responding KC fraction")
xlim([-0.25 0.05])
ylim([-0.5 1])
legend("Full-random","Local-random")
hold off


figure(2)
hold on
errorbar(gsyn_range,sparsnesses(1:6),sparsnesses_err(1:6),"LineWidth",2)
errorbar(gsyn_range,sparsnesses(7:12),sparsnesses_err(7:12),"LineWidth",2)
set ( gca, 'xdir', 'reverse' )
xlabel("gSyn")
ylabel("Lifestime Sparsenesse")
xlim([-0.25 0.05])
ylim([0.3 1.3])
legend("Full-random","Local-random")
hold off

% plot sparsity vs gsyn
exp_range = 1:12;
inh_range = [0 5 10 20 38 100];
fractions = zeros(12,1);
fractions_err = zeros(12,1);
sparsnesses = zeros(12,1);
sparsnesses_err = zeros(12,1);
no_responding = zeros(12,1);
inter_odor_corr = zeros(12,110,110);
for exp_i = 1:12
    fraction = experiment(exp_range(exp_i)).fraction;
    sparseness = experiment(exp_range(exp_i)).sparseness;
    fractions(exp_i) = mean(fraction);
    fractions_err(exp_i) = std(fraction);
    sparsnesses(exp_i) = mean(sparseness);
    sparsnesses_err(exp_i) = std(sparseness);
    no_responding(exp_i) = sum(fraction==0);
    inter_odor_corr(exp_i,:,:) = corrcoef(experiment(exp_range(exp_i)).KC_response');
end
figure(3)
hold on
errorbar(inh_range,fractions(1:6),fractions_err(1:6),"LineWidth",2)
errorbar(inh_range,fractions(7:12),fractions_err(7:12),"LineWidth",2)
xlabel("\sigma")
ylabel("Responding KC fraction")
legend("Full-random","Local-random")
xlim([-5 105])
ylim([-0.5 1])
hold off






figure(3)
hold on
plot(gsyn_range,no_responding(1:6),"LineWidth",2)
plot(gsyn_range,no_responding(7:12),"LineWidth",2)
xlabel("gSyn")
ylabel("Non-responding odors")
xlim([-0.25 0.05])
legend("Full-random","Local-random")
hold off

for exp_i = 7:12
    figure(exp_i)
    heatmap(squeeze(inter_odor_corr(exp_i,:,:)))
    colormap(hot);
    caxis([0 0.4]);
    grid off
    ax = gca;
    ax.XDisplayLabels = nan(size(ax.XDisplayData));
    ax.YDisplayLabels = nan(size(ax.YDisplayData));
    title(['Inter-odor correlation with gsyn=%d', num2str(gsyn_range(exp_i-6))])
    xlabel("odor indx")
    xlabel("odor indx")
end
    






KC_d = [45 45];

% plot range of inhibition
% specify simulation condition and odor
odor_i = 95;
exp_1 = 1;

kc_response = experiment(exp_i).KC_response;
figure(exp_i)
imagesc(reshape(kc_response(odor_i, :), KC_d(1), KC_d(2)));
colormap(pink);
colorbar;
title(sprintf('KC response to odor %d', odor_i))

disp(experiment(exp_i).sparseness(odor_i))
disp(experiment(exp_i).fraction(odor_i))

    