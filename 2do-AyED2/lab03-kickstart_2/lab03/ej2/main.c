/*
  @file main.c
  @brief Defines main program function
*/

/* First, the standard lib includes, alphabetically ordered */
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

/* Then, this project's includes, alphabetically ordered and weather utils */
#include "array_helpers.h"
#include "weather_utils.h"

/**
 * @brief print usage help
 * @param[in] program_name Executable name
 */
void print_help(char *program_name) {
    /* Print the usage help of this program. */
    printf("Usage: %s <input file path>\n\n"
           "Load climate data from a given file in disk.\n"
           "\n"
           "The input file must exist in disk and every line in it must have the following format:\n\n"
           "<year> <month> <day> <temperature> <high> <low> <pressure> <moisture> <precipitations>\n\n"
           "Those elements must be integers and will be copied into the multidimensional integer array 'a'.\n"
           "The dimensions of the array are given by the macro tclimate.\n"
           "\n\n",
           program_name);
}

/**
 * @brief reads file path from command line
 *
 * @param[in] argc amount of command line arguments
 * @param[in] argv command line arguments
 *
 * @return An string containing read filepath
 */
char *parse_filepath(int argc, char *argv[]) {
    /* Parse the filepath given by command line argument. */
    char *result = NULL;

    if (argc < 2) {
        print_help(argv[0]);
        exit(EXIT_FAILURE);
    }

    result = argv[1];

    return (result);
}

/**
 * @brief Main program function
 *
 * @param[in] argc amount of command line arguments
 * @param[in] argv command line arguments
 *
 * @return EXIT_SUCCESS when programs executes correctly, EXIT_FAILURE otherwise
 */
int main(int argc, char *argv[]) {
    
    char *filepath = NULL;
    int _min_temp_his = 0;
    int _max_temp_year[YEARS];
    unsigned int _max_rainfall_mensual[YEARS];

    /* parse the filepath given in command line arguments */
    filepath = parse_filepath(argc, argv);


    /* create an array with the type of tclimate */
    WeatherTable array;

    /* parse the file to fill the array and obtain the actual length */
    array_from_file(array, filepath);

    /* register of the min temperature of the history */
    _min_temp_his = min_temp_of_the_history(array);

    /* register of the max temperature from the years 1980 to 2016 */
    max_temperature_register(array, _max_temp_year);

    /* register of the month (wiht the max rainfall) from the years 1980 to 2016  */
    max_rainfall_register(array, _max_rainfall_mensual);

    /* show the ordered array in the screen */
    array_dump(array);

    printf("\nLa min temperatura registrada historicamente es = %d\n", _min_temp_his);
    for (unsigned int i = 0; i < YEARS; i++) {
    printf("Max temp del anio %u es %d\n", i + 1980u, _max_temp_year[i]);
    printf("Max precipitacion del mes %u del anio %u", _max_rainfall_mensual[i], i + 1980u);
    if(!(i==YEARS)) fprintf(stdout,"\n");
    }

    return (EXIT_SUCCESS);
}
