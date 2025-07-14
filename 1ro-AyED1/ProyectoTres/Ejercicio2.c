#include <stdio.h>
#include <stdbool.h>

int main(void){

int x, y, z;
bool b, w;
int temp1, temp2;

printf("Ingrese 3 enteros y 2 booleanos:\n");
scanf("%d", &x);
scanf("%d", &y);
scanf("%d", &z);
scanf("%d", &temp1);
scanf("%d", &temp2);

b = temp1;
w = temp2;

int exp1, exp2, exp3;

exp1 = x % 4 == 0;
exp2 = x + y == 0 && y - x == (-1) * z;
exp3 = !b && w;

printf("Los resultados son: \n%d\n%d\n%d\n", exp1, exp2, exp3);

return 0;
}

// Ingrese 3 enteros y 2 booleanos:
// 4
// -4
// 8
// 1
// 0
// Los resultados son: 
// 1
// 1
// 0