module p2_receiver (
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] data_in,   
    input  wire       req,       
    output reg        ack,       
    output reg  [3:0] received_data
);

    always @(posedge rst) begin
        ack           <= 1'b0;
        received_data <= 4'b0000;
    end

    always @(posedge clk) begin
        if (!rst) begin
            if (req != ack) begin
                received_data <= data_in;
                ack           <= ~ack;
            end
        end
    end

endmodule