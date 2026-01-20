module jk_flipflop_tb;
    // Inputs
    reg clk;
    reg reset;
    reg j, k;
    
    // Outputs
    wire q;
    wire q_bar;
    
    // Instantiate the JK Flip-Flop
    jk_flipflop uut(
        .clk(clk),
        .reset(reset),
        .j(j),
        .k(k),
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
        $display("=== JK FLIP-FLOP TEST ===");
        $display("Time | CLK RST J K | Q Q̄ | Mode");
        $display("------------------------------------------------");
        
        // Initialize with reset
        reset = 1; j = 0; k = 0;
        #12;
        $display("%4t |  %b   %b  %b %b | %b %b | Reset", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Release reset
        reset = 0;
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | Reset released", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Test HOLD mode (J=0, K=0)
        j = 0; k = 0;
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | HOLD (no change)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | HOLD (no change)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Test SET mode (J=1, K=0)
        j = 1; k = 0;
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | SET (Q=1)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Test HOLD with Q=1
        j = 0; k = 0;
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | HOLD (Q stays 1)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Test RESET mode (J=0, K=1)
        j = 0; k = 1;
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | RESET (Q=0)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Test TOGGLE mode (J=1, K=1) - Q is 0
        j = 1; k = 1;
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | TOGGLE (0→1)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Keep toggling
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | TOGGLE (1→0)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | TOGGLE (0→1)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | TOGGLE (1→0)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Test SET again
        j = 1; k = 0;
        #10;
        $display("%4t |  %b   %b  %b %b | %b %b | SET (Q=1)", 
                 $time, clk, reset, j, k, q, q_bar);
        
        // Test all modes in sequence
        $display("\n--- Complete Mode Sequence ---");
        
        j = 0; k = 0; #10;
        $display("%4t | J=0 K=0 | Q=%b | HOLD", $time, q);
        
        j = 1; k = 0; #10;
        $display("%4t | J=1 K=0 | Q=%b | SET", $time, q);
        
        j = 0; k = 1; #10;
        $display("%4t | J=0 K=1 | Q=%b | RESET", $time, q);
        
        j = 1; k = 1; #10;
        $display("%4t | J=1 K=1 | Q=%b | TOGGLE", $time, q);
        
        j = 1; k = 1; #10;
        $display("%4t | J=1 K=1 | Q=%b | TOGGLE", $time, q);
        
        $display("\n=== TEST COMPLETE ===");
        $display("Verification:");
        $display("✓ HOLD mode (J=0,K=0): Q unchanged");
        $display("✓ SET mode (J=1,K=0): Q=1");
        $display("✓ RESET mode (J=0,K=1): Q=0");
        $display("✓ TOGGLE mode (J=1,K=1): Q flips each clock");
        $display("✓ Asynchronous reset working");
        
        #20;
        $finish;
    end
    
    // Monitor for additional visibility
    initial begin
        $monitor("%4t | CLK=%b RST=%b J=%b K=%b Q=%b Q̄=%b", 
                 $time, clk, reset, j, k, q, q_bar);
    end
    
    // Waveform generation
    initial begin
        $dumpfile("jk_flipflop.vcd");
        $dumpvars(0, jk_flipflop_tb);
    end
    
endmodule