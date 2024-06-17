/*
 * Fichero:   		matadd_8b.cpp
 * Autor: 		    Diego García Aranda 820506
 * Fecha entrega:	03/06/2024
 * Comentarios:     Programa que realiza una suma de matrices con saturación para enteros
 *                  sin signo de 8 bits. Se ejecutan dos versiones: con y sin 
 *                  instrucciones del repertorio SIMD definido, y se compara el resultado
 *                  de ambas versiones para comprobar que son iguales. Si lo son se 
 *                  muestra un mensaje de éxito, si no lo son se muestra un mensaje de 
 *                  error.
 */
#include <stdio.h>
#include <stdint.h>
#include "data.h"   // Incluimos el fichero con las matrices de datos
#include "macros.h" // Incluimos el fichero de macros en ensamblador


int main() {

    //////////////////////////////////////////////////////////////////////////////////////
    
    // Suma de matrices con saturación sin instrucciones SIMD

    /*
     * Código en ensamblador para mostrar por pantalla el tiempo de inicio de la ejecución
     * de la suma de matrices con saturación sin instrucciones SIMD
     */
    asm volatile(
        MARCA
        :
        : "i"(PRINT_REG), "i"(EMPEZAR_FUNCION) // Operandos de entrada
    );

    /*
     * Bucle en alto nivel que realiza la suma de matrices con saturación sin instrucciones SIMD
     */  
    for (uint32_t i = 0; i < N*N; i++) {
        uint8_t res = data1[i] + data2[i];
        if (res < data1[i]) res = UINT8_MAX;
        resul_base[i] = res;
    }

    /*
     * Código en ensamblador para mostrar por pantalla el tiempo de fin de la ejecución
     * de la suma de matrices con saturación sin instrucciones SIMD
     */  
    asm volatile(
        MARCA
        :
        : "i"(PRINT_REG), "i"(FIN_FUNCION) // Operandos de entrada
    );

    //////////////////////////////////////////////////////////////////////////////////////




    //////////////////////////////////////////////////////////////////////////////////////

    // Suma de matrices con saturación con instrucciones SIMD

    /*
     * Código en ensamblador para mostrar por pantalla el tiempo de inicio de la ejecución
     * de la suma de matrices con saturación con instrucciones SIMD
     */  
    asm volatile(
        MARCA
        :
        : "i"(PRINT_REG), "i"(EMPEZAR_FUNCION) // Operandos de entrada
    );

    /*
     * Bucle en alto nivel cuyo cuerpo está en ensamblador que realiza la suma de matrices con saturación con instrucciones SIMD
     */  
    for (uint32_t i = 0; i < N*N; i+= 4) {
        asm volatile (
            "lw t3, 0(%0)\n\t"       // Cargar los valores de 8 bits de data1[i:i+3] en t3
            "lw t4, 0(%1)\n\t"       // Cargar los valores de 8 bits de data2[i:i+3] en t4
            "add8 t4, t3, t4\n\t"   // t4 almacena la suma de los valores de 8 bits de t3 y t4 
            "sltu8 t3, t4, t3\n\t"  // t3 almacena los valores de 8 bits cuya suma ha producido un desbordamiento
            "or t3, t3, t4\n\t"      // t3 almacena la suma de los valores de 8 bits de de data1[i:i+3] y data2[i:i+3] con 
                                     // saturación
            "sw t3, 0(%2);"          // Escribir t3 en resul_simd[i:i+3]
            : // Sin operandos de salida
            : "r"(data1 + i), "r"(data2 + i), "r"(resul_simd + i) // Operandos de entrada
            : "t3","t4"  // Registros temporales usados
        );
    }

    /*
     * Código en ensamblador para mostrar por pantalla el tiempo de fin de la ejecución
     * de la suma de matrices con saturación con instrucciones SIMD
     */
    asm volatile(
        MARCA
        :
        : "i"(PRINT_REG), "i"(FIN_FUNCION) // Operandos de entrada
    );

    //////////////////////////////////////////////////////////////////////////////////////




    //////////////////////////////////////////////////////////////////////////////////////

    // Comprobación de los resultados de la suma de matrices con saturación con y sin 
    // instrucciones SIMD

    /*
     * Bucle en alto nivel que compara los resultados de la suma de matrices con saturación
     * con y sin instrucciones SIMD.
     * Si en algún momento los resultados no coinciden, se muestra un mensaje de error.
     */
    for (uint32_t i = 0; i < N*N; i++) {
        if (resul_base[i] != resul_simd[i]) {
            /*
            * Código en ensamblador para mostrar por pantalla un mensaje de error en caso de
            * que algún resultado de la suma de matrices con saturación con y sin instrucciones
            * SIMD no coincidan.
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
     * los resultados de la suma de matrices con saturación con y sin instrucciones SIMD
     * coincidan.
     */
    asm volatile(
        FIN_EXITO
        :
        : "i"(PRINT_REG),"i"(0) // Operandos de entrada
    );

    //////////////////////////////////////////////////////////////////////////////////////
    

    
}