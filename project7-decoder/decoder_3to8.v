// 3-to-8 Decoder
// Converts 3-bit binary input to one-hot 8-bit output
module decoder_3to8(
    input [2:0] in,     // 3-bit input (0-7)
    input enable,       // Enable signal
    output [7:0] out    // 8-bit one-hot output
);
    // When enabled, activate the output corresponding to input value
    // When disabled, all outputs are 0
    assign out = enable ? (8'b00000001 << in) : 8'b00000000;
    
    // Alternative implementation using case statement:
    /*
    reg [7:0] out_reg;
    
    always @(*) begin
        if (enable) begin
            case(in)
                3'b000: out_reg = 8'b00000001;
                3'b001: out_reg = 8'b00000010;
                3'b010: out_reg = 8'b00000100;
                3'b011: out_reg = 8'b00001000;
                3'b100: out_reg = 8'b00010000;
                3'b101: out_reg = 8'b00100000;
                3'b110: out_reg = 8'b01000000;
                3'b111: out_reg = 8'b10000000;
                default: out_reg = 8'b00000000;
            endcase
        end else begin
            out_reg = 8'b00000000;
        end
    end
    
    assign out = out_reg;
    */
    
endmodule