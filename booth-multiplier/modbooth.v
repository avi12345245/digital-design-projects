module booth_multiplier (
    input  wire [31:0] multiplicand,
    input  wire [31:0] multiplier,
    output reg  [63:0] product
);

    reg signed [34:0] Accumulator;  
    reg        [33:0] booth_multiplier; 
    reg signed [34:0] ext_multiplicand; 
    reg ref_bit;
    integer i;

    always @(*) begin
        Accumulator      = 35'b0;
        booth_multiplier = {2'b00, multiplier};
        ext_multiplicand = {3'b000, multiplicand};
        ref_bit          = 1'b0;

        for (i = 0; i < 17; i = i + 1) begin
            case ({booth_multiplier[1], booth_multiplier[0], ref_bit})
                3'b001, 3'b010: Accumulator = Accumulator + ext_multiplicand;             
                3'b011:         Accumulator = Accumulator + (ext_multiplicand << 1);        
                3'b100:         Accumulator = Accumulator + ((~ext_multiplicand + 1'b1) << 1);
                3'b101, 3'b110: Accumulator = Accumulator + (~ext_multiplicand + 1'b1); 
                default: ;                                                                     
            endcase

            {Accumulator, booth_multiplier, ref_bit} = $signed({Accumulator[34], Accumulator[34], Accumulator, booth_multiplier, ref_bit}) >>> 2;
        end

        product = {Accumulator[29:0], booth_multiplier[33:0]};
    end

endmodule