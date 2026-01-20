// JK Flip-Flop
// Positive edge-triggered with asynchronous reset
// Has 4 modes: Hold, Reset, Set, Toggle
module jk_flipflop(
    input clk,      // Clock signal
    input reset,    // Asynchronous reset (active high)
    input j,        // J input (Set)
    input k,        // K input (Reset)
    output reg q,   // Output
    output q_bar    // Inverted output
);
    // Inverted output
    assign q_bar = ~q;
    
    // JK Flip-Flop behavior
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;              // Reset: Q = 0
        end else begin
            case ({j, k})           // Combine J and K into 2-bit value
                2'b00: q <= q;      // Hold: No change
                2'b01: q <= 1'b0;   // Reset: Q = 0
                2'b10: q <= 1'b1;   // Set: Q = 1
                2'b11: q <= ~q;     // Toggle: Q = !Q
            endcase
        end
    end
    
endmodule