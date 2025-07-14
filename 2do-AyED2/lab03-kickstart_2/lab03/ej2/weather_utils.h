/*
define weather utils 
*/
#ifndef _WEATHER_UTILS_H
#define _WEATHER_UTILS_H

#include <stdbool.h>

#include "array_helpers.h"
#include "weather.h"

/*
Recibe una weather_table "a" con los datos historicos del clima
@return la minima temperatura hitorica 
*/
int min_temp_of_the_history (WeatherTable a);

/*
Recibe una weather_table "a" con los datos historicos del clima
@return un registro (array) de las maximas temperaturas registradas por anio (YEARS)
*/
void max_temperature_register (WeatherTable a, int max_temp_year[]);

/*
Recibe una weather_table "a" con los datos historicos del clima
@return un registro (array) de las maximas precipitacion mensual(MONTHS) por anio (YEARS)
*/
void max_rainfall_register (WeatherTable a, unsigned int max_rainfall_mensual[]);

#endif //_WEATHER_UTILS_H