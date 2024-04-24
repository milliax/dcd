#!/bin/sh

iverilog -o t_Simple_Circuit.vvp t_Simple_Circuid.v Simple_Circuit.v

vvp t_Simple_Circuit.vvp

gtkwave t_Simple_Circuit.vcd