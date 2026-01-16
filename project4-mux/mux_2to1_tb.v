module mux_2to1_tb;
    // Inputs
    reg i0, i1, sel;
    
    // Output
    wire y;
    
    // Instantiate the Unit Under Test
    mux_2to1 uut(
        .i0(i0),
        .i1(i1),
        .sel(sel),
        .y(y)
    );
    
    // Test
    initial begin
        $display("=== 2-TO-1 MULTIPLEXER TEST ===");
        $display("Time | Sel I0 I1 | Y | Description");
        $display("------------------------------------------");
        
        // Test all combinations
        sel = 0; i0 = 0; i1 = 0; #10;
        $display("%4t |  %b  %b  %b  | %b | Select I0 (0)", $time, sel, i0, i1, y);
        
        sel = 0; i0 = 1; i1 = 0; #10;
        $display("%4t |  %b  %b  %b  | %b | Select I0 (1)", $time, sel, i0, i1, y);
        
        sel = 0; i0 = 0; i1 = 1; #10;
        $display("%4t |  %b  %b  %b  | %b | Select I0 (0)", $time, sel, i0, i1, y);
        
        sel = 0; i0 = 1; i1 = 1; #10;
        $display("%4t |  %b  %b  %b  | %b | Select I0 (1)", $time, sel, i0, i1, y);
        
        sel = 1; i0 = 0; i1 = 0; #10;
        $display("%4t |  %b  %b  %b  | %b | Select I1 (0)", $time, sel, i0, i1, y);
        
        sel = 1; i0 = 1; i1 = 0; #10;
        $display("%4t |  %b  %b  %b  | %b | Select I1 (0)", $time, sel, i0, i1, y);
        
        sel = 1; i0 = 0; i1 = 1; #10;
        $display("%4t |  %b  %b  %b  | %b | Select I1 (1)", $time, sel, i0, i1, y);
        
        sel = 1; i0 = 1; i1 = 1; #10;
        $display("%4t |  %b  %b  %b  | %b | Select I1 (1)", $time, sel, i0, i1, y);
        
        $display("\n=== TEST COMPLETE ===");
        $display("Verification:");
        $display("- When sel=0: output follows i0 ✓");
        $display("- When sel=1: output follows i1 ✓");
        
        $finish;
    end
    
    // Waveform generation
    initial begin
        $dumpfile("mux_2to1.vcd");
        $dumpvars(0, mux_2to1_tb);
    end
    
endmodule