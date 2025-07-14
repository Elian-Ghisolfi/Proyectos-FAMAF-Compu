#include <stdio.h>
#include <stdbool.h>

int main(void){

    //PUNTO A)
    // 1 h)

    int i, iter;
    iter = 0;

    printf("Ingrese un valor entero para 1 h):\n");
    scanf("%d", &i);

    while (i!=0){
        iter ++;
        printf("Estado sigma 1 iter %d: i->%d\n", iter,i);
        
        i = i - 1;
        printf("Estado sigma 2 iter %d: i->%d\n", iter, i);
    }
    printf("Estado sigma Final: i:= %d\n", i);

    // 1 i)

    int a;
    iter = 0;

    printf("Ingrese un valor entero para 1 i):\n");
    scanf("%d", &a);

    while (a!=0){
        iter ++;
        printf("Estado sigma 1 iter %d: i->%d\n", iter,a);
        
        a = 0;
        printf("Estado sigma 2 iter %d: i->%d\n", iter, a);
    }
    printf("Estado sigma Final: i:= %d\n\n", a);

    //PUNTO B)
    //Programa 1)
    int x, y;
    iter = 0;

    printf("Ingrese el valor para X del programa 1:\n");
    scanf("%d", &x);
    printf("Ingrese el valor para Y del programa 1:\n");
    scanf("%d", &y);

    while (x >= y)
    {
        x = x - y;
        iter++; 

        printf("Estado sigma 1 luego de iteracion %d: x->%d, y->%d, i->%d\n", iter, x, y, iter);
    }
    
    //Programa 2)

    int t;
    bool res;
    iter = 2;
    res = true;

    printf("Ingrese un valor para X del programa 2:\n");
    scanf("%d", &t);

    while ((iter<t) && res)
    {
        res = res && (t % iter)!=0;
        iter ++;

        printf("Estado sigma 1 luego de iteracion %d: x->%d, i->%d, res->%s\n", (iter-2), t, iter, res ? "True" : "False");
    }
    
    return 0;
}

/*PUNTO A
Ingrese un valor entero para 1 h):
4
Estado sigma 1 iter 1: i->4
Estado sigma 2 iter 1: i->3
Estado sigma 1 iter 2: i->3
Estado sigma 2 iter 2: i->2
Estado sigma 1 iter 3: i->2
Estado sigma 2 iter 3: i->1
Estado sigma 1 iter 4: i->1
Estado sigma 2 iter 4: i->0
Estado sigma Final: i:= 0
Ingrese un valor entero para 1 i):
400
Estado sigma 1 iter 1: i->400
Estado sigma 2 iter 1: i->0
Estado sigma Final: i:= 0 */

/* PUNTO B PROGRAMA 1
Ingrese el valor para X del programa 1:
13
Ingrese el valor para Y del programa 1:
3
Estado sigma 1 luego de iteracion 1: x->10, y->3, i->1
Estado sigma 1 luego de iteracion 2: x->7, y->3, i->2
Estado sigma 1 luego de iteracion 3: x->4, y->3, i->3
Estado sigma 1 luego de iteracion 4: x->1, y->3, i->4 */

/* PUNTO B PROGRMA 2 
Ingrese un valor para X del programa 2:
5
Estado sigma 1 luego de iteracion 3: x->5, i->3, res->True
Estado sigma 1 luego de iteracion 4: x->5, i->4, res->True
Estado sigma 1 luego de iteracion 5: x->5, i->5, res->True */