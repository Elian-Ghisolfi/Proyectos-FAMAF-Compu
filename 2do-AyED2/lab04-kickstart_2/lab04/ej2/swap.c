#include <stdio.h>
#include <stdlib.h>

void swap(int *a, int *b){
    int aux;

    aux  = *a;
    *a = *b;
    *b = aux;
}

int main(){

    int x = 6, y = 4;
    int *p = NULL;
    int *t = NULL;

    p = &x;
    t = &y;

    printf("\nX=%d Y=%d\n", x, y);
    swap(p, t);
    printf("\nX=%d Y=%d\n", x, y);
    return EXIT_SUCCESS;
}