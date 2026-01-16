module rca_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;
    wire [4:0] expected;
    assign expected = a + b + cin;
    
    ripple_carry_adder uut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    initial begin
        $display("=== 4-BIT RIPPLE CARRY ADDER TEST ===");
        $display("Time | A    B    Cin | Sum  Cout | Expected | Status");
        $display("----------------------------------------------------------");
        
        a = 4'b0000; b = 4'b0000; cin = 0; #10;
        $display("%4t | %b %b  %b  | %b   %b   | %b     | %s",
                 $time, a, b, cin, sum, cout, expected,
                 ({cout, sum} == expected) ? "PASS" : "FAIL");
        
        a = 4'b0011; b = 4'b0101; cin = 0; #10;
        $display("%4t | %b %b  %b  | %b   %b   | %b     | %s",
                 $time, a, b, cin, sum, cout, expected,
                 ({cout, sum} == expected) ? "PASS" : "FAIL");
        
        a = 4'b1111; b = 4'b0001; cin = 0; #10;
        $display("%4t | %b %b  %b  | %b   %b   | %b     | %s",
                 $time, a, b, cin, sum, cout, expected,
                 ({cout, sum} == expected) ? "PASS" : "FAIL");
        
        a = 4'b1010; b = 4'b0101; cin = 0; #10;
        $display("%4t | %b %b  %b  | %b   %b   | %b     | %s",
                 $time, a, b, cin, sum, cout, expected,
                 ({cout, sum} == expected) ? "PASS" : "FAIL");
        
        a = 4'b1111; b = 4'b1111; cin = 0; #10;
        $display("%4t | %b %b  %b  | %b   %b   | %b     | %s",
                 $time, a, b, cin, sum, cout, expected,
                 ({cout, sum} == expected) ? "PASS" : "FAIL");
        
        a = 4'b1111; b = 4'b1111; cin = 1; #10;
        $display("%4t | %b %b  %b  | %b   %b   | %b     | %s",
                 $time, a, b, cin, sum, cout, expected,
                 ({cout, sum} == expected) ? "PASS" : "FAIL");
        
        a = 4'b0111; b = 4'b0011; cin = 1; #10;
        $display("%4t | %b %b  %b  | %b   %b   | %b     | %s",
                 $time, a, b, cin, sum, cout, expected,
                 ({cout, sum} == expected) ? "PASS" : "FAIL");
        
        a = 4'b1001; b = 4'b0110; cin = 0; #10;
        $display("%4t | %b %b  %b  | %b   %b   | %b     | %s",
                 $time, a, b, cin, sum, cout, expected,
                 ({cout, sum} == expected) ? "PASS" : "FAIL");
        
        $display("\n=== ALL TESTS COMPLETE ===");
        $finish;
    end
    
    initial begin
        $dumpfile("rca.vcd");
        $dumpvars(0, rca_tb);
    end
endmodule