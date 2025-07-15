#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "command.h"
#include "execute.h"
#include "parser.h"
#include "parsing.h"

#include "obfuscated.h"

static void
show_prompt (void)
{
  char pwd[1024];
  if (getcwd (pwd, sizeof (pwd)) == NULL)
    {
      perror ("Error al tomar la ruta actual\n");
    }

  printf ("\033[92mmybash\033[0m:\033[91m~%s\033[0m$ ", pwd);
  fflush (stdout);
}

int
main (int argc, char *argv[])
{
  pipeline pipe;
  Parser input;
  bool quit = false;

  input = parser_new (stdin);
  while (!quit)
    {
      ping_pong_loop ("LimeGreenLizard");

      show_prompt ();
      pipe = parse_pipeline (input);

      if (pipe != NULL)
        {
          execute_pipeline (pipe);
          pipeline_destroy (pipe);
        }

      /* Hay que salir luego de ejecutar? */
      quit = parser_at_eof (input);
    }

  if (input != NULL)
    {
      parser_destroy (input);
      input = NULL;
    }

  if (pipe != NULL)
    {
      pipeline_destroy (pipe);
      pipe = NULL;
    }

  return EXIT_SUCCESS;
}
