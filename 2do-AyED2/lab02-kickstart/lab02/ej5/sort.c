#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include "array_helpers.h"
#include "sort_helpers.h"
#include "sort.h"
#include "fixstring.h"

static unsigned int partition(fixstring a[], unsigned int izq, unsigned int der) {
    unsigned int i = izq + 1u;
    unsigned int j = der;
    unsigned int ppiv_aux = izq;

    while (i <= j) {
        if (goes_before(a[i], a[ppiv_aux])) {
            i++;
        }else if (goes_before(a[ppiv_aux], a[j])) {
            j--;
        }else {
            swap(a, i, j);
            i++;
            j--;
        }
    }
    swap(a, ppiv_aux, j);
    ppiv_aux = j;
    return ppiv_aux;
}

static void quick_sort_rec(fixstring a[], unsigned int izq, unsigned int der) {
    unsigned int ppiv;
    if (der > izq) {
        ppiv = partition(a, izq, der);
        if (ppiv > 0) quick_sort_rec(a, izq, (ppiv-1));
        quick_sort_rec(a, (ppiv+1), der);
    }
}

void quick_sort(fixstring a[], unsigned int length) {

    quick_sort_rec(a, 0, (length == 0) ? 0 : length - 1);
}


