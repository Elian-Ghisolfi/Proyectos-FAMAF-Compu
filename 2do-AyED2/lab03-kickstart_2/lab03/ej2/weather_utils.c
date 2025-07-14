/*
Weather utils implementation
*/
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#include "weather_utils.h"

int min_temp_of_the_history (WeatherTable a){

    int min_t = INT_MAX;

    for (unsigned int year = 0; year < YEARS; year++) {
        for (month_t month = march; month <= september; month++) {
            for (unsigned int day = 0u; day < DAYS; day++) {
                if (a[year][month][day]._min_temp < min_t) {
                    min_t = a[year][month][day]._min_temp;
                }
            }
        }
    }
    
    return min_t;    
}

void max_temperature_register (WeatherTable a, int max_temp_year[]){

    int max_t_aux = INT_MIN;

    for (unsigned int year = 0; year < YEARS; year++) {
        for (month_t month = january; month <= december; month++) {
            for (unsigned int day = 0u; day < DAYS; day++) {
                if (a[year][month][day]._max_temp >= max_t_aux) {
                    max_t_aux = a[year][month][day]._max_temp;
                }
                
            }
        }
        max_temp_year[year] = max_t_aux;
    }    
}

void max_rainfall_register (WeatherTable a, unsigned int max_rainfall_mensual[]){

    unsigned int max_p_aux = 0u;
    unsigned int month_aux = 0u;

    for (unsigned int year = 0; year < YEARS; year++) {
        for (month_t month = january; month <= december; month++) {
            for (unsigned int day = 0u; day < DAYS; day++) {
                if (a[year][month][day]._pressure >= max_p_aux) {
                    max_p_aux = a[year][month][day]._pressure;
                    month_aux = month;
                }
            }
        }
        max_rainfall_mensual[year] = month_aux;
    } 
}

