`timescale 1ns/1ps

module booth_multiplier_tb();

    reg  [31:0] multiplicand;
    reg  [31:0] multiplier;
    wire [63:0] product;

    booth_multiplier uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );  

    initial begin
        $dumpfile("modbooth_multiplier.vcd");
        $dumpvars(0, booth_multiplier_tb);

        multiplicand = 32'd5;
        multiplier   = 32'd3;
        #10;
        $display("Test case 1: %d * %d = %d", multiplicand, multiplier, product);

        multiplicand = 32'd23;
        multiplier   = 32'd31;
        #10;
        $display("Test case 2: %d * %d = %d", multiplicand, multiplier, product);  

        multiplicand = 32'd5;
        multiplier   = 32'd10;
        #10;
        $display("Test case 3: %d * %d = %d", multiplicand, multiplier, product);  

        multiplicand = 32'd5;
        multiplier   = 32'd333;
        #10;
        $display("Test case 4: %d * %d = %d", multiplicand, multiplier, product);

        multiplicand = 32'd7;
        multiplier   = 32'd7;
        #10;
        $display("Test case 5: %d * %d = %d", multiplicand, multiplier, product);

        multiplicand = 32'hFFFFFFFE;
        multiplier   = 32'hFFFFFFFD;
        #10;
        $display("Test case 6: %d * %d = %d", multiplicand, multiplier, product);
        $finish;
    end
endmodule