#include <stdio.h>

int ingresar_valor(char name){
    int a;

    printf("Ingresar el valor de la variable '%c':\n", name);
    scanf("%d", &a);

    return a;
}

void imprimir_menor(int a, int b, int c, int d){

    if(a >= b){
        d = b;
    }else
    {
        d = a;
    }

    if (d < c){
        d = d;
    }else{
        d = c;
    }
    printf("El menor valor es: %d\n", d);
}

int main(void){

    int x, y, z, resul;
    resul = 0;

    x = ingresar_valor('X');
    y = ingresar_valor('Y');
    z = ingresar_valor('Z');

    imprimir_menor(x, y, z, resul);

    return 0;
}
/* Este metodo de funciones se podria utilizar en todos los ejercicis ya que todas las tareas
se pueden dividir en funciones como pedir valores o funciones que calculen los valores esperados y los impriman en pantalla*/

/*Ingresar el valor de la variable 'X':
18
Ingresar el valor de la variable 'Y':
12
Ingresar el valor de la variable 'Z':
9
El menor valor es: 9
 
Ingresar el valor de la variable 'X':
2
Ingresar el valor de la variable 'Y':
78
Ingresar el valor de la variable 'Z':
2
El menor valor es: 2

Ingresar el valor de la variable 'X':
52
Ingresar el valor de la variable 'Y':
6
Ingresar el valor de la variable 'Z':
12
El menor valor es: 6*/

