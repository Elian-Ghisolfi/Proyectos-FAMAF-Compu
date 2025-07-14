#include <stdio.h>
#include <assert.h>

int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero:\n");
    scanf("%d", &n);

    return n;
}

int main(void){

    int x, y, res;

    x=pedir_entero();
    y=pedir_entero();
    
    if (x<=y)
    {
        res = x;
        printf("El minimo valor ingresado es: %d\n", res);

        assert(res = x);
    }else{

        res = y;
        printf("El minimo valor ingresado es: %d\n", res);

        assert(res = y);
    }
    
    return 0;
}

/*
Ingrese un valor entero:
25
Ingrese un valor entero:
-5
El minimo valor ingresado es: -5
*/