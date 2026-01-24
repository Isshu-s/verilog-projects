// 4-bit Binary Counter
// Counts from 0 to 15, then wraps to 0
// Synchronous design - all FFs share same clock
module counter_4bit(
    input clk,          // Clock signal
    input reset,        // Asynchronous reset
    input enable,       // Enable counting (count when high)
    output [3:0] count  // 4-bit count output
);
    reg [3:0] count_reg;
    
    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count_reg <= 4'b0000;       // Reset to 0
        end else if (enable) begin
            count_reg <= count_reg + 1; // Increment count
            // Automatically wraps from 15 (1111) to 0 (0000)
        end
        // If enable=0, count_reg holds its value
    end
    
    assign count = count_reg;
    
endmodule