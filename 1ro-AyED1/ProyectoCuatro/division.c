#include <stdio.h>
#include <assert.h>

typedef struct{

    int cociente;
    int resto;
    } div_t;

int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero:\n");
    scanf("%d", &n);

    return n;
}

div_t division(int x, int y){
    div_t aux;

    if(x == 0){

        aux.cociente = 0;
        aux.resto = 0;
    }else{

        aux.cociente = x / y;
        aux.resto = x % y;
    }

    return aux;
}


int main(void){

    int div, d;
    div_t resultado;

    d = pedir_entero();
    div = pedir_entero();


    assert(div > 0 || d >= 0);

    resultado = division(d, div);

    printf("La division entera entre %d y %d tiene \n Cociente -> %d\n Resto -> %d\n", d, div, resultado.cociente, resultado.resto);


    return 0;
}

/*
Ingrese un valor entero:
18
Ingrese un valor entero:
4
La division entera entre 18 y 4 tiene 
 Cociente -> 4
 Resto -> 2
*/

