#include <stdio.h>

int main (void){

    //PUNTO A)

    int x, y;

    printf ("Ingresar 2 variables enteras: \n");
    scanf ("%d%d", &x, &y);

    if(x >= y){
        printf ("Estado sigma 1: (x >= y = %s) x->%d  y->%d\n",(x>=y) ? "True" : "False", x, y);

        x=0;

        printf ("Estado sigma 2: x->%d  y->%d\n", x, y);

    }else{

        printf ("Estado sigma 1': (x <= y = %s) x->%d  y->%d\n",(x<y) ? "True" : "False", x, y);

        x=2;

        printf ("Estado sigma 2': x->%d  y->%d\n", x, y);

    }
    printf ("Estado sigma Final: x->%d  y->%d\n", x, y);

    //PUNTO B)

    int a, b, c, d;

    printf ("Ingrese 4 variables enteras: \n");
    scanf ("%d %d %d %d", &a, &b, &c, &d );

    if (a < b){

        d = a;
    }else{

        d= b;
    }

    printf ("Estado sigma 1: x->%d  y->%d  z->%d  m->%d\n", a, b, c, d);

    if (d < c){

        d = d;
    }else{

        d= c;
    }

    printf ("Estado sigma Final: x->%d  y->%d  z->%d  m->%d\n", a, b, c, d);

    return 0;
}

//PUNTO A)
// Ingresar 2 variables enteras: 
// 3
// 1
// Estado sigma 1: (x >= y = True) x->3  y->1
// Estado sigma 2: x->0  y->1
// Estado sigma Final: x->0  y->1

// Ingresar 2 variables enteras: 
// 100
// 1
// Estado sigma 1: (x >= y = True) x->100  y->1
// Estado sigma 2: x->0  y->1
// Estado sigma Final: x->0  y->1

// PUNTO B)
// Ingrese 4 variables enteras: 
// 5
// 4
// 8
// 0
// Estado sigma 1: x->5  y->4  z->8  m->4
// Estado sigma Final: x->5  y->4  z->8  m->4