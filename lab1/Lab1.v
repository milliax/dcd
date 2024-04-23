module sort(input [31:0] A, output [31:0] B);

	reg [3:0] I[8:0], tmp;
	/* Implement your design here. */

	genvar k;
	generate 
		for (k = 0; k < 8; k = k + 1) begin
			assign B[(31-(k*4)) -: 4] = I[k]; 
		end
	endgenerate
endmodule