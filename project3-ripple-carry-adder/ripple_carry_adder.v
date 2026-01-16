// 4-bit Ripple Carry Adder
// Adds two 4-bit numbers using 4 full adders
module ripple_carry_adder(
    input [3:0] a,      // 4-bit input A
    input [3:0] b,      // 4-bit input B
    input cin,          // Carry in
    output [3:0] sum,   // 4-bit sum
    output cout         // Carry out
);
    // Internal carry wires between adders
    wire c1, c2, c3;
    
    // Bit 0 (LSB) - First full adder
    full_adder fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c1)
    );
    
    // Bit 1
    full_adder fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );
    
    // Bit 2
    full_adder fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );
    
    // Bit 3 (MSB) - Last full adder
    full_adder fa3(
        .a(a[3]),
        .b(b[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(cout)
    );
    
endmodule