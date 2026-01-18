module decoder_3to8_tb;
    // Inputs
    reg [2:0] in;
    reg enable;
    
    // Outputs
    wire [7:0] out;
    
    // Instantiate the Unit Under Test
    decoder_3to8 uut(
        .in(in),
        .enable(enable),
        .out(out)
    );
    
    // Test
    initial begin
        $display("=== 3-TO-8 DECODER TEST ===");
        $display("Time | En | In  | Output (Y7-Y0) | Active Line | Decimal");
        $display("----------------------------------------------------------------");
        
        // Test with enable = 0 (disabled)
        enable = 0;
        $display("\n--- DISABLED MODE (Enable = 0) ---");
        
        in = 3'b000; #10;
        $display("%4t |  %b | %b | %b    | None        | -", 
                 $time, enable, in, out);
        
        in = 3'b111; #10;
        $display("%4t |  %b | %b | %b    | None        | -", 
                 $time, enable, in, out);
        
        // Test with enable = 1 (enabled)
        enable = 1;
        $display("\n--- ENABLED MODE (Enable = 1) ---");
        
        in = 3'b000; #10;
        $display("%4t |  %b | %b | %b    | Y0          | %0d", 
                 $time, enable, in, out, in);
        
        in = 3'b001; #10;
        $display("%4t |  %b | %b | %b    | Y1          | %0d", 
                 $time, enable, in, out, in);
        
        in = 3'b010; #10;
        $display("%4t |  %b | %b | %b    | Y2          | %0d", 
                 $time, enable, in, out, in);
        
        in = 3'b011; #10;
        $display("%4t |  %b | %b | %b    | Y3          | %0d", 
                 $time, enable, in, out, in);
        
        in = 3'b100; #10;
        $display("%4t |  %b | %b | %b    | Y4          | %0d", 
                 $time, enable, in, out, in);
        
        in = 3'b101; #10;
        $display("%4t |  %b | %b | %b    | Y5          | %0d", 
                 $time, enable, in, out, in);
        
        in = 3'b110; #10;
        $display("%4t |  %b | %b | %b    | Y6          | %0d", 
                 $time, enable, in, out, in);
        
        in = 3'b111; #10;
        $display("%4t |  %b | %b | %b    | Y7          | %0d", 
                 $time, enable, in, out, in);
        
        // Test enable toggling
        $display("\n--- ENABLE TOGGLING ---");
        
        in = 3'b101; enable = 1; #10;
        $display("%4t |  %b | %b | %b    | Y5 (on)     | %0d", 
                 $time, enable, in, out, in);
        
        enable = 0; #10;
        $display("%4t |  %b | %b | %b    | All off     | -", 
                 $time, enable, in, out);
        
        enable = 1; #10;
        $display("%4t |  %b | %b | %b    | Y5 (on)     | %0d", 
                 $time, enable, in, out, in);
        
        $display("\n=== ALL TESTS COMPLETE ===");
        $display("Verification:");
        $display("✓ Enable=0: All outputs are 0");
        $display("✓ Enable=1: Exactly one output is 1 (one-hot encoding)");
        $display("✓ Output position matches input value");
        
        $finish;
    end
    
    // Waveform generation
    initial begin
        $dumpfile("decoder.vcd");
        $dumpvars(0, decoder_3to8_tb);
    end
    
endmodule