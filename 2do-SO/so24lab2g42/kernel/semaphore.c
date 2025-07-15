#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "spinlock.h"
#include "semaphore.h"

#define SEMAPHORE_FAILURE 0
#define SEMAPHORE_SUCCESS 1
#define MAX_SEMAPHORES 10

struct _s_semaphore
{
  struct spinlock lock;
  int id;
  int value;
};

semaphore semaphores[MAX_SEMAPHORES];

int
sem_open (int sem, int value)
{
  semaphore current = (semaphore)kalloc ();
  current->id = sem;
  current->value = value;
  initlock (&current->lock, "semaphore");
  semaphores[sem] = current;

  return SEMAPHORE_SUCCESS;
}

int
sem_close (int sem)
{

  if (sem < 0 || sem >= MAX_SEMAPHORES || semaphores[sem] == 0)
    {
      printf ("ERROR: trying to close an invalid "
              "semaphore.");
      return SEMAPHORE_FAILURE;
    }
  if (&semaphores[sem]->value > 0)
    {
      printf ("ERROR: the semaphore %d is still in use.", sem);
      return SEMAPHORE_FAILURE;
    }

  acquire (&semaphores[sem]->lock);

  kfree ((char *)semaphores[sem]);

  semaphores[sem] = 0;

  release (&semaphores[sem]->lock);

  return SEMAPHORE_SUCCESS;
}

int
sem_up (int sem)
{
  semaphore current = semaphores[sem];
  acquire (&current->lock);
  current->value += 1;
  wakeup (current);
  release (&current->lock);

  return SEMAPHORE_SUCCESS;
}

int
sem_down (int sem)
{
  semaphore current = semaphores[sem];
  acquire (&current->lock);
  while (current->value == 0)
    {
      sleep (current, &current->lock);
    }

  current->value -= 1;
  release (&current->lock);

  return SEMAPHORE_SUCCESS;
}
