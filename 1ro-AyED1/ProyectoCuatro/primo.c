#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

bool es_primo(int a){

    bool res = true;
    int i=2;

    while (i<a)
    {
        res = res && a % i != 0;
        i++;
    }
    return res;
}

int nesimo_primo(int N){

    int contador=1, i=1,res;

    while (contador <= N)
    {        
        if (es_primo(i))
        {
            contador++;
            res = i;
        }
        i++;
    }
    return res;
}

int main(void){

    int n;

    printf("Ingrese un valor para conocer el n-esimo primo\n");
    scanf("%d", &n);

    printf("\nEl n-esimo primo es --> %d\n", nesimo_primo(n));

    return 0;
}

/*
Ingrese un valor para conocer el n-esimo primo
5

El n-esimo primo es --> 7

Ingrese un valor para conocer el n-esimo primo
6

El n-esimo primo es --> 11

Ingrese un valor para conocer el n-esimo primo
7

El n-esimo primo es --> 13
*/