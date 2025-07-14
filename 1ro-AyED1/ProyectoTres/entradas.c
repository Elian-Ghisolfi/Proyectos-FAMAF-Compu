#include <stdio.h>

int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero:\n");
    scanf("%d", &n);

    return n;
}

void imprimir_entero(int a){
    printf("El valor ingresado es: %d\n", a);
    
}

int main (void){

    imprimir_entero(pedir_entero());

    return 0;
}

