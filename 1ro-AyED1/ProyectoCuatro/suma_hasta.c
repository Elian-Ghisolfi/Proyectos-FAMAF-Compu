#include <stdio.h>
#include <assert.h>

int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero para n:\n");
    scanf("%d", &n);

    return n;
}

int suma_hasta(int n){


    n = n * (n + 1) / 2;

    return n; 
}

int main(void){

    int x;

    x = pedir_entero();

    if (x >= 0)
    {
        printf("La sumatoria de los primero N naturales es: %d\n", suma_hasta(x));
    }
    else
    {
       printf("ERROR usted ingresó un valor negativo por favor ingrese un valor positivo\n");

       x = pedir_entero();

       printf("La sumatoria de los primero N naturales es: %d\n", suma_hasta(x));
    }
    


    return 0;
}

/*
Ingrese un valor entero para n:
-6
ERROR usted ingresó un valor negativo por favor ingrese un valor positivo
Ingrese un valor entero para n:
6
La sumatoria de los primero N naturales es: 21
*/