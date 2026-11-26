module p2_handshake (clk1, clk2, rst, MAIN_data_in, MAIN_data_out, send);
    input wire clk1;
    input wire clk2;
    input wire rst;
    input wire [3:0] MAIN_data_in;
    output wire [3:0] MAIN_data_out;
    input wire send;

    wire req1, ack1, req2, ack2;
    wire [3:0] d1;

p2_sender sender_inst (
        .clk(clk1),
        .rst(rst),
        .data(MAIN_data_in),
        .req(req1),
        .ack(ack1),
        .data_out(d1),
        .send(send)
    );

d_synchronizer sync_req (
        .clk(clk2),
        .async_in(req1),
        .sync_out(req2)
    );

d_synchronizer sync_ack (
        .clk(clk1),
        .async_in(ack2),
        .sync_out(ack1)
    );

p2_receiver receiver_inst (
        .clk(clk2),
        .rst(rst),
        .data_in(d1),
        .req(req2),
        .ack(ack2),
        .received_data(MAIN_data_out)
    );
endmodule