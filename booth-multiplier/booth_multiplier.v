module booth_multiplier (
    input  wire  [31:0] multiplicand,
    input  wire  [31:0] multiplier,
    output reg  [63:0] product
);

    reg signed [32:0] Accumulator;
    reg [32:0] booth_multiplier;
    reg [32:0] ext_multiplicand;
    reg ref_bit;
    integer i;

    always @(*) begin
        Accumulator      = 33'b0;
        booth_multiplier = {1'b0, multiplier};
        ext_multiplicand = {1'b0, multiplicand};
        ref_bit          = 1'b0;

        for (i = 0; i < 33; i = i + 1) begin
            case ({booth_multiplier[0], ref_bit})
                2'b01: Accumulator = Accumulator + ext_multiplicand;        
                2'b10: Accumulator = Accumulator + (~ext_multiplicand + 1'b1); 
                default: ;                                                  
            endcase

            {Accumulator, booth_multiplier, ref_bit} = $signed({Accumulator, booth_multiplier, ref_bit}) >>> 1;
        end

        product = {Accumulator[30:0], booth_multiplier[32:0]};
    end

endmodule