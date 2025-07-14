#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

typedef struct{
int menores;
int iguales;
int mayores;
} comp_t;

comp_t cuantos(int tam, int a[], int elem){
    comp_t res;
    int i = 0;

    res.iguales = 0;
    res.mayores = 0;
    res.menores = 0;

    while (i<tam)
    {
        if (a[i] < elem)
        {
            res.menores++;
        }
        else if (a[i] > elem)
        {
            res.mayores++;
        }
        else
        {
            res.iguales++;
        }
        i++;
    }
    return res;
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

    int n=0, x;
    comp_t resultados;

    printf("Ingrese la cantidad de elementos del Array\n");
    scanf("%d", &n);

    int array[n];
    pedir_arreglo(n, array);

    printf("\nAhora ingrese el Valor a comparar con el Array\n");
    scanf("%d", &x);

    resultados = cuantos(n, array, x);

    printf("\n--La cantidad de elemento menores a '%d' es -> %d\n--La cantidad de elemento mayores a '%d' es -> %d\n--La cantidad de elemento iguales a '%d' es -> %d\n", x, resultados.menores, x, resultados.mayores, x, resultados.iguales);

    return 0;
}
/*
Ingrese la cantidad de elementos del Array
5
Ingrese un valor para el elemnto N'1
10
Ingrese un valor para el elemnto N'2
20
Ingrese un valor para el elemnto N'3
30
Ingrese un valor para el elemnto N'4
40
Ingrese un valor para el elemnto N'5
50

Ahora ingrese el Valor a comparar con el Array
30

--La cantidad de elemento menores a '30' es -> 2
--La cantidad de elemento mayores a '30' es -> 2
--La cantidad de elemento iguales a '30' es -> 1
*/