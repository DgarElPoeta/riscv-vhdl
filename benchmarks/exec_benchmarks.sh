#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"

# Compiler definitions
CROSS="/opt/riscv_custom/bin/riscv32-unknown-elf-"
CC="${CROSS}gcc"
LD="${CROSS}ld"
DUMP="${CROSS}objdump"

# Compiler flags
CFLAGS="-Wall -I include -march=rv32im_zicsr -mabi=ilp32"

# Optimization compiler flags
OFLAGS=("-O1" "-O2" "-O3")
num_oflags=${#OFLAGS[@]}

# Linker flags
LDFLAGS="-nostartfiles -T linker.lds"

# Create temportal directory build 
rm -rf build
mkdir build

# Create directory speedups if not exists
if [[ ! -d "speedups" ]]
then    
    mkdir speedups
fi

# First line of the speedup file
first_line="Dimension"
for oflag in "${OFLAGS[@]}"
do
    first_line="$first_line,speedup $oflag"
done

# Get all benchmarks
cd src
benchmarks=$(ls *.c)

# Number of benchmarks
num_benchmarks=$(echo "$benchmarks" | wc -l)

cd ..

# Start file
start="src/start.S"

# Number of benchmark passing
num_pass=1

# Copy PRINT_REG.vhd to vhdl_src
cp ./vhdl/PRINT_REG.vhd ../vhdl_src/src/PRINT_REG.vhd

# For each benchmark
for benchmark in $benchmarks
do
    # Number of dimension passing
    num_dim=1

    # Get type of data and dimensions
    if [[ $benchmark == *8* ]]; then
        tipo_dato="uint8_t"
        dimensiones=(2 4 8 10 12 16 20 26 32 40 48 56 64)
    else
        tipo_dato="uint16_t"
        dimensiones=(2 4 8 10 12 16 20 26 32 40 48 56)
    fi;
    
    # Total number of dimensions
    num_dimensiones=${#dimensiones[@]}


    echo -e "\nBENCHMARK $benchmark [$num_pass/$num_benchmarks]\n"

    # Speedup file
    speedup_file="speedups/${benchmark}_speedup.txt"
    
    # Text for the speedup file
    text="$first_line"

    # For each dimension
    for dim in "${dimensiones[@]}"
    do

        echo -e "\tDimension ${dim}x$dim [$num_dim/$num_dimensiones]"

        echo -e "\tCREATING data.h "

        # Create data.h file
        python3 ./createImages.py "include/data.h" $tipo_dato $dim 2> /dev/null
        if [[ $? != 0 ]]
        then
            echo -e "\t${RED}ERROR CREATING data.h $file${NC}"
            echo -e "\tpython3 ./createImages.py include/data.h $tipo_dato $dim"
            python3 ./createImages.py include/data.h $tipo_dato $dim
            exit 1
        fi

        # Line of text for speedup file
        line="${dim}x$dim"

        # For each optimization flag
        for oflag in "${OFLAGS[@]}"
        do
            # Check if variable text is empty
            if [[ -z "$oflag" ]]; then
                echo -e "\t\tCOMPILING with no optimization flags..."
            else
                echo -e "\t\tCOMPILING with optimization flag $oflag..."
            fi
            
            # Compile benchmark
            $CC $CFLAGS $oflag -DN=$dim $LDFLAGS src/$benchmark $start -o build/main 2> /dev/null
            if [[ $? != 0 ]]
            then
                echo -e "${RED}ERROR COMPILING $file${NC}"
                echo "$CC $CFLAGS $oflag -DN=$dim $LDFLAGS src/$benchmark $start -o build/main"
                $CC $CFLAGS $oflag -DN=$dim $LDFLAGS src/$benchmark $start -o build/main
                exit 1
            fi
            

            # Create RAM vhdl files
            python3 ../common/elf.py > build/ram.dumpu

            # Compile vhdl and simulate
            cd ../vhdl_src
            rm -rf build
            bash ./scripts/vhdl_comp.sh
            cd build
            echo -e "\t\tSIMULATING..."
            benchmark_result=$(ghdl -r  "riscv" --assert-level=error &> ../../benchmarks/build/salida.txt)
            
            # Get simulation results
            reports=$(cat "../../benchmarks/build/salida.txt" | grep "report")

            # Remove temporal file for simulation results
            rm ../../benchmarks/build/salida.txt

            notes=$(echo "$reports" | grep "note")

            # Get simulation result
            result=$(echo "$reports" | grep -E "error" | grep -Eo "[0-9]+$")

            # Check if simulation passed
            if [[ "$result" -eq "0" ]]
            then
                echo -e "\t\t${GREEN}Benchmark $benchmark $oflag PASSED${NC}"
                echo -e "\t\t--------"
                
            else
                echo -e "\t\t${RED}Benchmark $benchmark $flag FAILED. Different values between base and simd versions ${NC}"
                exit 1
            fi

            # Get simulation times
            times=$(echo "$notes" | grep -oP '@\d+ns' | sed 's/@//;s/ns//')
            arraytimes=($times)

            # Calculate speedup
            difference1=$((${arraytimes[1]} - ${arraytimes[0]}))
            difference2=$((${arraytimes[3]} - ${arraytimes[2]}))
            speedup=$(echo "scale=2; $difference1 / $difference2" | bc)

            # Add speedup to line
            line="$line,$speedup"

            cd ../../benchmarks
        done

        # Increment number of dimension passing
        ((num_dim++))

        # Add line to text
        text="$text\n$line"
        
    done

    # Write text to speedup file
    echo -e "$text" | column -t -s ',' > $speedup_file

    # Increment number of benchmark passing
    ((num_pass++))

done

