#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

#define N 5

void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("Ingrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}
int suma_mayores(int a[], int tam, int k){

    int i = 0, res = 0;

    while (i < tam)
    {
        if( a[k] < a[i]){

            res = res + a[i];
        }
        i++;
    }
    return res;
}

int main(void){

    int array[N], x;

    pedir_arreglo(N, array);

    printf("\nIngresa una posicion 'k' para sumar los elemntos mayores a dicha posicion en el array\n");
    scanf("%d", &x);

    assert(x>=0 && x<N);

    printf("\nLa suma de los elementos mayores al elemento en la posicion '%d' es --> %d\n", x, suma_mayores( array, N, x));

    return 0;
}

/*
Ingrese un valor para el elemnto N'1
30
Ingrese un valor para el elemnto N'2
20
Ingrese un valor para el elemnto N'3
10
Ingrese un valor para el elemnto N'4
20
Ingrese un valor para el elemnto N'5
30

Ingresa una posicion 'k' para sumar los elemntos mayores a dicha posicion en el array
2

La suma de los elementos mayores al elemento en la posicion '2' es --> 100
*/