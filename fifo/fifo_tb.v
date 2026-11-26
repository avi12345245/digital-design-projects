`timescale 1ns/1ps

module async_fifo_tb;

reg clk1;
reg clk2;
reg rst;

reg fifo_in;
reg fifo_out;

reg [7:0] data_in;
wire [7:0] data_out;

wire full;
wire empty;

async_fifo uut (
    .fifo_in(fifo_in),
    .fifo_out(fifo_out),

    .clk1(clk1),
    .clk2(clk2),
    .rst(rst),

    .data_in(data_in),
    .data_out(data_out),

    .full(full),
    .empty(empty)
);

initial begin
    clk1 = 0;

    forever #5 clk1 = ~clk1;
end

initial begin
    clk2 = 0;

    #2;

    forever #7 clk2 = ~clk2;
end

initial begin

    $dumpfile("async_fifo_aryan.vcd");

    $dumpvars(0, async_fifo_tb);

end

initial begin


    rst = 1;

    fifo_in = 0;
    fifo_out = 0;

    data_in = 8'b00000011;

    #20;

    rst = 0;

    @(posedge clk1);

    data_in = 8'b00010000;
    fifo_in = 1;

    @(posedge clk1);

    fifo_in = 0;

    @(posedge clk1);

    data_in = 8'b00000110;
    fifo_in = 1;

    @(posedge clk1);

    fifo_in = 0;

    @(posedge clk1);

    data_in = 8'b00000010;
    fifo_in = 1;

    @(posedge clk1);

    fifo_in = 0;

    @(posedge clk1);

    data_in = 8'b00000111;
    fifo_in = 1;

    @(posedge clk1);

    fifo_in = 0;

    #40;

    @(posedge clk2);

    fifo_out = 1;

    @(posedge clk2);

    fifo_out = 0;

    @(posedge clk2);

    fifo_out = 1;

    @(posedge clk2);

    fifo_out = 0;


    @(posedge clk2);

    fifo_out = 1;

    @(posedge clk2);

    fifo_out = 0;


    @(posedge clk2);

    fifo_out = 1;

    @(posedge clk2);

    fifo_out = 0;

    #50;


    $finish;

end

endmodule