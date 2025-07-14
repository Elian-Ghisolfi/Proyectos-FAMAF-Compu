#include <stdio.h>

int pedir_entero(char name) {
    int a;

    printf("Ingrese un valor para la variable que se almacenara en %c: ", name);

    scanf("%d", &a);

    return a;
}

void imprimir_entero(char name, int x) {

    printf("El valor de la variable almacenada en %c es: %d\n", name, x);

}

int main() {

    int n = pedir_entero('n'); // En name se guarda el nombre de la variable a ingresar

    imprimir_entero('n', n);
    
    return 0;
}

/*
Ingrese un valor para la variable que se almacenara en n: 15
El valor de la variable almacenada en n es: 15
*/