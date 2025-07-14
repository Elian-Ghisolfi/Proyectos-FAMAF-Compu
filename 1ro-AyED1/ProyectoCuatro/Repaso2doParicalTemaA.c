#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

/*
var r, s : Int;
{Pre: r = R, s = S, S > R}
r, s := s - r, r + s
{Pos: r = S - R, s = R + S}
*/

int main(void){

    int r, s;
    int aux;

    int S, R; // variables de condicion

    printf("Ingrese un valor para 'r':\n");
    scanf("%d", &r);
    printf("\nIngrese un valor para 's' mayor a 'r':\n");
    scanf("%d", &s);

    assert(s>r);

    S = s; R = r; // Fijamos los valores a las variables de condicion
    

    aux=r;
    r = s - r;

    assert(r == S - R);

    s = aux + s;

    assert(r == S - R && s == R + S);

    printf("\nEl valor de 'r' --> %d\n", r);
    printf("\nEl valor de 's' --> %d\n", s);

    return 0;
}