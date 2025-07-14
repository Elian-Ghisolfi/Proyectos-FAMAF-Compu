#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("Ingrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}
bool existe_multiplo(int m, int tam, int a[]){

    bool res = false;
    int i = 0;

    while(i<tam){

        res = res || a[i] % m == 0;
        i++;
    }
    return res;
}

bool existe_Impar(int m, int tam, int a[]){

    bool res = false;
    int i = 0;

    while(i<tam){

        res = res || a[i] % m != 0;
        i++;
    }
    return res;
}
int minimo_pares(int tam, int a[]){

    int i = 0, min = INT_MAX;

    while (i<tam)
    {
        if(a[i] < min && a[i]%2==0){

            min = a[i];

        }
        i++;
    }
        return min;
}
int minimo_impares(int tam, int a[]){

    int i = 0, min = INT_MAX;

    while (i<tam)
    {
        if(a[i] <= min && a[i]%2 != 0){

            min = a[i];

        }
        i++;
    }
    return min;
}
int main(void){

    int n=0;

    printf("Ingrese la cantidad de elementos del Array\n");
    scanf("%d", &n);

    int array[n];
    pedir_arreglo(n, array);

    if(existe_multiplo(2, n, array)){

        printf("El minimo elemento PAR del Array es -> %d\n", minimo_pares(n, array));
    }else{

        printf("NO HAY ELEMENTOS PARES\n");
    }

    if (existe_Impar(2, n, array))
    {
        printf("El minimo elemento IMPAR del Array es -> %d\n", minimo_impares(n, array));

    }else{

        printf("NO HAY ELEMENTOS IMPARES\n");
    }
    return 0;
}
/*
Ingrese la cantidad de elementos del Array
4       
Ingrese un valor para el elemnto N'1
4
Ingrese un valor para el elemnto N'2
2
Ingrese un valor para el elemnto N'3
7
Ingrese un valor para el elemnto N'4
3
El minimo elemento PAR del Array es -> 2
El minimo elemento PAR del Array es -> 3

Ingrese la cantidad de elementos del Array
4
Ingrese un valor para el elemnto N'1
11
Ingrese un valor para el elemnto N'2
3
Ingrese un valor para el elemnto N'3
1
Ingrese un valor para el elemnto N'4
15
NO HAY ELEMENTOS PARES
El minimo elemento PAR del Array es -> 1
 
Ingrese la cantidad de elementos del Array
4
Ingrese un valor para el elemnto N'1
0
Ingrese un valor para el elemnto N'2
4
Ingrese un valor para el elemnto N'3
2
Ingrese un valor para el elemnto N'4
8
El minimo elemento PAR del Array es -> 0
NO HAY ELEMENTOS IMPARES
*/
