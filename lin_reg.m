clc;
clear;
close all;
M=8;
N=8;
exper = 4;
disp = 10;
iter = 1000;
    norma_lin=[];           % массив для хранения СКО 
    usred_arr = [];
    disp_arr = [];
    
    %Метод наименьших квадратов    
for k=1:exper;
        disp = disp/10;
    for i = 1:iter
        Xm = randn(M,N);        %определение признаков(вектора состояния)
        w = randn(N, 1);        %весовые коэффициенты(информационный вектор)
        em= randn(M, 1)*disp;   %аддитивная ошибка
    %определение ответов(наблюдаемый сигнал)
        Ym = Xm*w+em;   
        W = inv(Xm'*Xm)*Xm'*Ym;
    %высчитываем получившееся значение СКО
        SCO = norm(W-w, 2);
        norma_lin(i) = SCO;
    end
%усреднение
Usr = sum(norma_lin)/iter;
usred_arr(k) = Usr;
disp_arr(k)= disp;
end

% построение графика
figure
semilogx(disp_arr, usred_arr);
xlabel('Значение дисперсии шума');
ylabel('Значение СКО');
%title('График зависимости СКО от дисперсии шума');
grid on;


%_________________________________________________%

 %Градиентный метод(стохастический)
g = 0.1;
Wm0 = randn(N,1);
num_iterations = 1000; % Количество итераций градиентного метода

% Создание списков для хранения значений
norm_gradient = zeros(num_iterations, 1);
Wm = Wm0;
for i = 1:num_iterations
    % Обновление инф. вектора
    Wm = Wm+g*2*Xm'*(Ym-(Xm*Wm));
    % Расчет нормы второго порядка для текущей итерации
    norm_gradient(i) = norm(Xm*Wm-Ym, 2);
end
% Построение графика
figure
plot(norm_gradient, '-r', 'LineWidth', 2)
xlabel('Количество итераций')
ylabel('Значение СКО')
grid on;
legend('g = 0.1');
