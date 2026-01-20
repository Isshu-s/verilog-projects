// D Flip-Flop
// Positive edge-triggered flip-flop with asynchronous reset
module d_flipflop(
    input clk,      // Clock signal
    input reset,    // Asynchronous reset (active high)
    input d,        // Data input
    output reg q,   // Output
    output q_bar    // Inverted output
);
    // Inverted output
    assign q_bar = ~q;
    
    // D Flip-Flop behavior
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;      // Reset: Q goes to 0
        end else begin
            q <= d;         // Normal: Q captures D on clock edge
        end
    end
    
endmodule