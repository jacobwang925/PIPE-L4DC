clear; clc;
close all

load('MC data/f(x) = 1/MC10000.mat')

U = U2(51:109,1:100:10000);
bnd = ones(1, 100); % boundary condition with all ones
U = [U;bnd];

x = linspace(-9.8,2,60);
t = linspace(0.1,10,100);
[xx,tt] = ndgrid(x,t);

figure
surf(xx, tt, U)
title('MC data')

x_sub = x(1:2:40);
t_sub = t(1:5:100);

[xs,ts] = ndgrid(x_sub,t_sub);

U_sub = U(1:2:40, 1:5:100);

figure
surf(xs, ts, U_sub)
title('Sub-sampled MC data')


%% Thin Plate Spline

[xData, yData, zData] = prepareSurfaceData( x_sub, t_sub, U_sub );

% Set up fittype and options.
ft = 'thinplateinterp';

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% % Plot fit with data.
% figure( 'Name', 'TPS' );
% h = plot( fitresult, [xData, yData], zData );
% legend( h, 'untitled fit 1', 'U_sub vs. x_sub, t_sub', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'x_sub', 'Interpreter', 'none' );
% ylabel( 't_sub', 'Interpreter', 'none' );
% zlabel( 'U_sub', 'Interpreter', 'none' );
% grid on

% Fit v.s. ground truth
U_fit = fitresult(xx, tt);

figure
surf(xx, tt, U_fit)
title('Thin plate spline')

% gradient
x_diff = linspace(-9.8,1.8,59);

[xd, td] = ndgrid(x_diff,t);

grad_mc = diff(U);
grad_fit = diff(U_fit);

figure
surf(xd, td, grad_mc)
title('MC gradient')

figure
surf(xd, td, grad_fit)
title('TPS gradient')


%% Poly55 fit
[xData, yData, zData] = prepareSurfaceData( x_sub, t_sub, U_sub );

% Set up fittype and options.
ft = fittype( 'poly55' );

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% % Plot fit with data.
% figure( 'Name', 'ploy55' );
% h = plot( fitresult, [xData, yData], zData );
% legend( h, 'untitled fit 1', 'U_sub vs. x_sub, t_sub', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'x_sub', 'Interpreter', 'none' );
% ylabel( 't_sub', 'Interpreter', 'none' );
% zlabel( 'U_sub', 'Interpreter', 'none' );
% grid on
% view( -8.4, 6.6 );

U_fit = fitresult(xx, tt);
figure
surf(xx, tt, U_fit)
title('Poly55')


%% Cubic spline fit
[xData, yData, zData] = prepareSurfaceData( x_sub, t_sub, U_sub );

% Set up fittype and options.
ft = 'cubicinterp';

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft );

% % Plot fit with data.
% figure( 'Name', 'cubic spline' );
% h = plot( fitresult, [xData, yData], zData );
% legend( h, 'untitled fit 1', 'U_sub vs. x_sub, t_sub', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'x_sub', 'Interpreter', 'none' );
% ylabel( 't_sub', 'Interpreter', 'none' );
% zlabel( 'U_sub', 'Interpreter', 'none' );
% grid on
% view( 0.3, 7.8 );

U_fit = fitresult(xx, tt);
figure
surf(xx, tt, U_fit)
title('Cubic spline')


%% Biharmonic
[xData, yData, zData] = prepareSurfaceData( x_sub, t_sub, U_sub );

% Set up fittype and options.
ft = 'biharmonicinterp';

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft );

% % Plot fit with data.
% figure( 'Name', 'biharmonic' );
% h = plot( fitresult, [xData, yData], zData );
% legend( h, 'untitled fit 1', 'U_sub vs. x_sub, t_sub', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'x_sub', 'Interpreter', 'none' );
% ylabel( 't_sub', 'Interpreter', 'none' );
% zlabel( 'U_sub', 'Interpreter', 'none' );
% grid on
% view( -19.4, 19.2 );

U_fit = fitresult(xx, tt);
figure
surf(xx, tt, U_fit)
title('Biharmonic')


%% Lowess
[xData, yData, zData] = prepareSurfaceData( x_sub, t_sub, U_sub );

% Set up fittype and options.
ft = fittype( 'loess' );

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% % Plot fit with data.
% figure( 'Name', 'Lowess' );
% h = plot( fitresult, [xData, yData], zData );
% legend( h, 'untitled fit 1', 'U_sub vs. x_sub, t_sub', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'x_sub', 'Interpreter', 'none' );
% ylabel( 't_sub', 'Interpreter', 'none' );
% zlabel( 'U_sub', 'Interpreter', 'none' );
% grid on
% view( -19.4, 19.2 );

U_fit = fitresult(xx, tt);
figure
surf(xx, tt, U_fit)
title('Lowess')


