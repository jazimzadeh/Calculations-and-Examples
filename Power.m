function [power] = Power(voltage)
% August 28, 2014 - Julien B Azimzadeh
%
% This function takes voltage as its input. It outputs power in mW for the
% Oxxius 375 nm laser. The output is based on a fit done on 08/28/14 on
% power data gathered at 26 voltage levels.

% The fit is a 5th degree polynomial fit, which is likely overfitting the
% data, but it yields better results than the 3rd degree fit, which is why
% I am using it.

% Raw Data:
% Voltage = [0:0.2:5]';
% Power = [0.0100000000000000;0.0200000000000000;0.0300000000000000;0.0800000000000000;0.350000000000000;0.750000000000000;1.17000000000000;1.59000000000000;2.02000000000000;2.45000000000000;2.88000000000000;3.30000000000000;3.75000000000000;4.14000000000000;4.59000000000000;5.06000000000000;5.45000000000000;5.89000000000000;6.30000000000000;6.71000000000000;7.14000000000000;7.52000000000000;7.95000000000000;8.30000000000000;8.56000000000000;8.58000000000000;]
% P = polyfit(Voltage,Power,5)

% Fit Coefficients:
P = [-0.0176662857570395,0.236114671628779,-1.21252993183464,2.96816272384910,-1.28972656618539,0.0764509473964757;];

% Calculating power 
power = polyval(P,voltage);
