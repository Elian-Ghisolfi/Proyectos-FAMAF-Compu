#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

typedef struct{
int horas;
int minutos;
int segundos;
} lapso_t;

lapso_t calcular_lapso(int segs) {

    lapso_t aux;

    aux.horas = segs / 3600;
    aux.minutos = (segs % 3600) / 60;
    aux.segundos = (segs % 3600) % 60;

    return aux;
}

int main(void){

    int x;
    lapso_t resultado;

    printf("Ingrese los segundo que tardo en realizar la actividad\n");
    scanf("%d", &x);

    assert( x >= 0);

    resultado = calcular_lapso(x);

    printf("\nUsted tardo %dhs: %dmin: %dseg\n", resultado.horas, resultado.minutos, resultado.segundos);

    return 0;
}

/*
Ingrese los segundo que tardo en realizar la actividad
4550

Usted tardo 1hs: 15min: 50seg
*/