module adders_tb;
   
    reg a, b, cin;
    
    
    wire ha_sum, ha_carry;
    wire fa_sum, fa_cout;
    
    // Instantiate Half Adder
    half_adder uut_ha(
        .a(a),
        .b(b),
        .sum(ha_sum),
        .carry(ha_carry)
    );
    
    // Instantiate Full Adder
    full_adder uut_fa(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(fa_sum),
        .cout(fa_cout)
    );
    
    // Test
    initial begin
        // Test Half Adder
        $display("=== HALF ADDER TEST ===");
        $display("A B | Sum Carry");
        $display("----------------");
        
        a = 0; b = 0; #10;
        $display("%b %b |  %b    %b", a, b, ha_sum, ha_carry);
        
        a = 0; b = 1; #10;
        $display("%b %b |  %b    %b", a, b, ha_sum, ha_carry);
        
        a = 1; b = 0; #10;
        $display("%b %b |  %b    %b", a, b, ha_sum, ha_carry);
        
        a = 1; b = 1; #10;
        $display("%b %b |  %b    %b", a, b, ha_sum, ha_carry);
        
        // Test Full Adder
        $display("\n=== FULL ADDER TEST ===");
        $display("A B Cin | Sum Cout");
        $display("--------------------");
        
        a = 0; b = 0; cin = 0; #10;
        $display("%b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        
        a = 0; b = 0; cin = 1; #10;
        $display("%b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        
        a = 0; b = 1; cin = 0; #10;
        $display("%b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        
        a = 0; b = 1; cin = 1; #10;
        $display("%b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        
        a = 1; b = 0; cin = 0; #10;
        $display("%b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        
        a = 1; b = 0; cin = 1; #10;
        $display("%b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        
        a = 1; b = 1; cin = 0; #10;
        $display("%b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        
        a = 1; b = 1; cin = 1; #10;
        $display("%b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        
        $finish;
    end
    
    // Waveform generation
    initial begin
        $dumpfile("adders.vcd");
        $dumpvars(0, adders_tb);
    end
    
endmodule