// 4-to-1 Multiplexer
// Built using three 2-to-1 multiplexers (hierarchical design)
module mux_4to1(
    input i0,           // Input 0
    input i1,           // Input 1
    input i2,           // Input 2
    input i3,           // Input 3
    input [1:0] sel,    // 2-bit select signal
    output y            // Output
);
    // Internal wires connecting the MUXes
    wire mux1_out;      // Output of first 2-to-1 MUX (i0/i1)
    wire mux2_out;      // Output of second 2-to-1 MUX (i2/i3)
    
    // First 2-to-1 MUX: selects between i0 and i1
    mux_2to1 mux1(
        .i0(i0),
        .i1(i1),
        .sel(sel[0]),       // Use LSB of select
        .y(mux1_out)
    );
    
    // Second 2-to-1 MUX: selects between i2 and i3
    mux_2to1 mux2(
        .i0(i2),
        .i1(i3),
        .sel(sel[0]),       // Use LSB of select
        .y(mux2_out)
    );
    
    // Third 2-to-1 MUX: selects between outputs of first two MUXes
    mux_2to1 mux3(
        .i0(mux1_out),      // Output from mux1 (i0 or i1)
        .i1(mux2_out),      // Output from mux2 (i2 or i3)
        .sel(sel[1]),       // Use MSB of select
        .y(y)
    );
    
endmodule