#include <stdlib.h>
#include <assert.h>
#include "stack.h"
 
struct _s_stack {
    stack_elem elem;
    stack next;
    unsigned int size;
};  

stack stack_empty(){
    stack s = NULL;

    return s;
}

stack stack_push(stack s, stack_elem e){
    stack aux = NULL;
    aux = (stack)malloc(sizeof(struct _s_stack));
    aux->size = 1u;

    if(s == NULL){
    aux->elem = e;
    aux->next = s;
    }else {
    aux->elem = e;
    aux->next = s;
    aux->size = s->size + 1u;
    }
    s = aux;

    return s;
}

stack stack_pop(stack s){
    assert((s)!= NULL);
    stack aux_s = s;

    s = s->next;
    free(aux_s);

    return s;
}

unsigned int stack_size(stack s){
    assert(s != NULL);
    
    return s->size;
}

stack_elem stack_top(stack s){
    assert((s) != NULL);
    stack aux_s = s;

    return aux_s->elem;
}

bool stack_is_empty(stack s){
    return (s == NULL);
}

stack_elem *stack_to_array(stack s){
    stack_elem *aux_as = NULL;
    stack aux_roam = s;
    unsigned int i = 0u;

    if (s != NULL) {
        aux_as = calloc(stack_size(s), sizeof(stack_elem));
        while (aux_roam != NULL){
            aux_as[i] = aux_roam->elem;
            aux_roam = aux_roam->next;
            i++;
        }
    }
    return aux_as;
}

stack stack_destroy(stack s){
    stack aux_s;

    while (s != NULL){
        aux_s = s;
        s = s->next;
        free(aux_s);
    }
    s = NULL;
    return s;
}

// podemos implementar un Invariante de Representacion tal que si la pila es no vacia el size > 0

