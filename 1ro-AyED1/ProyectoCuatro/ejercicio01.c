#include <stdio.h>
#include <assert.h>

void hola_hasta(int n){

int i=0;

while (i<n){
    printf("Hola\n");
    i++;
    }
}

int pedir_entero(char name) {
    int a;

    printf("Ingrese un valor para la variable que se almacenara en %c: ", name);

    scanf("%d", &a);

    return a;
}

int main(void){

    int n;

    n=pedir_entero('n');

    assert(n>0);

    hola_hasta(n);

    return 0;
}

/*
Ingrese un valor para la variable que se almacenara en n: 6
Hola
Hola
Hola
Hola
Hola
Hola
*/