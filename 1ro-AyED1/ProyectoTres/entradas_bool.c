#include <stdio.h>
#include <stdbool.h>

int pedir_bool(void){
    bool b;
    int temp;

    printf("Ingrese un Booleano:\n");
    scanf("%d", &temp);

    b = temp;
    return b;
}

void imprimir_bool(bool a){

    printf("El Booleano que ingreso es: %s\n", a ? "True" : "False");

}

int main(void){

    imprimir_bool(pedir_bool());

    return 0;
}

/*
Ingrese un Booleano:
1
El Booleano que ingreso es: True

Ingrese un Booleano:
0
El Booleano que ingreso es: False

Ingrese un Booleano:
15
El Booleano que ingreso es: True 
*/