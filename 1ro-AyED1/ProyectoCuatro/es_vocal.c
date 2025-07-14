#include <stdio.h>
#include <assert.h>

char pedir_char (void){
    char n;

    printf("Ingrese un caracter por favor:\n");
    scanf("%c", &n);

    return n;
}

void es_vocal(char v){

    if (v=='a' || v=='e' || v=='i' || v=='o' || v=='u' || v=='A' || v=='E' || v=='I' || v=='O' || v=='U')
    {
        printf("El caracter ingresado ES LA VOCAL: '%c'\n", v);
    }else{

        printf("El caracater ingresado no correponde a una VOCAL vuelva a ingresarlo por favor\n");

    }
    
}

int main(void){

    char c;

    c = pedir_char();

    es_vocal(c);


    return 0;
}