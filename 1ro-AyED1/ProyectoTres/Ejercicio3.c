#include <stdio.h>

int main(void){
    // Punto a)
    int x;

    printf("Estado Inicial:\n");
    scanf("%d", &x);

    x = 5;

    printf("Estado Final:\nx->%d \n", x);

    //Punto b)
    int a, b; 

    printf("Estado Inicial:\n");
    scanf("%d %d", &a, &b);

    a = a + b; 

    printf("Estado sigma 1:\na->%d\nb->%d\n", a, b);

    b = b + b;

    printf("Estado Final:\na->%d\nb->%d\n", a, b);

    //Punto c)

    int u, v;

    printf("Estado Inicial:\n");
    scanf("%d %d", &u, &v);

    v = v + v; 

    printf("Estado sigma 1:\nu->%d\nv->%d\n", u, v);

    u = u + v;

    printf("Estado Final:\nu->%d\nv->%d\n", u, v);  

    return 0;
}
// Punto a)
// Estado Inicial:
// 1
// Estado Final:
// x->5 
// Punto b)
// Estado Inicial:
// 2
// 5
// Estado sigma 1:
// a->7
// b->5
// Estado Final:
// a->7
// b->10
// Punto c)
// Estado Inicial:
// 2
// 5
// Estado sigma 1:
// u->2
// v->10
// Estado Final:
// u->12
// v->10