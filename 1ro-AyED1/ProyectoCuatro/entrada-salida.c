#include <stdio.h>
#include <assert.h>

#define N 5

void imprimir_arreglo(int n_max, int a[]){

    int i = 0;

    while (i<n_max)
    {
        printf("El valor para el elemento [%d] = %d\n",(i+1), a[i]);
        i++;
    }
    

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

    pedir_arreglo(N, array);
    imprimir_arreglo(N, array);

    return 0;
}
/*
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
El valor para el elemento [1] = 10
El valor para el elemento [2] = 20
El valor para el elemento [3] = 30
El valor para el elemento [4] = 40
El valor para el elemento [5] = 50
*/