#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "builtin.h"
#include "command.h"
#include "execute.h"

#include "tests/syscall_mock.h"

#define FD_READ 0
#define FD_WRITE 1

/*
 * Abrimos el archivo desde el que redireccionaremos la entrada.
 * Si el comando no tenía redirección de entrada, devolvemos -1.
 * Si el comando tiene redirección de entrada, devolvemos la posición del nuevo file descriptor.
 */
static int
get_pipe_read_end (scommand cmd)
{
  int result = -1;
  char *redirect_in = NULL;
  redirect_in = scommand_get_redir_in (cmd);

  if (redirect_in != NULL)
    {
      result = open (redirect_in, O_RDONLY, S_IRUSR);
      if (result == -1)
        {
          perror ("ERROR: Hubo un error al abrir el archivo.");
          exit (EXIT_FAILURE);
        }
    }

  return result;
}

/*
 * Abrimos y/o creamos el archivo a redireccionar la salida.
 * Si el comando no tenía redirección de salida, devolvemos -1.
 * Si el comando tiene redirección de salida, devolvemos la posición del nuevo file descriptor.
 */
static int
get_pipe_write_end (scommand cmd)
{
  int result = -1;
  char *redirect_out = NULL;
  redirect_out = scommand_get_redir_out (cmd);

  if (redirect_out != NULL)
    {
      result = open (redirect_out, O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
      if (result == -1)
        {
          perror ("ERROR: Hubo un error al abrir el archivo.");
          exit (EXIT_FAILURE);
        }
    }

  return result;
}

void
execute_pipeline (pipeline apipe)
{
  assert (apipe != NULL);
  unsigned int pipe_length = pipeline_length (apipe);
  unsigned int pipes_amount =
      pipe_length - 1u; // Para n pipelines, necesitamos n - 1 pipes.

  // Planteamos un acercamiento iterativo para ejecutar una cantidad arbitraria de pipes.
  pid_t *used_pids = (pid_t *)calloc (pipe_length, sizeof (pid_t));
  int **used_pipes = NULL;

  // Por defecto, utilizamos la entrada y salida estándar del sistema.
  int pipe_read_end = STDIN_FILENO;
  int pipe_write_end = STDOUT_FILENO;

  // Para n pipelines, creamos n - 1 pipes, solo si tenemos más de un comando.
  if (pipe_length > 1)
    {
      used_pipes = (int **)calloc (pipes_amount, sizeof (int *));
      for (unsigned int i = 0u; i < pipes_amount; ++i)
        {
          used_pipes[i] = (int *)calloc (
              2, sizeof (int)); // Alojamos memoria para FD_READ y FD_WRITE
          if (pipe (used_pipes[i]) == -1)
            {
              perror ("ERROR: No se pudo crear la tubería");
              exit (EXIT_FAILURE);
            }
        }
    }

  for (unsigned int i = 0u; i < pipe_length; ++i)
    {
      scommand command = pipeline_nth_command (apipe, i);
      printf("interacion = %d\n", i);

      if (builtin_is_internal (command))
        {
          if (pipe_length > 1)
            {
              perror ("ERROR: No se pueden encadenar comandos internos.");
              exit (EXIT_FAILURE);
            }

          builtin_run (command);
          return;
        }

      used_pids[i] = fork ();
      if (used_pids[i] == -1)
        {
          perror ("ERROR: No se pudo crear el subproceso.");
          exit (EXIT_FAILURE);
        }
      else if (used_pids[i] == 0)
        {
          // Cerramos las puntas de los pipes que no vamos a utilizar.
          // Solo necesitamos la salida del comando anterior y la entrada del comando actual.
          for (unsigned int j = 0u; j < pipes_amount; ++j)
            {
              // Si el pipe actual no es el último, cerramos la entrada de lectura.
              if (j != i - 1u)
                {
                  close (used_pipes[j][FD_READ]);
                  // if (i == pipes_amount)
                  //   {
                  //     close(used_pipes[j][FD_WRITE]);
                  //   }
                }
              // Si el pipe actual no corresponde al pipeline actual, cerramos la entrada de escritura.
              else if (j != i)
                {
                  close (used_pipes[j][FD_WRITE]);
                }
            }

          // Obtenemos la entrada y salida del comando, de existir.
          int read_end = get_pipe_read_end (command);
          int write_end = get_pipe_write_end (command);

          // Si hay redirección de entrada.
          if (read_end != -1)
            {
              pipe_read_end = read_end;
            }
          // Si no hay redirección de entrada, no es el primer comando y hay más comandos por delante.
          // Leemos la entrada del comando anterior.
          else if (i > 0 && pipe_length > 1)
            {
              pipe_read_end = used_pipes[i - 1][FD_READ];
            }

          // Si hay redirección de salida.
          if (write_end != -1)
            {
              pipe_write_end = write_end;
            }
          // Si no hay redirección de salida, no estamos en el último comando y hay más comandos por delante.
          // Escribimos en la punta de salida del pipe.
          else if (i < pipes_amount && pipe_length > 0)
            {
              pipe_write_end = used_pipes[i][FD_WRITE];
            }

          // Si la salida no es la estándar, duplicamos el descriptor.
          if (pipe_write_end != STDOUT_FILENO)
            {
              if (dup2 (pipe_write_end, STDOUT_FILENO) == -1)
                {
                  perror (
                      "ERROR: No se pudo duplicar el descriptor de la salida.");
                  exit (EXIT_FAILURE);
                }

              close (pipe_write_end);
            }

          // Si la entrada no es la estándar, duplicamos el descriptor.
          if (pipe_read_end != STDIN_FILENO)
            {
              if (dup2 (pipe_read_end, STDIN_FILENO) == -1)
                {
                  perror (
                      "ERROR: No se pudo duplicar el descriptor de la entrada.");
                  exit (EXIT_FAILURE);
                }

              close (pipe_read_end);
            }

          if (!pipeline_get_wait (apipe))
            {
              pid_t current_pid = getpid ();
              printf ("%s está ejecutándose en segundo plano, su PID es %d.\n",
                      scommand_to_string (command), current_pid);
            }

          char **args = scommand_to_argv (command);
          if (execvp (args[0], args) == -1)
            {
              perror ("ERROR: Hubo un error al ejecutar el comando.");
              exit (EXIT_FAILURE);
            }

          // Cerramos los pipes utilizados.
          if (used_pipes != NULL)
            {
              close (used_pipes[i - 1][FD_READ]);
              close (used_pipes[i][FD_WRITE]);
            }
        }
    }

  // Cerramos todos los pipes creados y liberamos la memoria utilizada.
  if (used_pipes != NULL)
    {
      for (unsigned int i = 0u; i < pipes_amount; ++i)
        {
          close (used_pipes[i][FD_READ]);
          close (used_pipes[i][FD_WRITE]);
          free (used_pipes[i]);
        }

      free (used_pipes);
      used_pipes = NULL;
    }

  // Esperamos por los procesos que no estén en segundo plano.
  if (pipeline_get_wait (apipe))
    {
      for (unsigned int i = 0u; i < pipe_length; ++i)
        {
          printf("pid = %d\n", used_pids[i]);
          waitpid (used_pids[i], NULL, 0);
        }
    }

  // Liberamos la memoria utilizada por el arreglo de PIDs.
  if (used_pids != NULL)
    {
      free (used_pids);
      used_pids = NULL;
    }
}
