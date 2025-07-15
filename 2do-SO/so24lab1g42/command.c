#include <assert.h>
#include <glib.h>
#include <stdlib.h>

#include "command.h"

struct scommand_s
{
  // ([<cmd>, <arg1>, ..., <argn>], ...)
  GSList *args;

  // ([...], <redirect_in>, <redirect_out>)
  char *redirect_in;
  char *redirect_out;
};

scommand
scommand_new (void)
{
  scommand result = malloc (sizeof (struct scommand_s));
  assert (result != NULL);
  result->args = NULL;
  result->redirect_in = NULL;
  result->redirect_out = NULL;
  assert (result != NULL && scommand_is_empty (result) &&
          scommand_get_redir_in (result) == NULL &&
          scommand_get_redir_out (result) == NULL);
  return result;
}

static void
scommand_free (void *self)
{
  assert (self != NULL);
  scommand aux = self;
  scommand_destroy (aux);
}

scommand
scommand_destroy (scommand self)
{
  assert (self != NULL);

  if (self->args != NULL)
    {
      g_slist_free_full (self->args, free);
      self->args = NULL;
    }

  if (self->redirect_in != NULL)
    {
      free (self->redirect_in);
      self->redirect_in = NULL;
    }

  if (self->redirect_out != NULL)
    {
      free (self->redirect_out);
      self->redirect_out = NULL;
    }

  free (self);
  self = NULL;
  assert (self == NULL);
  return self;
}

void
scommand_push_back (scommand self, char *argument)
{
  assert (self != NULL && argument != NULL);
  self->args = g_slist_append (self->args, argument);
  assert (!scommand_is_empty (self));
}

void
scommand_pop_front (scommand self)
{
  assert (self != NULL && !scommand_is_empty (self));
  char *first = g_slist_nth_data (self->args, 0);
  self->args = g_slist_remove (self->args, first);
  free (first);
}

void
scommand_set_redir_in (scommand self, char *filename)
{
  assert (self != NULL);
  self->redirect_in = filename;
}

void
scommand_set_redir_out (scommand self, char *filename)
{
  assert (self != NULL);
  self->redirect_out = filename;
}

/*
  La documentación de GLib recomienda chequear la lista contra NULL
  Si se quiere ver si la lista está o no vacía.

  Ver: https://docs.gtk.org/glib/type_func.SList.length.html#description
*/
bool
scommand_is_empty (const scommand self)
{
  assert (self != NULL);
  return self->args == NULL;
}

unsigned int
scommand_length (const scommand self)
{
  assert (self != NULL);
  unsigned int length = g_slist_length (self->args);
  assert ((length == 0) == scommand_is_empty (self));
  return length;
}

char *
scommand_front (const scommand self)
{
  assert (self != NULL && !scommand_is_empty (self));
  char *result = NULL;
  result = g_slist_nth_data (self->args, 0);
  assert (result != NULL);
  return result;
}

char *
scommand_get_redir_in (const scommand self)
{
  assert (self != NULL);
  return self->redirect_in;
}

char *
scommand_get_redir_out (const scommand self)
{
  assert (self != NULL);
  return self->redirect_out;
}

char *
scommand_to_string (const scommand self)
{
  assert (self != NULL);
  char *current = NULL;
  char *result = g_strdup ("");
  unsigned int length = scommand_length (self);

  if (!scommand_is_empty (self))
    {
      for (unsigned int i = 0u; i < length; ++i)
        {
          current = g_slist_nth_data (self->args, i);
          result = g_strconcat (result, current, NULL);
        }
    }

  if (scommand_get_redir_in (self) != NULL)
    {
      result = g_strconcat (result, "<", scommand_get_redir_in (self), NULL);
    }

  if (scommand_get_redir_out (self) != NULL)
    {
      result = g_strconcat (result, ">", scommand_get_redir_out (self), NULL);
    }

  assert (scommand_is_empty (self) || scommand_get_redir_in (self) == NULL ||
          scommand_get_redir_out (self) == NULL || strlen (result) > 0);
  return result;
}

char **
scommand_to_argv (scommand self)
{
  assert (self != NULL);
  char **result = NULL;
  char *current = NULL;
  unsigned int length = scommand_length (self);

  if (length != 0)
    {
      result = (char **)calloc (length + 1, sizeof (char *));

      for (unsigned int i = 0; i < length; ++i)
        {
          current = g_slist_nth_data (self->args, i);
          result[i] = g_strdup (current);
        }

      result[length] = NULL;
    }
  else
    {
      result = malloc (sizeof (char *));
      result[length] = NULL;
    }

  assert (result != NULL);
  return result;
}

struct pipeline_s
{
  GSList *commands;
  bool must_wait;
};

pipeline
pipeline_new (void)
{
  pipeline result = malloc (sizeof (struct pipeline_s));
  assert (result != NULL);
  result->commands = NULL;
  result->must_wait = true;
  assert (result != NULL && pipeline_is_empty (result) &&
          pipeline_get_wait (result));
  return result;
}

pipeline
pipeline_destroy (pipeline self)
{
  assert (self != NULL);

  if (self->commands != NULL)
    {
      g_slist_free_full (self->commands, scommand_free);
      self->commands = NULL;
    }

  free (self);
  self = NULL;
  assert (self == NULL);
  return self;
}

void
pipeline_push_back (pipeline self, scommand sc)
{
  assert (self != NULL && sc != NULL);
  self->commands = g_slist_append (self->commands, sc);
  assert (!pipeline_is_empty (self));
}

void
pipeline_pop_front (pipeline self)
{
  assert (self != NULL && !pipeline_is_empty (self));
  scommand first = g_slist_nth_data (self->commands, 0);
  self->commands = g_slist_remove (self->commands, first);
  scommand_destroy (first);
}

void
pipeline_set_wait (pipeline self, const bool w)
{
  assert (self != NULL);
  self->must_wait = w;
}

/*
  La documentación de GLib recomienda chequear la lista contra NULL
  Si se quiere ver si la lista está o no vacía.

  Ver: https://docs.gtk.org/glib/type_func.SList.length.html#description
*/
bool
pipeline_is_empty (const pipeline self)
{
  assert (self != NULL);
  return self->commands == NULL;
}

unsigned int
pipeline_length (const pipeline self)
{
  assert (self != NULL);
  unsigned int length = g_slist_length (self->commands);
  assert ((length == 0) == pipeline_is_empty (self));
  return length;
}

scommand
pipeline_front (const pipeline self)
{
  assert (self != NULL && !pipeline_is_empty (self));
  scommand result = g_slist_nth_data (self->commands, 0);
  assert (result != NULL);
  return result;
}

bool
pipeline_get_wait (const pipeline self)
{
  assert (self != NULL);
  return self->must_wait;
}

char *
pipeline_to_string (const pipeline self)
{
  assert (self != NULL);
  scommand current = NULL;
  char *result = g_strdup ("");

  if (!pipeline_is_empty (self))
    {
      unsigned int length = pipeline_length (self);
      for (unsigned int i = 0u; i < length; ++i)
        {
          if (i > 0)
            {
              result = g_strconcat (result, "|", NULL);
            }
          current = g_slist_nth_data (self->commands, i);
          result = g_strconcat (result, scommand_to_string (current), NULL);
        }
    }

  if (!pipeline_get_wait (self))
    {
      result = g_strconcat (result, "&", NULL);
    }

  assert (pipeline_is_empty (self) || pipeline_get_wait (self) ||
          strlen (result) > 0);
  return result;
}

scommand
pipeline_nth_command (const pipeline self, unsigned int n)
{
  assert (self != NULL);
  scommand command = g_slist_nth_data (self->commands, n);
  assert (command != NULL || (command == NULL && n > pipeline_length (self)));
  return command;
}
