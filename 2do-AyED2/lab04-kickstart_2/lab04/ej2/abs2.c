#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

void absolute(int x, int *y) {
    if (x >= 0) {
        *y = x;
    }else {
        *y = -x;
    }
}

int main(void) {
    int a=0, res=0;  // No modificar esta declaración
    int *p = NULL;

    a = -10;
    p = &res;

    absolute(a, p);

    printf("\n%d\n", res);

    return EXIT_SUCCESS;
}

/*
Lo que sucede con el puntero a int 'p' es apuntarlo a res entonces en la funcion absolute se utiliza este direccionamiento para
modificar los valores en res asignandole los valores de x
*/
