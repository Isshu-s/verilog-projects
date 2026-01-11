// Half Adder 
module half_adder(
    input a,
    input b,
    output sum,
    output carry
);
    // Sum 
    assign sum = a ^ b;
    
    // Carry 
    assign carry = a & b;
    
endmodule