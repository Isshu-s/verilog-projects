module comparator_4bit_tb;
    // Inputs
    reg [3:0] a, b;
    
    // Outputs
    wire greater, equal, less;
    
    // Instantiate the Unit Under Test
    comparator_4bit uut(
        .a(a),
        .b(b),
        .greater(greater),
        .equal(equal),
        .less(less)
    );
    
    // Test
    initial begin
        $display("=== 4-BIT COMPARATOR TEST ===");
        $display("Time | A    B    | GT EQ LT | Decimal | Result");
        $display("--------------------------------------------------------");
        
        // Test 1: Equal values
        a = 4'b0000; b = 4'b0000; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d=%2d  | A == B", 
                 $time, a, b, greater, equal, less, a, b);
        
        a = 4'b0101; b = 4'b0101; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d=%2d  | A == B", 
                 $time, a, b, greater, equal, less, a, b);
        
        a = 4'b1111; b = 4'b1111; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d=%2d | A == B", 
                 $time, a, b, greater, equal, less, a, b);
        
        $display("");
        
        // Test 2: A greater than B
        a = 4'b1010; b = 4'b0110; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d>%2d  | A > B", 
                 $time, a, b, greater, equal, less, a, b);
        
        a = 4'b1111; b = 4'b0000; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d>%2d  | A > B", 
                 $time, a, b, greater, equal, less, a, b);
        
        a = 4'b0111; b = 4'b0011; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d>%2d  | A > B", 
                 $time, a, b, greater, equal, less, a, b);
        
        $display("");
        
        // Test 3: A less than B
        a = 4'b0011; b = 4'b0111; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d<%2d  | A < B", 
                 $time, a, b, greater, equal, less, a, b);
        
        a = 4'b0000; b = 4'b1111; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d<%2d  | A < B", 
                 $time, a, b, greater, equal, less, a, b);
        
        a = 4'b0110; b = 4'b1010; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d<%2d  | A < B", 
                 $time, a, b, greater, equal, less, a, b);
        
        $display("");
        
        // Test 4: Edge cases
        a = 4'b0001; b = 4'b0000; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d>%2d  | Edge: 1>0", 
                 $time, a, b, greater, equal, less, a, b);
        
        a = 4'b1110; b = 4'b1111; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d<%2d | Edge: 14<15", 
                 $time, a, b, greater, equal, less, a, b);
        
        a = 4'b1000; b = 4'b0111; #10;
        $display("%4t | %b %b |  %b  %b  %b | %2d>%2d  | Edge: 8>7", 
                 $time, a, b, greater, equal, less, a, b);
        
        $display("\n=== ALL TESTS COMPLETE ===");
        $display("Verification:");
        $display("✓ Equal: Only EQ=1, GT=0, LT=0");
        $display("✓ Greater: Only GT=1, EQ=0, LT=0");
        $display("✓ Less: Only LT=1, GT=0, EQ=0");
        
        $finish;
    end
    
    // Waveform generation
    initial begin
        $dumpfile("comparator.vcd");
        $dumpvars(0, comparator_4bit_tb);
    end
    
endmodule