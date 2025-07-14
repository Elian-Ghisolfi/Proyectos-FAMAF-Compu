/*
  @file sort.c
  @brief sort functions implementation
*/

#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include "helpers.h"
#include "sort.h"
#include "player.h"

bool goes_before(player_t x, player_t y){
    return x.rank <= y.rank;
}

bool array_is_sorted(player_t atp[], unsigned int length) {
    unsigned int i = 1u;
    while (i < length && goes_before(atp[i - 1u], atp[i])) {
        i++;
    }
    return (i == length);
}


void swap(player_t atp[], unsigned int i, unsigned int j) {
    player_t temp = atp[i];
    atp[i] = atp[j];
    atp[j] = temp;
}

static unsigned int partition(player_t atp[], unsigned int lft, unsigned int rgt) {
    int i, j, pivot;
    pivot = lft;
    i = lft + 1;
    j = rgt;

    while (i <= j) {
        if (goes_before(atp[i], atp[pivot])) {
            i = i + 1;
        } else if (goes_before(atp[pivot], atp[j])) {
            j = j - 1;
        } else if (goes_before(atp[pivot], atp[i]) && goes_before(atp[j], atp[pivot])) {
            swap(atp, i, j);
            i = i + 1;
            j = j - 1;
        }
    }

    swap(atp, pivot, j);
    pivot = j;
    
    return pivot;
}

static void quick_sort_rec(player_t atp[], unsigned int lft, unsigned int rgt) {
    unsigned int pivot;

    if (rgt > lft) {
        pivot = partition(atp, lft, rgt);

        quick_sort_rec(atp, lft, (pivot == 0u) ? 0u : pivot - 1);
        quick_sort_rec(atp, pivot + 1, rgt);
    }
}


void sort(player_t a[], unsigned int length) {
    quick_sort_rec(a, 0u, (length == 0u) ? 0u : length - 1u);
}

