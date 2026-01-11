# Project 2: Half Adder & Full Adder

**Completed:** January 11, 2026

## Overview
Implementation of 1-bit binary adders using Verilog HDL with hierarchical design approach.

## Components

### Half Adder
Adds two 1-bit numbers, produces sum and carry.
- **Inputs:** a, b
- **Outputs:** sum, carry
- **Logic:** 
  - Sum = a XOR b
  - Carry = a AND b

### Full Adder
Adds three 1-bit numbers (includes carry-in), built using two half adders.
- **Inputs:** a, b, cin
- **Outputs:** sum, cout
- **Design:** Hierarchical (uses 2 half_adder modules)

## Files
- `half_adder.v` - Half adder module
- `full_adder.v` - Full adder module (hierarchical design)
- `adders_tb.v` - Comprehensive testbench
- `output.png` - Console output (truth tables)
- `waveforms.png` - GTKWave timing diagram

## Truth Tables

### Half Adder
```
A B | Sum Carry
0 0 |  0   0
0 1 |  1   0
1 0 |  1   0
1 1 |  0   1
```

### Full Adder
```
A B Cin | Sum Cout
0 0  0  |  0   0
0 0  1  |  1   0
0 1  0  |  1   0
0 1  1  |  0   1
1 0  0  |  1   0
1 0  1  |  0   1
1 1  0  |  0   1
1 1  1  |  1   1
```

## How to Run
```bash
# Compile
iverilog -o adders.vvp half_adder.v full_adder.v adders_tb.v

# Simulate
vvp adders.vvp

# View waveforms
gtkwave adders.vcd
```

## What I Learned
- Module instantiation and hierarchical design
- Internal wire connections between modules
- Building complex circuits from simple components
- Complete port connection requirements
- Systematic exhaustive testing methodology

## Results
✅ All 12 test cases passed (4 half adder + 8 full adder)
✅ Truth tables verified
✅ Timing analysis completed

---

**Part of 30-day Verilog learning journey**
<img width="1242" height="779" alt="waveform" src="https://github.com/user-attachments/assets/a0b7805e-feda-483e-a0a4-60786449f572" />
<img width="950" height="505" alt="truth_table" src="https://github.com/user-attachments/assets/b8e635f9-5e74-488d-a536-8c2ef0c2dd37" />
