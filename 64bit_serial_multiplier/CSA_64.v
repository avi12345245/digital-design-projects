module CSA_64 #(parameter N = 64) (clk, rst_n, start, in_multiplier, in_multiplicand, product, done);
    input  wire clk;
    input  wire rst_n;
    input  wire start;
    input  wire [N-1:0] in_multiplier;
    input  wire [N-1:0] in_multiplicand;
    output reg  [2*N-1:0] product;
    output reg  done;

    reg [N-1:0] multiplicand_reg;
    reg [N-1:0] multiplier_reg;
    reg [N-1:0] accum_sum;
    reg [N-1:0] accum_carry;
    
    reg [6:0]   count;
    reg         running;

    wire [N-1:0] pp;
    assign pp = multiplicand_reg & {N{multiplier_reg[0]}};

    wire [N-1:0] csa_sum;
    wire [N-1:0] csa_cout;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : gen_csa
            full_adder fa ( .a(accum_sum[i]), .b(pp[i]), .cin(accum_carry[i]), .sum(csa_sum[i]), .cout(csa_cout[i]));
        end
    endgenerate

    wire [N:0] rca_sum;
    wire [N:0] rca_carry;
    
    assign rca_carry[0] = 1'b0;
    
    generate
        for (i = 0; i < N; i = i + 1) begin : gen_rca
            full_adder fa_rca (
                .a(accum_sum[i]),
                .b(accum_carry[i]),
                .cin(rca_carry[i]),
                .sum(rca_sum[i]),
                .cout(rca_carry[i+1])
            );
        end
    endgenerate
    assign rca_sum[N] = rca_carry[N];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            accum_sum        <= {N{1'b0}};
            accum_carry      <= {(N+1){1'b0}};
            multiplier_reg   <= {N{1'b0}};
            multiplicand_reg <= {N{1'b0}};
            count            <= 7'd0;
            running          <= 1'b0;
            done             <= 1'b0;
            product          <= {2*N{1'b0}};
        end else if (start && !running) begin
            accum_sum        <= {N{1'b0}};
            accum_carry      <= {(N+1){1'b0}};
            multiplier_reg   <= in_multiplier;
            multiplicand_reg <= in_multiplicand;
            count            <= 7'd0;
            running          <= 1'b1;
            done             <= 1'b0;
        end else if (running) begin
            if (count < N) begin
                accum_sum   <= {1'b0, csa_sum[N-1:1]};
                accum_carry <= {csa_cout[N-1:0]};
                multiplier_reg <= {csa_sum[0], multiplier_reg[N-1:1]};
                
                count <= count + 1'b1;
            end else begin
                product <= {rca_sum[N-1:0], multiplier_reg};
                running <= 1'b0;
                done    <= 1'b1;
            end
        end
    end

endmodule