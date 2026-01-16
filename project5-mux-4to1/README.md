# Project 5: 4-to-1 Multiplexer (Hierarchical Design)

**Completed:** January 16, 2026

## Overview
A 4-to-1 multiplexer built using hierarchical design - constructed from three 2-to-1 multiplexers. Demonstrates the power of modular design and component reuse.

## What is a 4-to-1 Multiplexer?

A 4-to-1 MUX selects one of four inputs based on a 2-bit select signal, routing the chosen input to the output.

**Selection Logic:**
```
sel[1] sel[0] | Output
-------------------
  0      0    |  i0
  0      1    |  i1
  1      0    |  i2
  1      1    |  i3
```

## Architecture

Built using **three 2-to-1 multiplexers** in a tree structure:
```
Level 1:
  MUX1: Selects between i0 and i1 based on sel[0] → out1
  MUX2: Selects between i2 and i3 based on sel[0] → out2

Level 2:
  MUX3: Selects between out1 and out2 based on sel[1] → y (final output)
```

**Visual Diagram:**
```
        MUX1 (sel[0])         MUX2 (sel[0])
i0 ──┐                i2 ──┐
     ├──► out1             ├──► out2
i1 ──┘                i3 ──┘
                          │
                          │
                    MUX3 (sel[1])
              out1 ──┐
                     ├──► y
              out2 ──┘
```

## Components

### 4-to-1 Multiplexer
- **Inputs:** i0, i1, i2, i3 (data), sel[1:0] (2-bit select)
- **Output:** y
- **Design:** Hierarchical - uses three 2-to-1 MUX modules

### 2-to-1 Multiplexer (Building Block)
- Reused from Project 4
- Three instances: mux1, mux2, mux3

## Files
- `mux_4to1.v` - Main 4-to-1 multiplexer module
- `mux_2to1.v` - 2-to-1 multiplexer (building block)
- `mux_4to1_tb.v` - Comprehensive testbench
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Test Results

All 8 test cases passed ✅
```
Time | Sel I0 I1 I2 I3 | Y | Selected
----------------------------------------
  10 | 00  0  1  0  1  | 0 | I0 ✓
  20 | 01  0  1  0  1  | 1 | I1 ✓
  30 | 10  0  1  0  1  | 0 | I2 ✓
  40 | 11  0  1  0  1  | 1 | I3 ✓
  50 | 00  1  0  1  0  | 1 | I0 ✓
  60 | 01  1  0  1  0  | 0 | I1 ✓
  70 | 10  1  0  1  0  | 1 | I2 ✓
  80 | 11  1  0  1  0  | 0 | I3 ✓
```

## How to Run
```bash
# Compile (order matters!)
iverilog -o mux4.vvp mux_2to1.v mux_4to1.v mux_4to1_tb.v

# Simulate
vvp mux4.vvp

# View waveforms
gtkwave mux_4to1.vcd
```

## What I Learned

### Hierarchical Design
- Building complex circuits from simpler building blocks
- The same 2-to-1 MUX module is instantiated three times
- Each instance has a unique name (mux1, mux2, mux3)
- Demonstrates code reusability and modular design

### Multi-bit Select Signals
```verilog
input [1:0] sel;    // 2-bit select signal
sel[0]              // LSB - controls first level MUXes
sel[1]              // MSB - controls final MUX
```

### Internal Wire Connections
```verilog
wire mux1_out;      // Connects MUX1 output to MUX3 input
wire mux2_out;      // Connects MUX2 output to MUX3 input
```

### Module Instantiation with Wires
Modules communicate through internal wires, creating a data flow path from inputs through multiple stages to the final output.

## Key Concepts

### Why Hierarchical Design?
- **Reusability:** Used existing 2-to-1 MUX from Project 4
- **Maintainability:** Changes to 2-to-1 MUX automatically apply to all instances
- **Clarity:** Easier to understand and verify
- **Scalability:** Can build 8-to-1, 16-to-1 MUXes the same way

### Binary Select Decoding
The 2-bit select signal creates 4 unique combinations (2² = 4), allowing selection among 4 inputs.

### Signal Flow
```
Inputs → Level 1 MUXes → Internal wires → Level 2 MUX → Output
```

## Comparison with Direct Implementation

**Hierarchical (this project):**
- Uses 3 pre-built 2-to-1 MUXes
- Clear, modular structure
- Easy to understand and verify

**Direct implementation (alternative):**
```verilog
assign y = (sel == 2'b00) ? i0 :
           (sel == 2'b01) ? i1 :
           (sel == 2'b10) ? i2 : i3;
```

Both work, but hierarchical design is more professional and scalable.

## Applications

4-to-1 multiplexers are used in:
- Processor data path selection
- Memory addressing
- Register file output selection
- ALU operand selection
- Building larger multiplexers (8-to-1, 16-to-1)

## Results
✅ All select combinations verified  
✅ Hierarchical design working perfectly  
✅ Module reuse demonstrated  
✅ Timing diagram shows correct signal routing

---

**Part of 30-day Verilog learning journey**

**Related Projects:**
- Project 4: 2-to-1 Multiplexer (building block)
- <img width="1248" height="817" alt="waveform" src="https://github.com/user-attachments/assets/c27b209f-39e6-4472-923c-812c3106e8a2" />
<img width="945" height="640" alt="output" src="https://github.com/user-attachments/assets/3d5c57a4-c502-4aef-8ec6-144b48dcf978" />
