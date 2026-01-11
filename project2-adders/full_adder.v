// Full Adder 
// Built using two half adders
module full_adder(
    input a,
    input b,
    input cin,      // Carry in
    output sum,
    output cout     // Carry out
);
    // Internal wires to connect half adders
    wire sum1, carry1, carry2;
    
    // First half adder: Add A and B
    half_adder ha1(
        .a(a),
        .b(b),
        .sum(sum1),
        .carry(carry1)
    );
    
    // Second half adder: Add sum1 and Cin
    half_adder ha2(
        .a(sum1),
        .b(cin),
        .sum(sum),
        .carry(carry2)
    );
    
    // Final carry
    assign cout = carry1 | carry2;
    
endmodule