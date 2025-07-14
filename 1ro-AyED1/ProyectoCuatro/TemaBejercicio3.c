#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

#define N 5

typedef struct  {
int n_multiplos_dos;
int n_multiplos_tres;
} cantidad_t;

void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("\nIngrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}

cantidad_t contar_multiplos(int a[], int tam){

    cantidad_t aux;
    int i=0;

    aux.n_multiplos_dos = 0;
    aux.n_multiplos_tres = 0;

    while (i < tam)
    {
        if (a[i] % 2 == 0)
        {
            aux.n_multiplos_dos++;
        }
        if (a[i] % 3 == 0)
        {
            aux.n_multiplos_tres++;
        }
        i++;
    }
    
    return aux;

}

int main(void){

    int array[N];
    cantidad_t resultado;

    pedir_arreglo(N, array);

    resultado = contar_multiplos(array, N);

    printf("Los multiplos de 3 son --> %d y los de 2 son --> %d\n", resultado.n_multiplos_tres, resultado.n_multiplos_dos);

    
    return 0;
}
