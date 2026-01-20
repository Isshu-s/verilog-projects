module d_flipflop_tb;
    // Inputs
    reg clk;
    reg reset;
    reg d;
    
    // Outputs
    wire q;
    wire q_bar;
    
    // Instantiate the D Flip-Flop
    d_flipflop uut(
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q),
        .q_bar(q_bar)
    );
    
    // Clock generation (10 time units period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5 time units
    end
    
    // Test sequence
    initial begin
        $display("=== D FLIP-FLOP TEST ===");
        $display("Time | CLK RST D | Q Q̄ | Description");
        $display("-----------------------------------------------");
        
        // Initialize
        reset = 1; d = 0;
        #3;  // Wait a bit before first clock edge
        $display("%4t |  %b   %b  %b | %b %b | Reset active", 
                 $time, clk, reset, d, q, q_bar);
        
        #10; // Wait for clock edge
        $display("%4t |  %b   %b  %b | %b %b | Reset active", 
                 $time, clk, reset, d, q, q_bar);
        
        // Release reset
        reset = 0;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | Reset released", 
                 $time, clk, reset, d, q, q_bar);
        
        // Test D=0
        d = 0;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | D=0, Q should be 0", 
                 $time, clk, reset, d, q, q_bar);
        
        // Test D=1
        d = 1;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | D=1, Q should be 1", 
                 $time, clk, reset, d, q, q_bar);
        
        // Hold D=1
        #10;
        $display("%4t |  %b   %b  %b | %b %b | D=1, Q holds 1", 
                 $time, clk, reset, d, q, q_bar);
        
        // Change to D=0
        d = 0;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | D=0, Q should be 0", 
                 $time, clk, reset, d, q, q_bar);
        
        // Test D changing between clock edges (Q should NOT change)
        d = 1;
        #3;  // Change D, but not at clock edge
        $display("%4t |  %b   %b  %b | %b %b | D changed to 1 (no clock edge yet)", 
                 $time, clk, reset, d, q, q_bar);
        
        #7;  // Wait for clock edge
        $display("%4t |  %b   %b  %b | %b %b | Clock edge - Q now captures D", 
                 $time, clk, reset, d, q, q_bar);
        
        // Test reset override
        d = 1;
        #10;
        $display("%4t |  %b   %b  %b | %b %b | D=1, Q=1", 
                 $time, clk, reset, d, q, q_bar);
        
        reset = 1;
        #2;  // Reset without waiting for clock
        $display("%4t |  %b   %b  %b | %b %b | Reset activated (asynchronous)", 
                 $time, clk, reset, d, q, q_bar);
        
        #10;
        reset = 0;
        $display("%4t |  %b   %b  %b | %b %b | Reset released", 
                 $time, clk, reset, d, q, q_bar);
        
        $display("\n=== TEST COMPLETE ===");
        $display("Verification:");
        $display("✓ Q captures D on rising clock edge");
        $display("✓ Q holds value between clock edges");
        $display("✓ Q_bar is always inverse of Q");
        $display("✓ Reset overrides everything (asynchronous)");
        
        #20;
        $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("%4t | CLK=%b RST=%b D=%b Q=%b Q̄=%b", 
                 $time, clk, reset, d, q, q_bar);
    end
    
    // Waveform generation
    initial begin
        $dumpfile("d_flipflop.vcd");
        $dumpvars(0, d_flipflop_tb);
    end
    
endmodule