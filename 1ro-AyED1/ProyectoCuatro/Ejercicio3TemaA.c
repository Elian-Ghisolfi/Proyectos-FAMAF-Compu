#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

#define N 5

typedef struct{
int n_pares;
int n_impares;
} paridad_t;

paridad_t contar_paridad(int a[], int tam){

    paridad_t aux;
    int i = 0;

    aux.n_impares = 0;
    aux.n_pares = 0;
    while (i < tam)
    {
        if (a[i] % 2 ==0)
        {
            aux.n_pares++;
        }else{
            aux.n_impares++;
        }
        i++;
    }
    return aux;
}
void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("Ingrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}
int main(void){

    int array[N];
    paridad_t resultado;

    pedir_arreglo(N, array);
    
    resultado = contar_paridad(array, N);

    printf("\nLa cantidad de numeros pares en el arreglo es --> %d\nLa cantidad de numeros impares en el arreglo es --> %d\n", resultado.n_pares, resultado.n_impares);
    return 0;
}

/*
Ingrese un valor para el elemnto N'1
3
Ingrese un valor para el elemnto N'2
4
Ingrese un valor para el elemnto N'3
5
Ingrese un valor para el elemnto N'4
11
Ingrese un valor para el elemnto N'5
8

La cantidad de numeros pares en el arreglo es --> 2
La cantidad de numeros impares en el arreglo es --> 3

*/