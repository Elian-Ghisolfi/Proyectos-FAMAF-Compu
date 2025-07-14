#include <stdio.h>
#include <assert.h>

/* Lenguaje Formal
var x, y, aux: Int;
{Pre: x = X, y = Y}
aux := x;
x := x + 1;
y := aux + y;
{Post: x = X + 1, y = X + Y}
*/

int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero:\n");
    scanf("%d", &n);

    return n;
}

int main(void){

    int x, y, aux;

    aux = 0;
    x = pedir_entero();
    y = pedir_entero();

    assert( (x == x) && (y == y));

    aux = x;
    x = x + 1;
    y = aux + y;
    
    printf("El estado final es\n x -> %d\n y -> %d\n", x, y);  
    return 0;
}

/*
Ingrese un valor entero:
5
Ingrese un valor entero:
6
El estado final es
 x -> 6
 y -> 11
 */

