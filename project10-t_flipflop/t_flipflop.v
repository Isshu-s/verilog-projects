// T Flip-Flop (Toggle Flip-Flop)
// Positive edge-triggered with asynchronous reset
// Has 2 modes: Hold (T=0) and Toggle (T=1)
module t_flipflop(
    input clk,      // Clock signal
    input reset,    // Asynchronous reset (active high)
    input t,        // Toggle input
    output reg q,   // Output
    output q_bar    // Inverted output
);
    // Inverted output
    assign q_bar = ~q;
    
    // T Flip-Flop behavior
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;          // Reset: Q = 0
        end else begin
            if (t) begin
                q <= ~q;        // Toggle: Q = !Q
            end else begin
                q <= q;         // Hold: Q unchanged
            end
        end
    end
    
    // Alternative implementation (more concise):
    // always @(posedge clk or posedge reset) begin
    //     if (reset)
    //         q <= 1'b0;
    //     else
    //         q <= t ? ~q : q;  // Ternary operator
    // end
    
endmodule