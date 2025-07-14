#include <stdio.h>
#include <assert.h>

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

int sumatoria(int tam, int a[]){
    int sum=0, i=0;

    while (i<tam)
    {
        sum = sum + a[i];
        i++;
    }
    return sum;
}

int main(void){

    int array[N];

    pedir_arreglo(N, array);

    printf("La sumatoria del Array ingresado es = %d\n", sumatoria(N, array));

    return 0;
}
/*
Ingrese un valor para el elemnto N'1
125
Ingrese un valor para el elemnto N'2
225 
Ingrese un valor para el elemnto N'3
325
Ingrese un valor para el elemnto N'4
425
Ingrese un valor para el elemnto N'5
525
La sumatoria del Array ingresado es = 1625
*/