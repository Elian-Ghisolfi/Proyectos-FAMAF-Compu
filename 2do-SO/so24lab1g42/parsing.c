#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#include "assert.h"
#include "command.h"
#include "parser.h"
#include "parsing.h"

static scommand
parse_scommand (Parser p)
{
  assert (p != NULL && !parser_at_eof (p));
  bool is_eol = false; // End of Line
  scommand scmd = scommand_new ();

  while (!is_eol)
    {
      arg_kind_t type;
      char *arg = NULL;
      arg = parser_next_argument (p, &type);

      if (arg != NULL)
        {
          if (type == ARG_NORMAL)
            {
              scommand_push_back (scmd, arg);
            }
          else if (type == ARG_INPUT)
            {
              scommand_set_redir_in (scmd, arg);
            }
          else if (type == ARG_OUTPUT)
            {
              scommand_set_redir_out (scmd, arg);
            }
          else
            {
              scommand_destroy (scmd);
              perror ("Error: Comando invalido\n");
              return NULL;
            }
        }
      else if (arg == NULL && (type == ARG_INPUT || type == ARG_OUTPUT))
        {
          scommand_destroy (scmd);
          perror ("Error: Argumentos invalidos\n");
          return NULL;
        }
      else
        {
          is_eol = true;
        }
    }

  if (scommand_is_empty (scmd))
    {
      scommand_destroy (scmd);
      scmd = NULL;
    }

  return scmd;
}

pipeline
parse_pipeline (Parser p)
{
  assert (p != NULL && !parser_at_eof (p));
  pipeline result = pipeline_new ();
  scommand scmd = NULL;
  bool has_error = false;
  bool is_background = false;
  bool pipeline_exists = true;
  bool *garbage = malloc (sizeof (bool));

  while (pipeline_exists && !has_error)
    {
      parser_skip_blanks (p);
      scmd = parse_scommand (p);
      has_error = (scmd == NULL);

      if (!has_error)
        {
          pipeline_push_back (result, scmd);
          parser_op_background (p, &is_background);

          if (is_background)
            {
              pipeline_set_wait (result, false);
              pipeline_exists = false;
              // Osea que solo se puede tener un "&" despues del ultimo comando.
            }
          else
            {
              parser_op_pipe (p, &pipeline_exists);
            }
        }
    }

  parser_garbage (p, garbage);
  has_error = has_error || (*garbage && !has_error);

  if (has_error)
    {
      pipeline_destroy (result);
      result = NULL;
    }

  free (garbage);
  garbage = NULL;
  return result;
}
