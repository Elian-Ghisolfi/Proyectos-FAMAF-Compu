#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

#include "stack.h"

int main()
{
    stack s;
    s = stack_empty();
    stack_elem e;
    
    e = 5;
    s = stack_push(s, e);
    e = 10;
    s = stack_push(s, e);
    e = 15;
    s = stack_push(s, e);    
    printf("size %u\n", stack_size(s));
    unsigned int size = stack_size(s);
    for (unsigned int i = 0; i < size; i++){
        printf("%u -> %d\n", i, stack_top(s));
        s = stack_pop(s);
    }
    s = stack_destroy(s);

    return 0;
}
