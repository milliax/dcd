`timescale 1ns / 1ps

module testbench();

    // Inputs
    reg [31:0] A;

    // Outputs
    wire [31:0] B;

    // Instantiate the module under test
    sort uut (
        .A(A),
        .B(B)
    );

    integer parsed_value;
    // show answer
    initial begin
        // Set the name of the dump file.
        $dumpfile("./sort_tb.vcd"); 
        // inset your module name
        $dumpvars(0,uut);  
        #100
        // set your input value
        A = 32'b10001001101010111100101111101111;
        #100;
        $display("Output B: %b", B);
        $finish;
    end
endmodule
