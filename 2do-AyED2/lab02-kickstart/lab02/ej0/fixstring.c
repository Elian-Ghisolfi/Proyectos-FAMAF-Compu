#include <stdbool.h>
#include <assert.h>

#include "fixstring.h"

unsigned int fstring_length(fixstring s) {

    unsigned int length_string = 0;
    char end_of_string = s[0];

    while (end_of_string != '\0' && length_string < FIXSTRING_MAX) {

        length_string++;
        end_of_string = s[length_string];
    }
    if (s[FIXSTRING_MAX-1] == '\0') {
        assert(true);
    }
    
    return length_string;
}

bool fstring_eq(fixstring s1, fixstring s2) {

    unsigned int length_s1 = fstring_length(s1);
    unsigned int length_s2 = fstring_length(s2);
    bool equals = false;

    if (length_s1 == length_s2) {
        for (unsigned int i = 0; i < length_s1 - 1; i++) {
            equals = equals || (s1[i] == s2[i]);
        }
        
    }
    return equals;
}

bool fstring_less_eq(fixstring s1, fixstring s2) {
    unsigned int i = 0;

    while (s1 [i] != '\0' && s2[i] != '\0') {
        
        if (s1[i] != s2[i]) {
                
            return (s1[i] < s2[i]);
        }
        i++;
    }
    return fstring_length(s1) < fstring_length(s2);
}
