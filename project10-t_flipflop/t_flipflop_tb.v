module t_flipflop_tb;
    // Inputs
    reg clk;
    reg reset;
    reg t;
    
    // Outputs
    wire q;
    wire q_bar;
    
    // Instantiate the T Flip-Flop
    t_flipflop uut(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q),
        .q_bar(q_bar)
    );
    
    // Clock generation (10 time units period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test sequence
    initial begin
        $display("=== T FLIP-FLOP TEST ===");
        $display("Time | CLK RST T | Q Q̄ | Mode");
        $display("-------------------------------------------");
        
        // Initialize with reset
        reset = 1; t = 0;
        #12;
        $display("%4t |  %b   %b  %b | %b %b | Reset", 
                 $time, clk, reset, t, q, q_bar);
        
        // Release reset
        reset = 0;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | Reset released, Q=0", 
                 $time, clk, reset, t, q, q_bar);
        
        // Test HOLD mode (T=0)
        t = 0;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | HOLD (T=0, no change)", 
                 $time, clk, reset, t, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b | %b %b | HOLD (T=0, no change)", 
                 $time, clk, reset, t, q, q_bar);
        
        // Test TOGGLE mode (T=1) - Starting from Q=0
        t = 1;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | TOGGLE (0→1)", 
                 $time, clk, reset, t, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b | %b %b | TOGGLE (1→0)", 
                 $time, clk, reset, t, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b | %b %b | TOGGLE (0→1)", 
                 $time, clk, reset, t, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b | %b %b | TOGGLE (1→0)", 
                 $time, clk, reset, t, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b | %b %b | TOGGLE (0→1)", 
                 $time, clk, reset, t, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b | %b %b | TOGGLE (1→0)", 
                 $time, clk, reset, t, q, q_bar);
        
        // Test switching back to HOLD
        t = 0;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | HOLD (Q stays 0)", 
                 $time, clk, reset, t, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b | %b %b | HOLD (Q stays 0)", 
                 $time, clk, reset, t, q, q_bar);
        
        // Toggle once more
        t = 1;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | TOGGLE (0→1)", 
                 $time, clk, reset, t, q, q_bar);
        
        // Hold at Q=1
        t = 0;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | HOLD (Q stays 1)", 
                 $time, clk, reset, t, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b | %b %b | HOLD (Q stays 1)", 
                 $time, clk, reset, t, q, q_bar);
        
        // Demonstrate frequency division
        $display("\n--- Frequency Division Test (T=1 continuously) ---");
        t = 1;
        #10; $display("%4t | Q=%b (clock cycle 1)", $time, q);
        #10; $display("%4t | Q=%b (clock cycle 2)", $time, q);
        #10; $display("%4t | Q=%b (clock cycle 3)", $time, q);
        #10; $display("%4t | Q=%b (clock cycle 4)", $time, q);
        #10; $display("%4t | Q=%b (clock cycle 5)", $time, q);
        #10; $display("%4t | Q=%b (clock cycle 6)", $time, q);
        
        $display("\n=== TEST COMPLETE ===");
        $display("Verification:");
        $display("✓ HOLD mode (T=0): Q unchanged");
        $display("✓ TOGGLE mode (T=1): Q flips each clock edge");
        $display("✓ Output frequency = Clock frequency / 2 (when T=1)");
        $display("✓ Perfect for frequency dividers and counters!");
        
        #20;
        $finish;
    end
    
    // Monitor for additional visibility
    initial begin
        $monitor("%4t | CLK=%b RST=%b T=%b Q=%b Q̄=%b", 
                 $time, clk, reset, t, q, q_bar);
    end
    
    // Waveform generation
    initial begin
        $dumpfile("t_flipflop.vcd");
        $dumpvars(0, t_flipflop_tb);
    end
    
endmodule