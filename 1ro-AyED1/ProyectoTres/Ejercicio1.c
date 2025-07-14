#include <stdio.h>
#include <stdbool.h>

int main(void){

int x, y, z;

printf("Ingrsar las siguientes variables\n");
scanf("%d", &x);
scanf("%d", &y);
scanf("%d", &z);

int exp1;

exp1 = x + y + 1;

printf ("Primer resultado: %d\n", exp1);

int exp2;

exp2 = z * z + y * 45 - 15 * x;

printf ("Segundo Resultado: %d\n", exp2);

bool exp3;

exp3 = y - 2 == (x * 3 + 1) % 5;

if (exp3 == 1){

    printf("Tercer resultado: True\n");
}else {

    printf("Tercer resultado: False\n");
}

int exp4;

exp4 = y / (2 * x); 

printf ("Cuarto resultado: %d\n", exp4);

bool exp5; 

exp5 = y < x * z; 

if (exp5 == 1){
    printf("Quinto resultado: True\n");
}else {
    printf("Quinto resultado: False\n");
}

return 0;
}
// Ingrsar las siguientes variables
// 7
// 3
// 5
// Primer resultado: 11
// Segundo Resultado: 55
// Tercer resultado: False
// Cuarto resultado: 0
// Quinto resultado: True

// Ingrsar las siguientes variables
// 1
// 10
// 8
// Primer resultado: 12
// Segundo Resultado: 499
// Tercer resultado: False
// Cuarto resultado: 5
// Quinto resultado: False