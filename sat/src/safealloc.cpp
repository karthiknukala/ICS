/* Copyright (c) SRI International 2002. */
/***
   PURPOSE
     
   NOTES
     
   HISTORY
     demoura - May 10, 2001: Created.
***/
#include <iostream>
#include <stdlib.h>
#include <string.h>
#include <new>
#include "safealloc.h"

void memoryExhausted()
{
  std::cerr << "Memory exhausted...\n";
  abort();
}

void * xmalloc(size_t size)
{
  void * aux = malloc(size);
  if (aux == NULL)
	memoryExhausted();
  return aux;
}

char * xstrdup(const char * const source)
{
  char * aux = strdup(source);
  if (aux == NULL)
	memoryExhausted();
  return aux;
}

void setNewHandler()
{
  std::set_new_handler(memoryExhausted);
}
