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
    }else if (b > a)
    {
        d = a;
    }else if (d <= c)
    {
        d = d;
    }else{
        d = c;
    }
    printf("El menor valor es: %d", d);
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