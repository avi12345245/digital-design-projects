module p2_sender(clk, rst, data, req, ack, data_out, send);
    input clk;
    input rst;
    input wire [3:0] data;
    output reg req;
    input wire ack;
    output reg [3:0] data_out;
    input wire send;

    always@ (posedge rst) begin
            req <= 1'b0;
            data_out <= 4'b0000;
        end
    always@ (posedge clk) begin
        if(!rst) begin
        if (req == ack) begin
            if (send) begin
           data_out <= data;
           req <= ~req; 
        end
        end   
    end
    end
endmodule