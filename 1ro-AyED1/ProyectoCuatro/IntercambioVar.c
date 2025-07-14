#include <stdio.h>
#include <assert.h>

int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero:\n");
    scanf("%d", &n);

    return n;
}

int main(void){

    int x, y, z;

    x = pedir_entero();
    y = pedir_entero();

    printf("Estado inicial para x -> %d , y -> %d\n", x, y);
    //{P: y = Y && x = X}

    z = x;
    x = y;

    //{R: x = Y && z = X}

    y = z;

    //{Q: x = Y && y = X}
    printf("Estado final para x -> %d , y -> %d\n", x, y);

    return 0;
}

/*
Ingrese un valor entero:
123     
Ingrese un valor entero:
-89
Estado inicial para x -> 123 , y -> -89
Estado final para x -> -89 , y -> 123
*/