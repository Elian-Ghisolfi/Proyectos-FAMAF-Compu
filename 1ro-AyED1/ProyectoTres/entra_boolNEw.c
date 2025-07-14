#include <stdio.h>
#include <stdbool.h>

int pedir_bool(char name){
    int temp;
    bool b;

    printf("Ingrese un valor Booleano almacenado en %c\n", name);
    scanf("%d", &temp);
    b = temp;
     
    return b;

}
void imprimir_bool(char name, int a){


    printf("EL Booleano denominado almacenado en'%c' es:%s\n", name, a ? "True" : "False");
}

int main(void){

    bool x, n;
    
    n = pedir_bool('n');
    imprimir_bool('n', n);

    return 0;
}

/*
Ingrese un valor Booleano almacenado en n
1
EL Booleano denominado almacenado en'n' es:True
Ingrese un valor Booleano almacenado en n
0
EL Booleano denominado almacenado en'n' es:False
*/