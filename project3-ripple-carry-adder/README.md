# Project 3: 4-bit Ripple Carry Adder

**Completed:** January 16, 2026

## Overview
A 4-bit ripple carry adder that adds two 4-bit binary numbers by chaining four full adders together. The carry "ripples" from the least significant bit (LSB) to the most significant bit (MSB).

## Components

### Ripple Carry Adder
Adds two 4-bit numbers (0-15 each) with optional carry-in.
- **Inputs:** a[3:0], b[3:0], cin
- **Outputs:** sum[3:0], cout
- **Design:** Uses 4 full adder modules connected in series

### How It Works
```
Bit 0: a[0] + b[0] + cin  → sum[0], carry1
Bit 1: a[1] + b[1] + carry1 → sum[1], carry2
Bit 2: a[2] + b[2] + carry2 → sum[2], carry3
Bit 3: a[3] + b[3] + carry3 → sum[3], cout
```

## Files
- `ripple_carry_adder.v` - Main 4-bit adder module
- `full_adder.v` - 1-bit full adder (from Project 2)
- `half_adder.v` - 1-bit half adder (from Project 2)
- `rca_tb.v` - Comprehensive testbench
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Test Cases

All tests passed ✅
```
Test | A    B    Cin | Sum  Cout | Result
------------------------------------------
1    | 0000 0000  0  | 0000   0  | 0 + 0 = 0
2    | 0011 0101  0  | 1000   0  | 3 + 5 = 8
3    | 1111 0001  0  | 0000   1  | 15 + 1 = 16 (overflow)
4    | 1010 0101  0  | 1111   0  | 10 + 5 = 15
5    | 1111 1111  0  | 1110   1  | 15 + 15 = 30 (overflow)
6    | 1111 1111  1  | 1111   1  | 15 + 15 + 1 = 31
7    | 0111 0011  1  | 1011   0  | 7 + 3 + 1 = 11
8    | 1001 0110  0  | 1111   0  | 9 + 6 = 15
```

## How to Run
```bash
# Compile
iverilog -o rca.vvp half_adder.v full_adder.v ripple_carry_adder.v rca_tb.v

# Simulate
vvp rca.vvp

# View waveforms
gtkwave rca.vcd
```

## What I Learned
- Multi-bit arithmetic design
- Cascading modules (carry chain)
- Array indexing in Verilog `a[3:0]`
- Carry propagation delay concept
- Building on previous projects (hierarchical design)
- Automated test verification with expected values

## Key Concepts

### Ripple Carry
The carry "ripples" through each adder stage sequentially. This creates a propagation delay - each bit must wait for the previous bit's carry.

### Overflow
When adding two 4-bit numbers, the result can be up to 5 bits (cout + sum[3:0]). The carry-out flag indicates overflow.

## Results
✅ All 8 test cases passed  
✅ Verified against expected values  
✅ Timing analysis completed  
✅ Carry propagation visible in waveforms

---

**Part of 30-day Verilog learning journey**
<img width="1250" height="781" alt="waveform" src="https://github.com/user-attachments/assets/f12ae9ca-cf96-409f-9f47-90aecd63f4fc" />
<img width="940" height="626" alt="cmd" src="https://github.com/user-attachments/assets/9d7d25df-e50d-464a-9d9b-45ade28524af" />
