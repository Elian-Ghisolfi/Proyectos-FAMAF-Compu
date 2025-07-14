#include <stdlib.h>
#include <stdio.h>

#define MAX_SIZE 1000

static void dump(char a[], unsigned int length) {
    printf("\n\n");
    printf("\"");
    for (unsigned int j=0u; j < length; j++) {
        printf("%c", a[j]);
    }
    printf("\"");
    printf("\n\n");
}

unsigned int data_from_file(const char *path,
                            unsigned int indexes[],
                            char letters[],
                            unsigned int max_size){

    FILE *file = NULL;
    unsigned int size = 0u;
    unsigned int i = 0u;
    unsigned int assessment = 0u;

    file = fopen(path, "r");
    if (file == NULL) {
        fprintf(stderr, "File does not exist.\n");
        exit(EXIT_FAILURE);
    }
    if (feof(file)) {
        fprintf(stderr, "File has not elements\n");
    }

    while (!feof(file) && size < max_size) {
        assessment =fscanf (file, "%u -> *%c*\n", &indexes[i], &letters[i]);
        if (assessment != 2) {
            fprintf(stderr, "Invalid pattern\n");
            exit(EXIT_FAILURE);
        }
        size++;
        i++;
    }
    if (size > max_size) {
        fprintf(stderr, "Allowed size is %d.\n", max_size);
        exit(EXIT_FAILURE);
    }
    fclose(file);

    return size;
}

void array_copy_and_sort(char copy[], char array[],unsigned int index[], unsigned int length) {
    unsigned int j = 0u;

    while (j < length) {
        for (unsigned int i = 0; i < length; i++) {
            if (index[j] > MAX_SIZE) {
                fprintf(stderr, "Invalid index\n");
                exit(EXIT_FAILURE);                
            }
            if (index[j] == i) {
                copy[i] = array[j];
            }
        }
        j++;
    }
}

int main(int argc, char *argv[]) {
    
    char *file_path = NULL;
    
    if (argc < 2) {
        printf("File path error\n");
        exit(EXIT_FAILURE);
    }

    file_path = argv[1];

    unsigned int indexes[MAX_SIZE];
    char letters[MAX_SIZE];
    char sorted[MAX_SIZE];
    unsigned int length=0; 

    length = data_from_file(file_path, indexes, letters, MAX_SIZE);

    printf("\n Length = %u\n", length);

    array_copy_and_sort(sorted, letters, indexes, length);

    dump(sorted, length);

    return EXIT_SUCCESS;
}
