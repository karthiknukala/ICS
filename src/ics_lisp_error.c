
/* Caml errors sent to Lisp. */

#include <stdio.h>

/* add a global variable which is set in init and depending on */
/* its value for ics_init dispatch. */

typedef void (*lisp_error_fn)(char *, char *);

/*
 * Older builds expected the hosting Lisp image to provide this symbol.
 * Keep the library self-contained by defaulting to stderr when it is absent.
 */
static void *lisp_call_address(int index) {
  (void)index;
  return NULL;
}

static lisp_error_fn lisp_error_function_address = NULL;

void ics_error(char* funname, char* msg) {
  if (lisp_error_function_address != NULL) {
    (*lisp_error_function_address)(funname, msg);
  } else {
    fprintf(stderr, "%s: %s\n", funname, msg);
    fflush(stderr);
  }
}

void register_lisp_error_function(int index) {
  lisp_error_function_address = (lisp_error_fn) lisp_call_address(index);
}
