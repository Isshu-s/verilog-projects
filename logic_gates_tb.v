module logic_gates_tb;
    reg a, b;
    wire and_out, or_out, not_out, nand_out, nor_out, xor_out;
    
    and_gate uut_and(.a(a), .b(b), .y(and_out));
    or_gate uut_or(.a(a), .b(b), .y(or_out));
    not_gate uut_not(.a(a), .y(not_out));
    nand_gate uut_nand(.a(a), .b(b), .y(nand_out));
    nor_gate uut_nor(.a(a), .b(b), .y(nor_out));
    xor_gate uut_xor(.a(a), .b(b), .y(xor_out));
    
    initial begin
        $display("Time\ta\tb\tAND\tOR\tNOT\tNAND\tNOR\tXOR");
        $display("------------------------------------------------------------");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
                 $time, a, b, and_out, or_out, not_out, nand_out, nor_out, xor_out);
        
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $finish;
    end
    
    initial begin
        $dumpfile("logic_gates.vcd");
        $dumpvars(0, logic_gates_tb);
    end
endmodule