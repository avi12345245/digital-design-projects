`timescale 1ns/1ps

module ph_tb;

reg clk1;
reg clk2;
reg rst;

reg [3:0] MAIN_data_in;
wire [3:0] MAIN_data_out;
reg send;

// DUT
p2_handshake uut (
    .clk1(clk1),
    .clk2(clk2),
    .rst(rst),
    .MAIN_data_in(MAIN_data_in),
    .MAIN_data_out(MAIN_data_out),
    .send(send)
);

// ------------------------------------------------
// CLK1 : 10 ns period
// ------------------------------------------------
initial begin
    clk1 = 0;
    forever #5 clk1 = ~clk1;
end

// ------------------------------------------------
// CLK2 : 14 ns period
// Starts 2 ns later
// ------------------------------------------------
initial begin
    clk2 = 0;
    #2;
    forever #7 clk2 = ~clk2;
end

// ------------------------------------------------
// Waveform
// ------------------------------------------------
initial begin
    $dumpfile("2ph_tb.vcd");
    $dumpvars(0, ph_tb);
end

// ------------------------------------------------
// Test
// ------------------------------------------------
initial begin

    rst = 1;
    send = 0;
    MAIN_data_in = 4'b0000;

    // Reset
    #20;
    rst = 0;

    // --------------------------------------------
    // Transfer 1
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b0001;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 2
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b0010;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 3
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b0011;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 4
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b0100;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 5
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b0101;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 6
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b0110;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 7
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b0111;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 8
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b1000;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 9
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b1001;
    send = 1;

    @(posedge clk1);
    send = 0;

    #20;

    // --------------------------------------------
    // Transfer 10
    // --------------------------------------------

    @(posedge clk1);
    MAIN_data_in = 4'b1010;
    send = 1;

    @(posedge clk1);
    send = 0;

    #100;

    $finish;

end

endmodule