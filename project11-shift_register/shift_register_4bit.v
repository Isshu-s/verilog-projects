// 4-bit Shift Register
// Serial-In, Serial-Out (SISO)
// Data shifts right on each clock edge
module shift_register_4bit(
    input clk,          // Clock signal
    input reset,        // Asynchronous reset
    input serial_in,    // Serial data input
    output serial_out,  // Serial data output
    output [3:0] q      // Parallel output (to observe all bits)
);
    // 4-bit register to hold data
    reg [3:0] shift_reg;
    
    // Shift operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0000;           // Clear all bits
        end else begin
            shift_reg <= {serial_in, shift_reg[3:1]};  // Shift right
            // Equivalent to:
            // shift_reg[0] <= shift_reg[1];
            // shift_reg[1] <= shift_reg[2];
            // shift_reg[2] <= shift_reg[3];
            // shift_reg[3] <= serial_in;
        end
    end
    
    // Outputs
    assign serial_out = shift_reg[0];   // LSB exits first
    assign q = shift_reg;               // Parallel view of all bits
    
endmodule