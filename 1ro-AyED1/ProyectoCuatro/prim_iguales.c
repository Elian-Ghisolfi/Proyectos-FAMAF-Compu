#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("Ingrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}

int prim_iguales(int tam, int a[]){

    int res = 0, aux= a[0], i = 0;
    bool cortador = true;

    while (i<tam)
    {
        if (a[i] == aux && cortador)
        {
            res ++;
             
        }else{

            cortador = false;
        }
        i++;
    }
    return res;
}

int main(void){

    int n=0;

    printf("Ingrese la cantidad de elementos del Array\n");
    scanf("%d", &n);

    int array[n];
    pedir_arreglo(n, array);

    printf("La longitud del tramo inicial mas largo con los mismo elementos es -> %d\n", prim_iguales(n, array));

    return 0;
}
/*
Ingrese la cantidad de elementos del Array
5
Ingrese un valor para el elemnto N'1
1
Ingrese un valor para el elemnto N'2
1 
Ingrese un valor para el elemnto N'3
2
Ingrese un valor para el elemnto N'4
2
Ingrese un valor para el elemnto N'5
2
La longitud del tramo inicial mas largo con los mismo elementos es -> 2
-------------------------------------------------------------------------
Ingrese la cantidad de elementos del Array
4
Ingrese un valor para el elemnto N'1
1
Ingrese un valor para el elemnto N'2
2
Ingrese un valor para el elemnto N'3
2
Ingrese un valor para el elemnto N'4
2
La longitud del tramo inicial mas largo con los mismo elementos es -> 1
*/