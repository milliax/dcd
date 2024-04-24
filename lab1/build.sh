#!/bin/sh

rm output.vvp sort_tb.vcd
iverilog -o output.vvp Lab1.v testbench.v

vvp output.vvp

gtkwave sort_tb.vcd
