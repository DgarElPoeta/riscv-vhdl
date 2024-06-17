import random
import sys
def ejecucion_correcta():
    print("Uso: python3 createImages.py <archivo_salida> <tipo_dato> <dimension>\n\tdonde tipo dato puede ser uint8_t o uint16_t \n")

# Función que comprueba que el número de parámetros sea correcto
def comprobar_parametros():
    if len(sys.argv) != 4 :
        print("Error: El número de parámetros no es correcto")
        ejecucion_correcta()
        sys.exit(1)
    elif sys.argv[2] not in ("uint8_t", "uint16_t"):
        print("Error: El tipo de dato no es correcto")
        ejecucion_correcta()
        sys.exit(1)


def generate_random_data(length,tipo_dato):
    if (tipo_dato == "uint8_t"):
        return [random.randint(0, 255) for _ in range(length)]
    elif (tipo_dato == "uint16_t"):
        return [random.randint(0, 65535) for _ in range(length)]
    else:
        return [0 for _ in range(length)]

def escribirFichero(filename,tipo_dato,dimension):
    with open(filename, 'w') as file:
        file.write("/*\n")
        file.write(" * Fichero:\t\t\tdata.h\n")
        file.write(" * Autor:\t\t\tDiego GArcía Aranda 820506\n")
        file.write(" * Fecha entrega:\t03/06/2024\n")
        file.write(" * Comentarios:\t\tFichero que contiene las matrices de datos usadas en las pruebas\n")
        file.write(" * \t\t\t\t\tde los dos benchmarks realizados\n")
        file.write(" */\n")
        file.write("#pragma once\n")
        file.write("#include <stdint.h>\n\n")

        length = int(dimension)*int(dimension)

        random_data = generate_random_data(length,tipo_dato)
        file.write("__attribute__((aligned(4))) const "+ tipo_dato + " data1[N * N] = {\n")
        for i in range(length):
            if i % 16 == 0:
                file.write("\n    ")
            file.write(f"{random_data[i]}, ")
        file.write("\n};\n\n")
        
        random_data = generate_random_data(length,tipo_dato)
        file.write("__attribute__((aligned(4))) const "+ tipo_dato + " data2[N * N] = {\n")
        for i in range(length):
            if i % 16 == 0:
                file.write("\n    ")
            file.write(f"{random_data[i]}, ")
        file.write("\n};\n\n")

        file.write("__attribute__((aligned(4))) volatile "+ tipo_dato + " resul_base[N * N];\n\n")
        file.write("__attribute__((aligned(4))) volatile "+ tipo_dato + " resul_simd[N * N];\n\n")



# Comprobar que el número de parámetros sea correcto
comprobar_parametros()

# Obtener el nombre de archivo de salida
archivo_salida = sys.argv[1]

# Obtener el tipo de dato
tipo_dato = sys.argv[2]

# Obtener dimensión de la imagen
dimension = sys.argv[3]

escribirFichero(archivo_salida,tipo_dato,dimension)
