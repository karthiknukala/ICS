#include <stdio.h> 
#include <string.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/callback.h>
#include <caml/memory.h>
#include <caml/fail.h>

char* version = VERSION;
char* arch = ARCHITECTURE;
char* date = BUILDDATE;
int debug = DEBUG;
char* flags = COMPILATION_FLAGS;

CAMLprim value print_version(value unit) {
  (void)unit;
  fprintf(stdout, "ICS %s (%s, %s)", version, arch, date); 
  if (debug == 1) {
    fprintf(stdout, "\nDebugging enabled.");
  };
  fflush(stdout);
  return Val_unit;
}

CAMLprim value eprint_version(value unit) {
  (void)unit;
  fprintf(stderr,"ICS %s (%s, %s)", version, arch, date); 
  if (debug == 1) {
    fprintf(stderr,"\nDebugging enabled.");
  };
  fflush(stderr);
  return Val_unit;
}

CAMLprim value debug_value (value unit) {
  (void)unit;
  return Val_int(debug);
}
