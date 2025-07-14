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

int indice_maximo_par(int a[], int tam){

    int i = 0, res = -1;

    while (i < tam)
    {
        if (a[i] % 2 == 0)
        {
            res = i;
        }
        i++;
    }
   
    return res;   
}
int main(void){

    int array[N];

    pedir_arreglo(N, array);

    if (indice_maximo_par(array, N) != -1)
    {
        printf("El indice maximo de un N' par es %d\n", indice_maximo_par(array, N));
    }else{

        printf("NO HAY PAR PA\n");
    }
    return 0;
}