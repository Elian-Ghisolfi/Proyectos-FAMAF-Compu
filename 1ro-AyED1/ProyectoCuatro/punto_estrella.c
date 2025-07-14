#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <limits.h>

typedef struct _persona{
char *nombre;
int edad;
float altura;
float peso;
} persona_t;

float peso_promedio(unsigned int longitud, persona_t arr[]){

    unsigned int i=0;
    float prom=0;

    while (i<longitud)
    {
        prom = prom + arr[i].peso;
        i++;
    }
    prom = prom / longitud;
    return prom;
}
persona_t persona_de_mayor_edad(unsigned int longitud, persona_t arr[]){

    persona_t la_persona_mayor;
    unsigned int i=0;

    la_persona_mayor.altura=0;
    la_persona_mayor.peso = 0;
    la_persona_mayor.nombre = "j";
    la_persona_mayor.edad = INT_MIN;

    while (i < longitud)
    {
        if(la_persona_mayor.edad < arr[i].edad){
            la_persona_mayor = arr[i]; 
        }
        i++;
    }
    return la_persona_mayor;
}
persona_t persona_de_menor_altura(unsigned int longitud, persona_t arr[]){

    persona_t la_persona_menor;
    unsigned int i=0;

    la_persona_menor.edad=0;
    la_persona_menor.peso = 0;
    la_persona_menor.nombre = "j";
    la_persona_menor.altura = INT_MAX;

    while (i < longitud)
    {
        if(la_persona_menor.altura > arr[i].altura){
            la_persona_menor = arr[i];
        }
        i++;
    }
    return la_persona_menor;
}

int main(void){

    persona_t persona1 = {.nombre="Paola", .edad=21, .altura=1.85, .peso=75};
    persona_t persona2 = {.nombre="Luis", .edad=54, .altura=1.75, .peso=69};
    persona_t persona3 = {.nombre="Julio", .edad=40, .altura=1.70, .peso=80};

    unsigned int longitud = 3;

    persona_t arr[] = {persona1, persona2, persona3};

    printf("El peso promedio es %f\n", peso_promedio(longitud, arr));

    persona_t persona_aux = persona_de_mayor_edad(longitud, arr);
    printf("El nombre de la persona con mayor edad es %s\n", persona_aux.nombre);

    persona_aux = persona_de_menor_altura(longitud, arr);
    printf("El nombre de la persona con menor altura es %s\n", persona_aux.nombre);
    return 0;
}

/*
El peso promedio es 74.666664
El nombre de la persona con mayor edad es Luis
El nombre de la persona con menor altura es Julio
*/