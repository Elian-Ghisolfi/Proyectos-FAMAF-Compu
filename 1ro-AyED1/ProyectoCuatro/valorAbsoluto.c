#include <stdio.h>
#include <assert.h>

int pedir_entero (void){
    int n;

    printf("Ingrese un valor entero:\n");
    scanf("%d", &n);

    return n;
}

int main(void){

    int x, res;

    x=pedir_entero();

    if (x>=0)
    {
        res = x;
        printf("El valor absoluto de x es = %d\n", res);

        assert(res = x);
    }else{

        res = x * (-1);
        printf("El valor absoluto de x es = %d\n", res);

        assert(res = x * (-1));
    }
    

    return 0;
}

/*
Ingrese un valor entero:
-9
El valor absoluto de x es = 9

Ingrese un valor entero:
8
El valor absoluto de x es = 8
*/