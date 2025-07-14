#define array_helpers_h

unsigned int array_from_file(int array[], unsigned int max_size, const char *filepath);
void array_dump(int a[], unsigned int length);
bool array_is_sorted_for_insertion_sort(int a[], unsigned int length);