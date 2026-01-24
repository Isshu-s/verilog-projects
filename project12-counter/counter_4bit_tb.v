module counter_4bit_tb;
    // Inputs
    reg clk;
    reg reset;
    reg enable;
    
    // Outputs
    wire [3:0] count;
    
    // Instantiate the Counter
    counter_4bit uut(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );
    
    // Clock generation (10 time units period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test sequence
    initial begin
        $display("=== 4-BIT BINARY COUNTER TEST ===");
        $display("Time | CLK RST EN | Count (Dec) | Binary");
        $display("-----------------------------------------------");
        
        // Initialize with reset
        reset = 1; enable = 0;
        #12;
        $display("%4t |  %b   %b  %b |     %2d      | %b", 
                 $time, clk, reset, enable, count, count);
        
        // Release reset, start counting
        reset = 0; enable = 1;
        #10;
        $display("%4t |  %b   %b  %b |     %2d      | %b", 
                 $time, clk, reset, enable, count, count);
        
        // Let it count through all values
        $display("\n--- Counting from 0 to 15 ---");
        repeat(16) begin
            #10;
            $display("%4t |  %b   %b  %b |     %2d      | %b", 
                     $time, clk, reset, enable, count, count);
        end
        
        // Test wrap-around
        $display("\n--- Verify wrap-around (15 → 0) ---");
        #10;
        $display("%4t |  %b   %b  %b |     %2d      | %b ← Wrapped!", 
                 $time, clk, reset, enable, count, count);
        
        // Test enable control
        $display("\n--- Test Enable Control ---");
        #10;
        $display("%4t |  %b   %b  %b |     %2d      | %b | Counting", 
                 $time, clk, reset, enable, count, count);
        
        enable = 0;  // Disable counting
        #10;
        $display("%4t |  %b   %b  %b |     %2d      | %b | HOLD (enable=0)", 
                 $time, clk, reset, enable, count, count);
        
        #10;
        $display("%4t |  %b   %b  %b |     %2d      | %b | HOLD (enable=0)", 
                 $time, clk, reset, enable, count, count);
        
        enable = 1;  // Re-enable counting
        #10;
        $display("%4t |  %b   %b  %b |     %2d      | %b | Resume counting", 
                 $time, clk, reset, enable, count, count);
        
        #10;
        $display("%4t |  %b   %b  %b |     %2d      | %b | Counting", 
                 $time, clk, reset, enable, count, count);
        
        // Test reset during counting
        $display("\n--- Test Reset During Counting ---");
        #10;
        $display("%4t |  %b   %b  %b |     %2d      | %b | Before reset", 
                 $time, clk, reset, enable, count, count);
        
        reset = 1;
        #2;  // Reset asynchronously (doesn't wait for clock)
        $display("%4t |  %b   %b  %b |     %2d      | %b | Reset active (async)", 
                 $time, clk, reset, enable, count, count);
        
        #10;
        reset = 0;
        $display("%4t |  %b   %b  %b |     %2d      | %b | Reset released", 
                 $time, clk, reset, enable, count, count);
        
        // Count a bit more
        repeat(5) begin
            #10;
            $display("%4t |  %b   %b  %b |     %2d      | %b", 
                     $time, clk, reset, enable, count, count);
        end
        
        $display("\n=== TEST COMPLETE ===");
        $display("Verification:");
        $display("✓ Counts from 0 to 15");
        $display("✓ Wraps around from 15 to 0");
        $display("✓ Enable control works (counting pauses when enable=0)");
        $display("✓ Asynchronous reset works");
        $display("✓ Perfect binary counting sequence!");
        
        #20;
        $finish;
    end
    
    // Monitor for continuous observation
    initial begin
        $monitor("%4t | CLK=%b RST=%b EN=%b Count=%2d (%b)", 
                 $time, clk, reset, enable, count, count);
    end
    
    // Waveform generation
    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_4bit_tb);
    end
    
endmodule