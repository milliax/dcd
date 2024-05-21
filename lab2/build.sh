#!/bin/bash

# Set the source file(s) and output file name
SOURCE_FILE="gcd_simple_tb.v Lab2.v"
OUTPUT_FILE="compiled_output.vvp"

# Compile the source file(s) using iverilog
iverilog -o $OUTPUT_FILE $SOURCE_FILE

# Check if the compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful!"
    echo "Running the compiled output..."
    # Run the compiled output
    vvp $OUTPUT_FILE
    # gtkwave gcd_simple.vcd
else
    echo "Compilation failed."
fi