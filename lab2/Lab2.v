module gcd_top(input clk, input reset, input [15:0] A, input [15:0] B, input [15:0] C, input start, output [15:0] D, output valid);
	wire [15:0] CC;
	wire VALID;
	GCD GCD1(.clk(clk), .reset(reset), .start(start), .A(A), .B(B), .C(CC), .valid(VALID), .id(0));
	GCD GCD2(.clk(clk), .reset(reset), .start(VALID), .A(CC), .B(C), .C(D), .valid(valid), .id(1));

endmodule

module GCD(
    input clk, 
    input reset,
    input start,
    input [15:0] A,
    input [15:0] B,
    input test,
    input id,
    output reg [15:0] C,
    output reg valid
);
	/* Implement your design here. */
    reg [15:0] X, Y, temp;
    reg started;
    reg step;
    reg minus_X;
    reg minus_Y;

    always @(clk) begin
        // $display("id :%d", id);
        if (reset) begin
            // $display("resetting");
            X <= 16'b0;
            Y <= 16'b0;
            C <= 16'b0;
            step <= 0;
            valid <= 0;
            minus_X <= 0;
            minus_Y <= 0;
            started <= 0;
        end else if(start) begin
            // reset the state
            X <= A;
            Y <= B;
            // $display("id: %d, start: X = %d, Y = %d",id, X, Y);
            valid <= 0;
            started <= 1;
        end else if(valid) begin
            // $display("id: %d, done: C = %d",id, C);
            # 1
            valid <= 0;
        end else if(!start && started) begin
            // $display("id: %d, running: X = %d, Y = %d",id, X, Y);
            
            if(minus_X == 1) begin
                if(X >= Y)begin
                // $display("minus X");
                    X <= X - Y;
                end else begin
                    minus_X <= 0;
                end
                step <= !step;
            end else if(minus_Y == 1) begin
                if(Y >= X) begin
                // $display("minus Y");
                    Y <= Y - X;
                end else begin
                    minus_Y <= 0;
                end
                step <= !step;
            end else begin
                if(X == 0 || Y == 0) begin
                    if(X == 0) begin
                        // $display("id: %d, X is zero",id);
                        C <= Y;
                    end else begin
                        // $display("id: %d, Y is zero",id);
                        C <= X;
                    end

                    // $display("id: %d, done: C = %d",id, C);
                    // $display("id: %d, done: X = %d, Y = %d",id, X, Y);

                    started <= 0;
                    valid <= 1;
                    step <= !step;

                end else if(X > Y) begin
                    minus_X <= 1;
                    step <= !step;
                end else if(X < Y) begin
                    minus_Y <= 1;
                    step <= !step;
                end else begin
                    // X == Y
                    C <= X;
                    valid <= 1;
                end
            end


        end
    end
endmodule

