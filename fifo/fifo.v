module async_fifo (
    fifo_in,
    fifo_out,
    clk1,
    clk2,
    rst,
    wr_ptr,
    rd_ptr,
    data_in,
    data_out,
    full,
    empty
);
     input fifo_in;
    input fifo_out;

    input clk1;
    input clk2;

    input rst;

    input [7:0] data_in;

    output reg [17:0] wr_ptr;
    output reg [17:0] rd_ptr;

    output reg [7:0] data_out;

    output full;
    output empty;


    reg [7:0] fifo_mem [0:6143];


    wire [17:0] wr_ptr_gray;
    wire [17:0] rd_ptr_gray;

    assign wr_ptr_gray = wr_ptr ^ (wr_ptr >> 1);
    assign rd_ptr_gray = rd_ptr ^ (rd_ptr >> 1);


    reg [17:0] wr_ptr_gray_sync1;
    reg [17:0] wr_ptr_gray_sync2;


    reg [17:0] rd_ptr_gray_sync1;
    reg [17:0] rd_ptr_gray_sync2;


    wire [17:0] rd_ptr_gray_full;


    always @(posedge clk2 or posedge rst) begin

        if (rst) begin
            wr_ptr_gray_sync1 <= 18'b000000000000000000;
            wr_ptr_gray_sync2 <= 18'b000000000000000000;
        end

        else begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        end

    end

    always @(posedge clk1 or posedge rst) begin

        if (rst) begin
            rd_ptr_gray_sync1 <= 18'b000000000000000000;
            rd_ptr_gray_sync2 <= 18'b000000000000000000;
        end

        else begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        end

    end

    always @(posedge clk1 or posedge rst) begin

        if (rst) begin
            wr_ptr <= 18'b0;
        end

        else begin

            if (fifo_in && !full) begin
                wr_ptr <= wr_ptr + 1'b1;
            end

        end

    end

    always @(posedge clk2 or posedge rst) begin

        if (rst) begin
            rd_ptr <= 18'b0;
        end

        else begin

            if (fifo_out && !empty) begin
                rd_ptr <= rd_ptr + 1'b1;
            end

        end

    end

    always @(posedge clk1 or posedge rst) begin

        if (rst) begin
            // Memory does not need to be reset
        end

        else begin

            if (fifo_in && !full) begin
                fifo_mem[wr_ptr[17:0]] <= data_in;
            end

        end

    end

    always @(posedge clk2 or posedge rst) begin

        if (rst) begin
            data_out <= 8'b0;
        end

        else begin

            if (fifo_out && !empty) begin
                data_out <= fifo_mem[rd_ptr[17:0]];
            end

        end

    end

    assign empty = (rd_ptr_gray == wr_ptr_gray_sync2);

    assign rd_ptr_gray_full = {
        ~rd_ptr_gray_sync2[17:16],
         rd_ptr_gray_sync2[15:0]
    };

    assign full = (wr_ptr_gray == rd_ptr_gray_full);


endmodule