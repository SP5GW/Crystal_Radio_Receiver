
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program calculates optimal values of emission coeficient n and saturaction current Is [A]   %
% parameters, which are part of diode model used in LTSpice.                                       %
%                                                                                                  %
% Input:                                                                                           %
%      diodeName - Diode Name                                                                      %
%      Cjo - zero-bias junction capacitance - obtained from diode datasheet [pF]                   %
%      t - ambient temperature [C]]                                                                %
%      (Ud,Id) - vector pair, consisting instantenious forward voltage (Uf)                        %
%                and current value (If) pairs read from diode characteristics                      %
%                available in the component's datasheet  [V,V]                                     %
%       (initialGuessUd, initialGuessN) - model parameter initial values used at the start of      %
%                                         fitting process (Is, n)                                  %
%       (lb, ub) - lower and upper parameter bounds                                                %
%                                                                                                  %
% Diode model used by LTSpice is based on Shockley diode equation:                                 %
%                                                                                                  %
%                                       Id=Is * (exp(Ud/(n*Ut)) - 1)                               %
% and                                                                                              %
%                                          Ut = k*T/q [V]                                          %
%                                                                                                  %
%  where                                                                                           %
%                                                                                                  %
%       Ut - termal voltage [V]                                                                    %
%       n -  emission coefficient (param(2))                                                       %
%       Id - diode current [A]                                                                     %
%       Ud - diode voltage [V]                                                                     %
%       Is - reverse-bias saturation current (param(1)) [A]                                        %
%       k  - Boltzman constant 1.381*10^-23 [VC/K]                                                 %
%       T  - absolute temperature in Kelvin of p-n diode junction [K]                              %
%       q  - charge of electron 1,602*10^-19                                                       %
%                                                                                                  %
% Output:                                                                                          %
%       (Is, n) - saturation current and emission coeficient for which diode model best            %
%                 fits provided data i.e. Ud and Id vectors                                        %
%                                                                                                  %
%       LTSpice diode component model command                                                      %
%                                                                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Set diode name
diodeName='AAP153';

% Temperature settings - obtained from diode datasheet
t = 25;
T = t + 273.15;

% Cjo diode junction capacitance -  obtained from diode datasheet
% Data for AAP153 diode, which used to be manufactured by Unitra, Poland
Cjo=0.67 %in pF

% Actual datapoints Id=f(Ud) from diode datasheet 
% Data for AAP153 diode, which used to be manufactured by Unitra, Poland
Ud = [0, 0.25, 0.5, 0.75];
Id = [0, 0.5 * 10^-3, 1.9 * 10^-3, 4 * 10^-3];

% Initial guess for parameters Is and N
initialGuess = [0.1 * 10^-4, 2.0];

% Calculation of thermal voltage Ut
k=1.381*10^-23;
q=1.602*10^-19;
Ut = (k*T)/q;

% Diode model function
diodeModel = @(params, Ud) params(1) * (exp(Ud/(params(2) * Ut)) - 1);


% Set lower and upper bounds for model parameters Is and N - only if required
lb = [-Inf, 1]; % Lower bounds for param(1) and param(2)
ub = [Inf, Inf]; % Upper bounds for param(1) and param(2)

% Fit the diode model to the data with constraints
fitParams = lsqnonlin(@(params) diodeModel(params, Ud) - Id, initialGuess, lb, ub);

% Plot the results
figure;
plot(Ud, Id, 'o', 'DisplayName', 'Actual Measurements');
hold on;
plot(Ud, Id, 'k--', 'DisplayName', 'True Curve');
hold on;
plot(Ud, diodeModel(fitParams, Ud), 'r-', 'DisplayName', 'Fitted Curve');

legend;
xlabel('Ud');
ylabel('Id');
title('Diode Model Fitting');

% Display the fitted parameters
stringIs = sprintf('            Is = %.3e [A]', fitParams(1));
stringN = sprintf('            n= %.3f', fitParams(2));

clc; %clear console window
disp('');
disp('Fitted Parameters:');
disp('');
disp(stringIs);
disp(stringN);
disp('');

% Parameters not added by this program are inherited from model of D18 - russian germanium diode
diodeModelString = sprintf('.model %s D(Is=%.3e N=%.3f RS=17 m=0.124 Vj=0.1 Cjo=%.2fpF IBV=2u BV=20 TT=5n EG=0.67 XTI=3 Iave=16m Vpk=20 mfg=Unitra type=germanium)',diodeName,fitParams(1),fitParams(2),Cjo);

disp('*********LTSpice .model command:**********');
disp('');
disp(diodeModelString);
disp('');
disp('******************************************');