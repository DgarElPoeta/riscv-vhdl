#include "macros.h"
.section .init
.globl _start
_start:
    INIT_XREG
    jal main