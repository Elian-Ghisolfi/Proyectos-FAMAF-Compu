#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

#define N 5

void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("\nIngrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}

int suma_multiplos(int a[], int tam, int k){

    int i = 0, res = 0;

    while (i < tam)
    {
        if (a[i] % a[k] == 0)
        {
            res = res + a[i];
        }
        i++;
    }
    return res;
    
}

int main(void){

    int x, array[N]; 

    pedir_arreglo(N, array);

    printf("\nIngrese una posicion valida entre 0 y %d por favor\n", (N-1));
    scanf("%d", &x);

    assert(x >= 0 && x<N);
    
    printf("\nLa suma de los miltplos de 'k'= %d en el array es --> %d\n", x, suma_multiplos(array, N, x));

    return 0;
}