#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

#define N 5
typedef struct{
    float maximo;
    float minimo;
    float promedio;
} datos_t;

datos_t stats(int tam, float a[]){

    datos_t res;
    int i=0;

    res.maximo = INT_MIN;
    res.minimo = INT_MAX;
    res.promedio = 0;


    while (i<tam)
    {
        if (a[i] < res.minimo)
        {
            res.minimo = a[i];
        }
        if (a[i] > res.maximo)
        {
            res.maximo = a[i];
        }
        res.promedio = res.promedio + a[i];
        i++;
    }
    res.promedio = res.promedio / tam;

    

    return res;
}
    void pedir_arreglo(int n_max, float a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("\nIngrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%f", &a[i]);
        
        i++;
    }
}
int main(void){

    datos_t resultado;
    float array[N];

    pedir_arreglo(N, array);

    resultado = stats(N, array);

    printf("\n--El Menor elemento del Array es -> %f\n--El Mayor elemento del Array es -> %f\n--EL Promedio de los elementos del Array es -> %f\n", resultado.minimo, resultado.maximo, resultado.promedio);
    
    return 0;
}

/*
Ingrese un valor para el elemnto N'1
17

Ingrese un valor para el elemnto N'2
13

Ingrese un valor para el elemnto N'3
56

Ingrese un valor para el elemnto N'4
44

Ingrese un valor para el elemnto N'5
25

--El Menor elemento del Array es -> 13.000000
--El Mayor elemento del Array es -> 56.000000
--EL Promedio de los elementos del Array es -> 31.000000
*/