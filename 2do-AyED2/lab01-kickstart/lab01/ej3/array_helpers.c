/* First, the standard lib includes, alphabetically ordered */
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include "array_helpers.h"

/* Maximum allowed length of the array */
#define MAX_SIZE 100000

unsigned int array_from_file(int array[],
                             unsigned int max_size,
                             const char *filepath) {
    FILE *file_read = NULL;     // Lectura del archivo
    unsigned int size = 0, i = 0;

    file_read = fopen(filepath, "r");
                                
    fscanf(file_read, " %u ", &size);
    if  (max_size < size) {
        printf("Invalid length for array\n");
        exit(EXIT_FAILURE);
    }

    while (i < size)
    {
        if (fscanf(file_read, " %d ", &array[i]) != 1) {
            printf("The leght of the array and the numbers of elements don't match\n");
            exit(EXIT_FAILURE);
        }
        i++;
    }
    fclose(file_read);

    return size;
}
void array_dump(int a[], unsigned int length) {
    for (unsigned int i = 0; i < length-1; i++) {
        printf(" %d,", a[i]);
    }
    printf(" %d]\n\n",a[length-1]);

    if(array_is_sorted(a, length)){
        printf("\nThe array is sorted\n");
    }else {
        printf("\nThe array is unsorted\n");
    }  
}

bool array_is_sorted(int a[], unsigned int length) {
    bool sorted = true;
    unsigned int i = 0;

    while (sorted && (i < length-1)) {
        sorted = (a[i] <= a[i+1]);
        i++;
    }
    return sorted;
}

/*       j = i;
        while (j>1 && (a[j] < a[j-1])) {
            
            element_temp = a[j];
            a[j] = a[j-1];
            a[j-1] = element_temp;
            j = j-1;
        } 
*/ 