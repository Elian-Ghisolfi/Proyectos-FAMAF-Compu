#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main (int argc, char *argv[])
{
  if (argc <= 1)
    {
      fprintf (2, "ERROR: you have to provide <rounds> argument.\n");
      exit (0);
    };

  uint n = atoi (argv[1]);

  if (n < 1)
    {
      fprintf (
          2, "ERROR: number of rounds should be greater or equal than one.\n");
      exit (1);
    }

  if (sem_open (0, 1) == 0)
    {
      fprintf (2, "ERROR: failed to open first semaphore.\n");
      exit (1);
    }

  int pid = fork ();
  if (pid == -1)
    {
      fprintf (2, "ERROR: failed to fork process.\n");
      exit (0);
    }
  else if (pid == 0)
    {
      for (uint i = 0u; i < n; ++i)
        {
          sem_down (0);
          printf ("    pong\n");
          sem_up (0);
        }
    }
  else
    {
      for (uint i = 0u; i < n; ++i)
        {
          sem_down (0);
          printf ("ping\n");
          sem_up (0);
        }
    }

  wait (&pid);
  exit (0);
}
