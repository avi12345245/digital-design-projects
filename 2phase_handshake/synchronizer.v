module d_synchronizer (clk, async_in, sync_out);
    input clk;
    input wire async_in;
    output wire sync_out;
    wire mrsync_out;

dff dff1(.d(async_in), .clk(clk), .q(mrsync_out));
dff dff2(.d(mrsync_out), .clk(clk), .q(sync_out));

endmodule