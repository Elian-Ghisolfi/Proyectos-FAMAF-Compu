#include <stdlib.h>
#include <assert.h>
#include "stack.h"

struct _s_stack {
    stack_elem *elems;      // Arreglo de elementos
    unsigned int size;      // Cantidad de elementos en la pila
    unsigned int capacity;  // Capacidad actual del arreglo elems
};

stack stack_empty(){
    stack s_array;

    s_array = malloc(sizeof(struct _s_stack));
    s_array->elems = NULL;
    s_array->size = 0u;
    s_array->capacity = 0u;
    
    return s_array;
}

stack stack_push(stack s, stack_elem e){

    if (s->elems == NULL){
        s->elems = calloc(1u, sizeof(stack_elem));
        s->capacity = 1u;
        s->elems[0u] = e;
        s->size++;
    }else if (s->size == s->capacity){
        s->capacity = s->capacity * 2;
        s->elems = realloc(s->elems, (sizeof(stack_elem) * s->capacity));
        s->elems[s->size] = e;
        s->size++;
    }else {
        s->elems[s->size] = e;
        s->size++;        
    }
    return s;
}

stack stack_pop(stack s){
    assert(s->size > 0);
    s->size--;

    return s;
}

unsigned int stack_size(stack s){
    return s->size;
}

stack_elem stack_top(stack s){
    assert(s->size > 0);
    return s->elems[s->size - 1u];
}

bool stack_is_empty(stack s){
    return (s->size == 0u);
}

// Aca vamos a realizar un copy del arreglo dinamico
stack_elem *stack_to_array(stack s){
    assert(s->size > 0);
    stack_elem *aux_array = NULL;
    
    aux_array = malloc(sizeof(stack_elem) * stack_size(s));
    for (unsigned int i = 0; i < stack_size(s); i++){
        aux_array[i] = s->elems[i];
    }
    
    return aux_array;
}

stack stack_destroy(stack s){
    free(s->elems);
    s->elems = NULL;
    free(s);
    
    return NULL;
}