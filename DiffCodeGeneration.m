% script que hace generacion de codigo para matlab. toma una funcion 
% de transferencia en Z y genera un codigo ejecutable de ecuacion de 
% diferencias.


% numerador y denominador de la funcion de transferencia en z
Num = [0 0.107342404255659 -0.0878374250754410];
Den = [1 -1.94927892658269 0.951229424500714];

nn = length(Num);
nd = length(Den);

syms Y(x) U(x) x;
y = getFVector(Y, x, nd);
u = getFVector(U, x, nn);

eqy = sum(u.*Num)-sum(y(1:end-1).*Den(1:end-1))/Den(nd);
eqy_char = strrep(char(eqy), 'x - ', '');
% se abre o se crea el archivo out.m y se descarta lo que tenga (si es que existe)
file = fopen('out.m', 'w+');

%encabezado de matlab function
fprintf(file, 'function y = fcn(u)\n');

% se crea un vector vacio para los valores de U y de Y
fprintf(file, ['persistent U = zeros(1,]' num2str(nn) ');']);
fprintf(file, ['persistent Y = zeros(1,]' num2str(nd) ');']);

fprintf(file, ['y_1 = ' eqy_char ]);

%
fprintf(file, 'y = u;');


%funcion local que crea un vector simbolico de una funcion dada
function y = getFVector(v, x, n)
    r = sym(zeros(1, n));
    r(1) = v(x-n+1-1);
    for i=2:1:n
        r(i) = v(x-n+i-1);
    end
    y = r;
end

% 
% function y = getFVector(v, x, n)
%     r = sym(zeros(1, n));
%     r(1) = v(x-n+1);
%     for i=2:1:n
%         r(i) = v(x-n+i);
%     end
%     y = r;
% end