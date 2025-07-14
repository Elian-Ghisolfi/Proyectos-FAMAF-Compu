#include <stdlib.h>
#include <stdio.h>

void absolute(int x, int y) {
    if (x >= 0) {
        y = x;
    }else{
        y = (-x);
    }
}

int main(void) {
    int a=0, res=0;

    a = -10;

    absolute(a, res);

    printf("\n%d\n", res);

    return EXIT_SUCCESS;
    /*
    El valor mostrado es 0 y no coicide con lo que esperamos, ademas 
    si le agragamos la flag Wextra 
    notamos q el parametro y no se utiliza por ende res no recibe ninugno valor
    */
}

