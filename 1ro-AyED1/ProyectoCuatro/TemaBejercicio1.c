#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

/*
var r, s : Int;
{Pre: r = R, s = S, S > R}
s, r := 2 * r - 2 * s, 2 * r + s
{Pos: s = 2 * R - 2 * S, r = 2 * R + S}
*/

int main(void){

    int r, s;
    int aux, S, R; // Variables auxiliares y que utilizaremos en la post y pre condicion

    printf("Ingrese un valor para la variable 'r':\n");
    scanf("%d", &r);
    printf("\nIngrese un valor para la variable 's' que sea mayor estricto que la cariable 'r':\n");
    scanf("%d", &s);
    
    aux = r; R = r; S = s;

    assert(S > R);

    r = (2 * r) + s;
    
    s = (2 * aux) - (2 * s);

    assert(s == 2 * R - 2 * S && r == 2 * R + S);

    printf("\nEl estado final de la variable 'r' -> %d y el estado final de la variable 's' -> %d\n", r, s);

    return 0;
}