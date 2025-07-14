#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

#define N 5

typedef char clave_t;
typedef int valor_t;

typedef struct diccionario{
clave_t clave;
valor_t valor;
}asoc;

void pedir_arregloAsoc(int n_max, asoc a[]){

    int i=0;
    asoc aux;

    while (i<n_max)
    {
        printf("\nIngrese primero la clave del Elemento N'%d\n", (i+1));
        scanf(" %c", &aux.clave);

        printf("\nIngrese ahora el valor del Elemento N'%d\n", (i+1));
        scanf("%d", &aux.valor);

        a[i] = aux;

        i++;       
    }
}

bool asoc_existe(int tam, asoc a[], clave_t c){

    int i=0;
    bool res = false;

    while (i<tam)
    {
        if(a[i].clave == c){

            res = res || true;
        }else{

            res = res || false;
        }

        i++;
    }
    
    return res;
}

int main(void){

    asoc array[N];
    clave_t llave;
    int i = 0;
    int valor_de_llave;

    pedir_arregloAsoc(N, array);

    printf("\n Ahora ingrese una Clave para constatar si existe en el Array\n");
    scanf(" %c", &llave);

    

    if (asoc_existe(N, array, llave)){
        while (i < N){
            if (llave == array[i].clave)
            {
                valor_de_llave = array[i].valor;
            }
            i++;    
        }
        printf("La clave '%c' SI existe en el Array\nEl valor almacenado es %d\n", llave, valor_de_llave);
    }
    else{
        printf("La clave %c NO existe en el Array\nNo hay valor disponible\n", llave);
    }
    
    return 0;
}

/*
Ingrese primera la clave del Elemento N'1
j

Ingrese ahora el valor del Elemento N'1
10

Ingrese primera la clave del Elemento N'2
k

Ingrese ahora el valor del Elemento N'2
10

Ingrese primera la clave del Elemento N'3
l

Ingrese ahora el valor del Elemento N'3
10

Ingrese primera la clave del Elemento N'4
m

Ingrese ahora el valor del Elemento N'4

10

Ingrese primera la clave del Elemento N'5
n

Ingrese ahora el valor del Elemento N'5
10

 Ahora ingrese una Clave para constatar si existe en el Array
l
La clave 'l' SI existe en el Array
*/