#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

#define N 5

void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("Ingrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}

bool todos_pares(int tam, int a[]){

    int i=0, contador=0; 

    while (i<tam){
        if (a[i]%2 == 0)
        {
         contador++;
        }
        i++;        
    }
    return (contador == tam);

    /*
    bool res = true;

    while(i<tam){

        res = res && (a[i] % 2 == 0);
    }
    return res;
    */
}
bool existe_multiplo(int m, int tam, int a[]){

    int i=0, contador = 0;

    while (i<tam){
        if (a[i]%m == 0)
        {
         contador++;
        }
        i++;        
    }
    return (contador >= 1);

    /*
    bool res = false;

    while(i<tam){

        res = res || a[i] % m == 0;
    }
    */
}

int main(void){

    int array[N];
    int x, n;
    bool temp;

    pedir_arreglo(N, array);

    printf("Elija una de las siguientes funcinones para su arreglo\nSaber si son todos pares marque 1)\n Saber si existe un multiplo de un numero marque 0)\n");
    scanf("%d", &x);

    temp = x;
    if (temp){

        printf("¿Los elemntos del arreglo son todos pares? -> %s\n", todos_pares(N, array) ? "True\n" : "False\n");
    }else{
        printf("Ingrese un entero para saber si es divisor de algun elemento del Array\n");
        scanf("%d", &n);

        printf("¿Existe un multiplo de %d en el Array ingresado? -> %s\n",n ,existe_multiplo(n, N, array) ? "True\n" : "False\n");

    }
    return 0;
}

/*
Ingrese un valor para el elemnto N'1
2
Ingrese un valor para el elemnto N'2
4
Ingrese un valor para el elemnto N'3
6
Ingrese un valor para el elemnto N'4
8
Ingrese un valor para el elemnto N'5
11
Elija una de las siguientes funcinones para su arreglo
Saber si son todos pares marque 1)
 Saber si existe un multiplo de un numero marque 0)
1
¿Los elemntos del arreglo son todos pares? -> False

Ingrese un valor para el elemnto N'1
2
Ingrese un valor para el elemnto N'2
4
Ingrese un valor para el elemnto N'3
6
Ingrese un valor para el elemnto N'4
8
Ingrese un valor para el elemnto N'5
10
Elija una de las siguientes funcinones para su arreglo
Saber si son todos pares marque 1)
 Saber si existe un multiplo de un numero marque 0)
0
Ingrese un entero para saber si es divisor de algun elemento del Array
5
¿Existe un multiplo de 5 en el Array ingresado? -> True
*/