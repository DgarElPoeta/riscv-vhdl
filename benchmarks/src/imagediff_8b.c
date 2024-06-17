/*
 * Fichero:   		imagediff_8b.cpp
 * Autor: 		    Diego García Aranda 820506
 * Fecha entrega:	03/06/2024
 * Comentarios:     Fichero que realiza una diferencia entres los píxeles de dos imágenes.
 *                  Las imágenes se representan como matrices de enteros sin signo de 8 bits.
 *                  Se ejecutan dos versiones: con y sin instrucciones del repertorio SIMD 
 *                  definido, y se compara el resultado de ambas versiones para comprobar 
 *                  que son iguales. Si lo son se muestra un mensaje de éxito, si no lo son 
 *                  se muestra un mensaje de error.
 */
#include <stdio.h>
#include <stdint.h>
#include "data.h"   // Incluimos el fichero con las matrices de datos
#include "macros.h" // Incluimos el fichero de macros en ensamblador



int main() {

    //////////////////////////////////////////////////////////////////////////////////////
    
    // Diferencia entre los píxeles de dos imágenes sin instrucciones SIMD

    /*
     * Código en ensamblador para mostrar por pantalla el tiempo de inicio de la ejecución
     * de la diferencia entre los píxeles de dos imágenes sin instrucciones SIMD
     */  
    asm volatile(
        MARCA
        :
        : "i"(PRINT_REG), "i"(EMPEZAR_FUNCION) // Operandos de entrada
    );

    /*
     * Bucle en alto nivel que realiza la diferencia entre los píxeles de dos imágenes sin 
     * instrucciones SIMD
     */  
    
    for (uint32_t i = 0; i < N*N; i++) {
        resul_base[i] = data1[i] > data2[i] ? data1[i] - data2[i] : data2[i] - data1[i];
    }

    /*
     * Código en ensamblador para mostrar por pantalla el tiempo de fin de la ejecución
     * de la diferencia entre los píxeles de dos imágenes sin instrucciones SIMD
     */  
    asm volatile(
        MARCA
        :
        : "i"(PRINT_REG), "i"(FIN_FUNCION) // Operandos de entrada
    );

    //////////////////////////////////////////////////////////////////////////////////////




    //////////////////////////////////////////////////////////////////////////////////////

    // Diferencia entre los píxeles de dos imágenes con instrucciones SIMD

    /*
     * Código en ensamblador para mostrar por pantalla el tiempo de inicio de la ejecución
     * de la diferencia entre los píxeles de dos imágenes con instrucciones SIMD
     */  
    asm volatile(
        MARCA
        :
        : "i"(PRINT_REG), "i"(EMPEZAR_FUNCION) // Operandos de entrada
    );

    /*
     * Bucle en alto nivel cuyo cuerpo está en ensamblador que realiza la diferencia entre 
     * los píxeles de dos imágenes con instrucciones SIMD
     */  
    for (uint32_t i = 0; i < N*N; i+= 4) {
        asm volatile (
            "lw t1, 0(%0)\n\t"       // Cargar los valores de 8 bits de data1[i:i+3] en t1
            "lw t2, 0(%1)\n\t"       // Cargar los valores de 8 bits de data2[i:i+3] en t2
            "sltu8 t3, t2, t1\n\t"   // t3 almacena 0xffff en los valores de 8 bits que t1 es mayor que t2
            "sltu8 t4, t1, t2\n\t"   // t4 almacena 0xffff en los valores de 8 bits que t2 es mayor que t1
            "and t5, t1, t3\n\t"     // t5 almacena los valores de 8 bits de t1 que son mayores que t2
            "and t6, t2, t4\n\t"     // t6 almacena los valores de 8 bits de t2 que son mayores que t1
            "or t5, t6, t5\n\t"      // t5 almacena los valores de 8 bits mas grándes entre t1 y t2
            "and t4, t1, t4\n\t"     // t3 almacena los valores de 8 bits de t1 que son menores que t2
            "and t3, t2, t3\n\t"     // t4 almacena los valores de 8 bits de t2 que son menores que t1
            "or t6, t4, t3\n\t"      // t6 almacena los valores de 8 bits mas pequeños entre t1 y t2
            "sub8 t1, t5, t6\n\t"    // t1 almacena la diferencia entre los valores de 8 bits de t1 y t2
            "sw t1, 0(%2);"          // Escribe t1 en resul_simd[i:i+3]
            : // Sin operandos de salida
            : "r"(data1 + i), "r"(data2 + i), "r"(resul_simd + i) // Operandos de entrada
            : "t1","t2","t3","t4","t5","t6"  // Registros temporales usados
        );
    }

    /*
     * Código en ensamblador para mostrar por pantalla el tiempo de fin de la ejecución
     * de la diferencia entre los píxeles de dos imágenes con instrucciones SIMD
     */
    asm volatile(
        MARCA
        :
        : "i"(PRINT_REG), "i"(FIN_FUNCION) // Operandos de entrada
    );

    //////////////////////////////////////////////////////////////////////////////////////




    //////////////////////////////////////////////////////////////////////////////////////

    // Comprobación de los resultados de la Diferencia entre los píxeles de dos imágenes con y sin 
    // instrucciones SIMD

    /*
     * Bucle en alto nivel que compara los resultados de la diferencia entre los píxeles de dos 
     * imágenes con y sin instrucciones SIMD.
     * Si en algún momento los resultados no coinciden, se muestra un mensaje de error.
     */
    for (uint32_t i = 0; i < N*N; i++) {
        if (resul_base[i] != resul_simd[i]) {
            /*
            * Código en ensamblador para mostrar por pantalla un mensaje de error en caso de
            * que algún resultado de la diferencia entre los píxeles de dos imágenes con y sin 
            * instrucciones SIMD no coincidan.
            */
            asm volatile(
                FIN_ERROR
                :
                : "i"(PRINT_REG), "i"(1) // Operandos de entrada 
            );
            break;
        }
    }


    /*
     * Código en ensamblador para mostrar por pantalla un mensaje de éxito en caso de que 
     * los resultados de la diferencia entre los píxeles de dos imágenes con y sin 
     * instrucciones SIMD coincidan.
     */
    asm volatile(
        FIN_EXITO
        :
        : "i"(PRINT_REG),"i"(0) // Operandos de entrada
    );

    //////////////////////////////////////////////////////////////////////////////////////
    

    
}
