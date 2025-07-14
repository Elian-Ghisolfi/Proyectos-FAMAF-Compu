#include <stdio.h>
#include <stdbool.h>


int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero:\n");
    scanf("%d", &n);

    return n;
}

void imprimir_entero(char name, int a){
    printf("El valor de la expresion %c es: %d\n",name , a);
    
}

void imprimir_bool(char name, bool a){

    printf("El valor de la expresion %c es: %s\n",name ,a ? "True" : "False");

}

int pedir_bool(void){
    bool b;
    int temp;

    printf("Ingrese un Booleano:\n");
    scanf("%d", &temp);

    b = temp;
    return b;
}


int main(void){

    int x, y, z;
    bool b, w;

    x = pedir_entero();
    y = pedir_entero();
    z = pedir_entero ();
    b = pedir_bool();
    w = pedir_bool ();

    imprimir_entero('1', (x % 4 == 0));
    imprimir_bool('2', (x + y == 0 && y - x == (-1) * z));
    imprimir_bool('3', (!b && w));


    return 0;
}
/*
Ingrese un valor entero:
4
Ingrese un valor entero:
-4
Ingrese un valor entero:
8
Ingrese un Booleano:
1
Ingrese un Booleano:
0
El valor de la expresion 1 es: 1
El valor de la expresion 2 es: True
El valor de la expresion 3 es: False
*/