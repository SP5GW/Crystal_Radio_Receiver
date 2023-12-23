

% param(1) - Is - Saturation Current [A]
% param(2) - n - emission coeficient [1..2]



% Define the diode model function
diodeModel = @(params, x) params(1) * (exp(params(2) * x) - 1);

% Actual datapoints Id(Ud)
Ud=[0,0.25,0.5,0.75];
Id_true=[0,0.5*10^-3,1.9*10^-3,4*10^-3];

% Initial guess for parameters
initialGuess = [0.3*10^-6, 1.0];

% Fit the diode model to the noisy data
fitParams = lsqcurvefit(diodeModel, initialGuess, Ud, Id_true);

% Plot the results
figure;
plot(Ud, Id_true, 'o', 'DisplayName', 'Actual Measurements');
hold on;
plot(Ud, Id_true, 'k--', 'DisplayName', 'True Curve');
hold on;
plot(Ud, diodeModel(fitParams, Ud), 'r-', 'DisplayName', 'Fitted Curve');

legend;
xlabel('Ud');
ylabel('Id');
title('Diode Model Fitting');

% Display the fitted parameters
disp('Fitted Parameters:');
disp(fitParams);
