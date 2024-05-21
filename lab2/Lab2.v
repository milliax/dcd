module gcd_top(input clk, input reset, input [15:0] A, input [15:0] B, input [15:0] C, input start, output [15:0] D, output valid);
	wire [15:0] mid_C;
    wire valid_A;
    wire valid_B;

    assign valid = valid_A && valid_B;

	GCD GCD1(.clk(clk), .reset(reset), .start(start), .A(A), .B(B), .C(mid_C), .valid(valid_A));
    GCD GCD2(.clk(clk), .reset(reset), .start(VALID), .A(mid_C), .B(C), .C(D), .valid(valid_B));

endmodule

module GCD(
    input clk, 
    input reset,
    input start,
    input [15:0] A,
    input [15:0] B,
    input test,
    output reg [15:0] C,
    output reg valid
);
	/* Implement your design here. */
    reg [15:0] X, Y, temp;
    reg started;
    reg step;
    reg minus_X;
    reg minus_Y;

    always @(posedge clk or posedge reset or step) begin
        if (reset) begin
            $display("resetting");
            X <= 16'b0;
            Y <= 16'b0;
            C <= 16'b0;
            step <= 0;
            valid <= 0;
            minus_X <= 0;
            minus_Y <= 0;
            started <= 0;
        end else if (start && !started && !valid) begin
            $display("starting, start: %d, started: %d, valid: %d",start,started,valid);
            // Initialize
            X <= A;
            Y <= B;
            valid <= 0;
            started <= 1;
            step <= !step;
            $display("Input data: X = %d, Y = %d", X, Y);
            $display("Initialized: X = %d, Y = %d", X, Y);
        end else if(start && started && !valid) begin
            $display("running: X = %d, Y = %d", X, Y);
            
            if(minus_X == 1) begin
                $display("minus X");
                if(X >= Y)begin
                    X <= X - Y;
                end else begin
                    minus_X <= 0;
                end
                step <= !step;
            end else if(minus_Y == 1) begin
                $display("minus Y");
                if(Y >= X) begin
                    Y <= Y - X;
                end else begin
                    minus_Y <= 0;
                end
                step <= !step;
            end else begin
                if(X == 0 || Y == 0) begin
                    if(X == 0) begin
                        $display("X is zero");
                        C <= Y;
                        valid <= 1;
                    end else begin
                        $display("Y is zero");
                        C <= X;
                        valid <= 1;
                    end
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

