#include <stdio.h>   // fprintf, std_streams
#include <stdbool.h> // bool
#include <stdarg.h>

bool do_system(const char *command);

bool do_exec(int count, ...);

bool do_exec_redirect(const char *outputfile, int count, ...);
