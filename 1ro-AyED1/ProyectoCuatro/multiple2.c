#include <stdio.h>
#include <assert.h>

/* Lenguaje Formal
var x, y, z, aux, aux': Int;
{Pre: x = X, y = Y, z = Z}
aux = x;
aux' = y;
x := y;
y := y + aux + z;
z := aux' + aux;
x, y, z := y, y + x + z, y + x
{Post: x = Y, y = Y + X + Z, z = Y + X}
*/

int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero:\n");
    scanf("%d", &n);

    return n;
}

int main(void){

    int x, z, y, aux, aux2;

    aux = 0;
    aux2 = 0;
    x = pedir_entero();
    y = pedir_entero();
    z = pedir_entero();

    aux = x;
    aux2 = y;
    x = y;
    y = y + aux + z;
    z = aux + aux2;

    printf("El estado final es \n x -> %d\n y -> %d\n z -> %d\n", x,y,z);


    return 0;
}

/*
Ingrese un valor entero:
10
Ingrese un valor entero:
20
Ingrese un valor entero:
30
El estado final es 
 x -> 20
 y -> 60
 z -> 30

*/