// module sort(input reg [31:0] A, output [31:0] B);
module sort(input [31:0] A, output reg [31:0] B);

	/* Implement your design here. */
    
    reg [3:0] I [7:0];
    reg [3:0] temp;
    reg integer i, j;
    always @(*) begin
        I[0] = A[31:28];
        I[1] = A[27:24];
        I[2] = A[23:20];
        I[3] = A[19:16];
        I[4] = A[15:12];
        I[5] = A[11:8];
        I[6] = A[7:4];
        I[7] = A[3:0];
        for (i=0;i<7;i=i+1)begin
            $display("I[%d] = %b", i, I[i]);
        end
        for (i = 0; i<7 ; i = i+1) begin
            for (j = 0; j<7-i ; j = j+1) begin
                if (I[j] < I[j+1]) begin
                    temp = I[j];
                    I[j] = I[j+1];
                    I[j+1] = temp;
                end
            end
        end
        B = {I[0], I[1], I[2], I[3], I[4], I[5], I[6], I[7]};
    end

endmodule

