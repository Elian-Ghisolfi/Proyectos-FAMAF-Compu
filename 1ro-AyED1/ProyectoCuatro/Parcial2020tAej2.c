#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

#define N 5

typedef struct {
int inferior;
int superior;
} sum_t;

void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("\nIngrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}

sum_t suma_acotada(int cota, int array[], int tam) {

    sum_t aux;
    int i=0;

    aux.inferior = 0;
    aux.superior = 0;

    while (i < tam)
    {
        if (array[i]>= cota)
        {
            aux.superior = aux.superior + array[i];
        }
        else
        {
            aux.inferior = aux.inferior + array[i];
        }
        i++;
    }
    return aux;
}

int main(void){

    int arreglo[N], n;
    sum_t resultado;

    pedir_arreglo(N, arreglo);

    printf("Ingrese una cota por favor\n");
    scanf("%d", &n);

    resultado = suma_acotada(n, arreglo, N);

    printf("La suma de la cota Inferior es --> %d\nLa suma de la cota Superior es --> %d\n", resultado.inferior, resultado.superior);

    
    return 0;
}