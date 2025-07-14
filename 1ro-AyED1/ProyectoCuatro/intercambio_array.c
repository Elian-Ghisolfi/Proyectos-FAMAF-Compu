#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

void pedir_arreglo(int n_max, int a[]){
    int i = 0;

    while (i<n_max)
    {
        printf("Ingrese un valor para el elemnto N'%d\n", (i+1));
        scanf("%d", &a[i]);
        
        i++;
    }
}
void intercambiar(int tama, int a[], int i, int j){

    int aux=0;

    tama=tama;
    aux = a[j];

    a[j] = a[i];
    
    a[i] = aux;
}
void imprimir_arreglo(int n_max, int a[]){

    int i = 0;

    while (i<n_max)
    {
        printf("El valor para el elemento [%d] = %d\n",(i+1), a[i]);
        i++;
    }
    

}
int main(void){

    int tam=0, x, y;

    printf("Ingrese la cantidad de elementos del Array\n");
    scanf("%d", &tam);

    int array[tam];

    pedir_arreglo(tam, array);

    printf("Ingrese las posiciones que desea intercambiar en el rango (1, %d)\n",tam);
    scanf("%d", &x);
    scanf("%d", &y);


    assert( (x <= (tam-1) && x >= 0) && (x <= (tam-1) && x >= 0));

    intercambiar(tam, array, x, y);

    imprimir_arreglo(tam, array);
    return 0;
}
/**/