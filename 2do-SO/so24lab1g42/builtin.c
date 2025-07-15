#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "builtin.h"
#include "command.h"

#include "tests/syscall_mock.h"

#define NUMBER_OF_INTERNAL_COMMANDS 3

typedef struct
{
  char *internal_name;
  void (*func)(scommand cmd_);
}builtin_cmd;

static builtin_cmd builtin_commands[] = {
    {"cd", cmd_cd},
    {"help", cmd_help},
    {"exit", cmd_exit}
};

static bool
streq (const char *s1, const char *s2)
{
  return strcmp (s1, s2) == 0;
}

void cmd_cd(scommand cmd_)
{
  char *arg = NULL;
  int arguments_length = scommand_length(cmd_);
  if (arguments_length != 0)
    {
      arg = (char *)calloc (strlen (scommand_front (cmd_)) + 1,
                            sizeof (char *));
      strcpy (arg, scommand_front (cmd_));
    }
  if (arguments_length == 1)
    {
      int result = chdir (arg);
      if (result != 0)
        {
          perror ("Error en el cambio de ruta\n");
        }
    }
  else if (arguments_length > 1)
    {
      perror ("Error: demasiados argumentos para el comando cd\n");
      while (!scommand_is_empty (cmd_))
        {
          scommand_pop_front (cmd_);
        }
    }
  else
    {
      char *home_path = getenv ("HOME");
      if (home_path == NULL)
        {
          perror ("Error: ruta relativa no encontrada\n");
        }

      int result = chdir (home_path);
      if (result != 0)
        {
          perror ("Error en el cambio de ruta\n");
        }
    }
  free(arg);
}

void cmd_help(scommand cmd_)
{
  int arguments_length = scommand_length(cmd_);
  if (arguments_length >= 1)
    {
      while (!scommand_is_empty(cmd_))
      {
          char *command = scommand_front(cmd_);
          if (streq (command, "cd"))
          {
            fprintf (
                      stdout,
                      "cd: cd [dir]\n"
                      "Modifica el directorio de trabajo del shell.\n");
          }
        else if (streq (command, "exit"))
          {
            fprintf (stdout, "exit: exit\n"
                            "Salir del intérprete.\n");
          }
        else if (!streq (command, "exit") && !streq (command, "cd"))
          {
            fprintf (
                    stdout,
                    "No hay temas de ayuda que coincidan con `%s'.\n"
                    "Prueba `help' para conocer los comandos internos.\n",
                    command);
          }
        scommand_pop_front (cmd_);
      }
    }
    else
    {
      fprintf (
              stdout,
                "MyBash, version 2024\n"
                "Autores de tremandas obra: Ticiano Morvan, Nicolas Jorge, Elian Ghisolfi\n"
                "Comandos implementados nativamente: cd, exit\n"
                 "Escriba «help <comando>» para saber más sobre determinado comando.\n");
    }  
}

void cmd_exit(scommand cmd_)
{
  exit (EXIT_SUCCESS);
}


bool
builtin_is_internal (scommand cmd)
{
  assert (cmd != NULL);
  bool is_internal = false;

  if (!scommand_is_empty(cmd))
  {
    char *command = scommand_front(cmd);
    for (int i = 0; i < NUMBER_OF_INTERNAL_COMMANDS; i++) 
    {      
      is_internal = is_internal || streq(command, builtin_commands[i].internal_name);
    }
  }
  return is_internal;
}

bool
builtin_alone (pipeline p)
{
  assert (p != NULL);
  return (pipeline_length (p) == 1 &&
          builtin_is_internal (pipeline_front (p)));
}

void
builtin_run (scommand cmd)
{
  assert (cmd != NULL);
  bool is_internal = builtin_is_internal(cmd);
  char *command = scommand_front(cmd);

  if (is_internal)
  {    
    for (int i = 0; i < NUMBER_OF_INTERNAL_COMMANDS; i++) {
        if (strcmp(command, builtin_commands[i].internal_name) == 0)
        {
          scommand_pop_front(cmd);
          builtin_commands[i].func(cmd);
        }
    }
  }
  while (!scommand_is_empty (cmd))
    {
      scommand_pop_front (cmd);
    }     
}
