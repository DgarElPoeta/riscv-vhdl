/*
 * Fichero:   		  macros.h
 * Autor: 		      Diego García Aranda 820506
 * Fecha entrega:	  03/06/2024
 * Comentarios:     Fichero que contiene las constantes y macros usadas en las pruebas
 *                  de los dos benchmarks realizados.
 */
#pragma once

// Dirección de mmemoria destinada al módulo PRINT_REG
#define PRINT_REG 0x00090000

// Constantes para definir el principio y fin de una función
#define EMPEZAR_FUNCION 0x4
#define FIN_FUNCION 0x2 

// Macro para la escritura de un valor en el módulo PRINT_REG
#define MARCA           \
"li t3, %0;\n\t"        \
"li t4, %1;\n\t"        \
"sw t4, 0(t3);\n\t"     

/*
 * Macro para la escritura de un valor de error en el módulo PRINT_REG y 
 * la finalización del programa
 */ 
#define FIN_ERROR       \
"li t3, %0;\n\t"        \
"li t4, %1;\n\t"        \
"sw t4, 0(t3);\n\t"     \
"loop_fin:\n\t"         \
    "j loop_fin;\n\t"
/*
 * Macro para la escritura de un valor de éxito en el módulo PRINT_REG y 
 * la finalización del programa
 */ 
#define FIN_EXITO       \
"li t3, %0;\n\t"        \
"li t4, %1;\n\t"        \
"sw t4, 0(t3);\n\t"     \
"j loop_fin;\n\t"

// Macro para la inicialización de los registros 
#define INIT_XREG                                                       \
  li x1, 0;                                                             \
  li x2, 0;                                                             \
  li x3, 0;                                                             \
  li x4, 0;                                                             \
  li x5, 0;                                                             \
  li x6, 0;                                                             \
  li x7, 0;                                                             \
  li x8, 0;                                                             \
  li x9, 0;                                                             \
  li x10, 0;                                                            \
  li x11, 0;                                                            \
  li x12, 0;                                                            \
  li x13, 0;                                                            \
  li x14, 0;                                                            \
  li x15, 0;                                                            \
  li x16, 0;                                                            \
  li x17, 0;                                                            \
  li x18, 0;                                                            \
  li x19, 0;                                                            \
  li x20, 0;                                                            \
  li x21, 0;                                                            \
  li x22, 0;                                                            \
  li x23, 0;                                                            \
  li x24, 0;                                                            \
  li x25, 0;                                                            \
  li x26, 0;                                                            \
  li x27, 0;                                                            \
  li x28, 0;                                                            \
  li x29, 0;                                                            \
  li x30, 0;                                                            \
  li x31, 0;



