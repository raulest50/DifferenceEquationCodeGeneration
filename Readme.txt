Resumen Proyecto:

se trata de un generador de codigo. La idea es generar un codigo ejecutable
de una ecuacion de diferencias apartir de una funcion de transferencia
en Z.

inicialmente se trabajara en una implementacion para matlab pero la
idea es dar soporte para multiples lenguajes de programacion.

En el proyecto se tiene un modelo de simulink para hacer validacion
del codigo generado vs el bloque discrete transfer function.

USO:
para hacer la generacion de codigo basta con usar el archivo DiffCodeGeneration.m.
unicamente se debe reemplazar al inicio del script la variable Num
por el numerador y Den por el denominador de la funcion de transferencia en
Z que se desea convertir a eacuacion de diferencias.
Al correr el escript se generara en la misma carpeta del script un nuevo
archivo llamado out.m el cual contendra el codigo listo que implementa
la ecuacion de diferencias en un entorno matlab.

si se desea unicamente la ecuacion de diferencias sin la implementacion
basta con buscar la linea de codigo "y_1 =" en la cual se hace el calculo
de la salida siguiente.