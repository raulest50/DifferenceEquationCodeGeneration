% script que hace generacion de codigo para matlab. toma una funcion 
% de transferencia en Z y genera un codigo ejecutable de ecuacion de 
% diferencias.

%
%%
%
% ESCRIBA EN NUM Y EN DEN EL NUMERADOR Y DENOMINADOR DE
% LA FUNCION DE TRANSFERENCIA EN Z.
%
%%
%
Num = Hz.Numerator{1};
Den = Hz.Denominator{1};

nn = length(Num);
nd = length(Den);

syms Y(x) U(x) x;
y = getFVector(Y, x+1, nd);
u = getFVector(U, x, nn);

eqy = (sum(u.*Num)-sum(y(2:end).*Den(2:end)))/Den(1);
eqy_char = strrep(char(eqy), 'x - ', '');
% se abre o se crea el archivo out.m y se descarta lo que tenga (si es que existe)
file = fopen('out.m', 'w+');

%encabezado de matlab function
fprintf(file, 'function y = fcn(u)\n');

% se crea un vector vacio para los valores de U y de Y
fprintf(file, 'persistent U;\n');
fprintf(file, 'if isempty(U)\n');
fprintf(file, ['\t U = zeros(1, ' num2str(nn) ');\n']);
fprintf(file, 'end\n');

fprintf(file, 'persistent Y;\n');
fprintf(file, 'if isempty(Y)\n');
fprintf(file, ['\t Y = zeros(1, ' num2str(nd-1) ');\n']);
fprintf(file, 'end\n');

fprintf(file, 'U = [u U(1:end-1)];\n' ); % shift vector U

fprintf(file, ['y_1 = ' eqy_char ';\n']); % se calcula salida y actual

fprintf(file, 'Y = [y_1 Y(1:end-1)];\n' ); % shift vector Y

% se pone la salida.
fprintf(file, 'y = y_1;\n' );


%funcion local que crea un vector simbolico de una funcion dada
function y = getFVector(v, x, n)
    r = sym(zeros(1, n));
    r(1) = v(x-1);
    for i=2:1:n
        r(i) = v(x-i);
    end
    y = r;
end
