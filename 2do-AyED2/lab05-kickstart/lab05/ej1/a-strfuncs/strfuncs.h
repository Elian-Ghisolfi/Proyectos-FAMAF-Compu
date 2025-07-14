#ifndef _STRF_
#define _STRF_ 

#include <stdbool.h>

bool string_is_symmetric(const char *str);

char *string_filter(const char *str, char c);

size_t string_length(const char *str);

#endif