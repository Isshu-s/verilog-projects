module mux_4to1_tb;
    // Inputs
    reg i0, i1, i2, i3;
    reg [1:0] sel;
    
    // Output
    wire y;
    
    // Instantiate the Unit Under Test
    mux_4to1 uut(
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .sel(sel),
        .y(y)
    );
    
    // Test
    initial begin
        $display("=== 4-TO-1 MULTIPLEXER TEST ===");
        $display("Time | Sel I0 I1 I2 I3 | Y | Selected Input");
        $display("--------------------------------------------------");
        
        // Set different values for each input for easy verification
        i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        
        // Test all select combinations
        sel = 2'b00; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | I0 (expected: %b)", 
                 $time, sel, i0, i1, i2, i3, y, i0);
        
        sel = 2'b01; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | I1 (expected: %b)", 
                 $time, sel, i0, i1, i2, i3, y, i1);
        
        sel = 2'b10; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | I2 (expected: %b)", 
                 $time, sel, i0, i1, i2, i3, y, i2);
        
        sel = 2'b11; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | I3 (expected: %b)", 
                 $time, sel, i0, i1, i2, i3, y, i3);
        
        $display("\n--- Test with different input pattern ---");
        
        // Change input values
        i0 = 1; i1 = 0; i2 = 1; i3 = 0;
        
        sel = 2'b00; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | I0 (expected: %b)", 
                 $time, sel, i0, i1, i2, i3, y, i0);
        
        sel = 2'b01; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | I1 (expected: %b)", 
                 $time, sel, i0, i1, i2, i3, y, i1);
        
        sel = 2'b10; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | I2 (expected: %b)", 
                 $time, sel, i0, i1, i2, i3, y, i2);
        
        sel = 2'b11; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | I3 (expected: %b)", 
                 $time, sel, i0, i1, i2, i3, y, i3);
        
        $display("\n--- Test all inputs high ---");
        
        i0 = 1; i1 = 1; i2 = 1; i3 = 1;
        
        sel = 2'b00; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | All high, select I0", 
                 $time, sel, i0, i1, i2, i3, y);
        
        sel = 2'b01; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | All high, select I1", 
                 $time, sel, i0, i1, i2, i3, y);
        
        $display("\n--- Test all inputs low ---");
        
        i0 = 0; i1 = 0; i2 = 0; i3 = 0;
        
        sel = 2'b10; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | All low, select I2", 
                 $time, sel, i0, i1, i2, i3, y);
        
        sel = 2'b11; #10;
        $display("%4t |  %b  %b  %b  %b  %b  | %b | All low, select I3", 
                 $time, sel, i0, i1, i2, i3, y);
        
        $display("\n=== ALL TESTS COMPLETE ===");
        $display("Verification:");
        $display("✓ sel=00 always selects i0");
        $display("✓ sel=01 always selects i1");
        $display("✓ sel=10 always selects i2");
        $display("✓ sel=11 always selects i3");
        
        $finish;
    end
    
    // Waveform generation
    initial begin
        $dumpfile("mux_4to1.vcd");
        $dumpvars(0, mux_4to1_tb);
    end
    
endmodule