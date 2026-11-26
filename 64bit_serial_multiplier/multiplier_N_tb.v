`timescale 1ns/1ps

module Multiplier_N_tb #(parameter N = 64) ();
    reg clk;
    reg rst_n;
    reg start;
    reg [N-1:0] in_multiplier;
    reg [N-1:0] in_multiplicand;
    wire [2*N-1:0] product;
    wire done;

    CSA_64 #(N) uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .in_multiplier(in_multiplier),
        .in_multiplicand(in_multiplicand),
        .product(product),
        .done(done)
    );

initial clk = 0;
always #5 clk = ~clk;

    initial begin
        $dumpfile("Multiplier_N_tb.vcd");
        $dumpvars(0, Multiplier_N_tb);
        
        rst_n = 0;
        start = 0;
        in_multiplier = 0;
        in_multiplicand = 0;

        #20 rst_n = 1;

        #10 in_multiplier = 64'h0000000000000003;
            in_multiplicand = 64'h0000000000000004;
            start = 1;

        #10 start = 0;

        wait(!done); wait(done);

        $display("Test Case 1: %h * %h = %0h", in_multiplier, in_multiplicand, product);

        #20 in_multiplier = 64'h000000000000000A;
            in_multiplicand = 64'h000000000000000B;
            start = 1;

        #10 start = 0;

        wait(!done); wait(done);

        $display("Test Case 2: %h * %h = %0h", in_multiplier, in_multiplicand, product);

        #20 in_multiplier = 64'h0000000000000ABC;
            in_multiplicand = 64'h00000000000000DB;
            start = 1;

        #10 start = 0;

        wait(!done); wait(done);

        $display("Test Case 3: %h * %h = %0h", in_multiplier, in_multiplicand, product);
        #20 in_multiplier = 64'h0000000000016338;
            in_multiplicand = 64'h000000000000A1B2;
            start = 1;

        #10 start = 0;

        wait(!done); wait(done);

        $display("Test Case 4: %h * %h = %0h", in_multiplier, in_multiplicand, product);
        #20 in_multiplier = 64'h00007620000F000A;
            in_multiplicand = 64'h000000057200000B;
            start = 1;

        #10 start = 0;

        wait(!done); wait(done);

        $display("Test Case 5: %h * %h = %0h", in_multiplier, in_multiplicand, product);
        #20 in_multiplier = 64'h000111000000000A;
            in_multiplicand = 64'h000000000777000B;
            start = 1;

        #10 start = 0;

        wait(!done); wait(done);

        $display("Test Case 6: %h * %h = %0h", in_multiplier, in_multiplicand, product);
        #20 in_multiplier = 64'hFFFFFFFFFFFFFFFF;
            in_multiplicand = 64'hFFFFFFFFFFFFFFFF;
            start = 1;

        #10 start = 0;

        wait(!done); wait(done);

        $display("Test Case 7: %h * %h = %0h", in_multiplier, in_multiplicand, product);
    $finish;
    end
endmodule
