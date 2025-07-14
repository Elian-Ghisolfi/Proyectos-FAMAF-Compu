#include <stdio.h>
#include <stdbool.h>

int exp1 (int x, int y){
    int a;

    a = x + y + 1;

    return a;
}

int expDos (int x, int y, int z){

    int a;

    a = z * z + y * 45 - 15 * x;
    
    return a;
}

bool exp3 (int x, int y){

    bool a;

    a = y - 2 == (x * 3 + 1) % 5;

    return a;

}

int exp4 (int x, int y){

    int a;

    a = y / (2 * x); 

    return a;
}

bool exp5 (int x, int y, int z){

    bool a;

    a =  y < x * z; 

    return a;
}

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

int main (void) {

    int x,  y, z;

    x = pedir_entero();
    y = pedir_entero();
    z = pedir_entero();

    imprimir_entero('1', exp1(x, y));
    imprimir_entero('2', expDos(x, y, z));
    imprimir_bool('3', exp3(x, y));
    imprimir_entero('4', exp4(x, y));
    imprimir_bool('5', exp5(x, y, z));


    return 0;
}

/*
Ingrese un valor entero:
7  
Ingrese un valor entero:
3
Ingrese un valor entero:
5
El valor de la expresion 1 es: 11
El valor de la expresion 2 es: 55
El valor de la expresion 3 es: False
El valor de la expresion 4 es: 0
El valor de la expresion 5 es: True
elian@Elian-PC:~/Documentos/Algoritmos y Estructuras de Datos 1$ ./ejerc1N 
Ingrese un valor entero:
1
Ingrese un valor entero:
10
Ingrese un valor entero:
8
El valor de la expresion 1 es: 12
El valor de la expresion 2 es: 499
El valor de la expresion 3 es: False
El valor de la expresion 4 es: 5
El valor de la expresion 5 es: False
*/