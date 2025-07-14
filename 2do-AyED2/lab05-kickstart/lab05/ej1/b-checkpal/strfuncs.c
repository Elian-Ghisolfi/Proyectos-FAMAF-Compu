#include <stdio.h>
#include <stdlib.h>

#include "strfuncs.h"


size_t string_length(const char *str){
    size_t length_s = 0;
    const char *end_string = NULL;
    end_string = str;

    for (unsigned int i = 0; end_string[i] != '\0'; i++){
        length_s++;        
    }
    return length_s;
}

bool string_is_symmetric(const char *str){
    bool res = true;
    size_t reverse_index = string_length(str) - 1;

    for (size_t i = 0; i < reverse_index; i++){
        res = res && (str[i] == str[reverse_index]);
        reverse_index--;
    }
    
    return res;
}

char *string_filter(const char *str, char c){
    char *res_string = NULL;
    res_string = malloc(sizeof(char) * string_length(str));
    unsigned int j = 0;

    for (unsigned int i = 0; str[i] != '\0'; i++){
        if (str[i] != c){
            res_string[j] = str[i];
            j++;
        }
    }
    return res_string;
}