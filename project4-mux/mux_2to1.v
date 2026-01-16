// 2-to-1 Multiplexer
// Selects between two inputs based on select signal
module mux_2to1(
    input i0,       // Input 0
    input i1,       // Input 1
    input sel,      // Select signal
    output y        // Output
);
    // When sel=0, output i0; when sel=1, output i1
    assign y = sel ? i1 : i0;
    
endmodule