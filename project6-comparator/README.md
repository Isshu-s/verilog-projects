# Project 6: 4-bit Comparator

**Completed:** January 18, 2026

## Overview
A 4-bit magnitude comparator that compares two 4-bit binary numbers and outputs their relationship (greater than, equal to, or less than).

## What is a Comparator?

A comparator is a combinational circuit that compares two binary numbers and determines their magnitude relationship.

**Outputs:**
- **Greater (GT):** High when A > B
- **Equal (EQ):** High when A == B
- **Less (LT):** High when A < B

**Important:** Only ONE output is high at any given time (one-hot encoding).

## Components

### 4-bit Comparator
- **Inputs:** a[3:0], b[3:0] (two 4-bit numbers)
- **Outputs:** greater, equal, less (comparison results)
- **Range:** Compares numbers from 0 to 15

## Truth Table Examples
```
A    B    | GT EQ LT | Relationship
--------------------------------------
0000 0000 |  0  1  0 | A == B (0 = 0)
1010 0110 |  1  0  0 | A > B  (10 > 6)
0011 0111 |  0  0  1 | A < B  (3 < 7)
1111 1111 |  0  1  0 | A == B (15 = 15)
```

## Files
- `comparator_4bit.v` - 4-bit comparator module
- `comparator_4bit_tb.v` - Comprehensive testbench
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Implementation

### Using Relational Operators
```verilog
assign greater = (a > b);
assign equal = (a == b);
assign less = (a < b);
```

Verilog's built-in relational operators handle the comparison logic efficiently.

## Test Results

All 12 test cases passed ✅
```
Category: Equal Values
  0 = 0   → EQ=1 ✓
  5 = 5   → EQ=1 ✓
  15 = 15 → EQ=1 ✓

Category: Greater Than
  10 > 6  → GT=1 ✓
  15 > 0  → GT=1 ✓
  7 > 3   → GT=1 ✓

Category: Less Than
  3 < 7   → LT=1 ✓
  0 < 15  → LT=1 ✓
  6 < 10  → LT=1 ✓

Edge Cases:
  1 > 0   → GT=1 ✓
  14 < 15 → LT=1 ✓
  8 > 7   → GT=1 ✓
```

## How to Run
```bash
# Compile
iverilog -o comp.vvp comparator_4bit.v comparator_4bit_tb.v

# Simulate
vvp comp.vvp

# View waveforms
gtkwave comparator.vcd
```

## What I Learned

### Relational Operators in Verilog
```verilog
>   // Greater than
<   // Less than
==  // Equal to
>=  // Greater than or equal
<=  // Less than or equal
!=  // Not equal
```

### One-Hot Encoding
At any given time, exactly ONE output is active:
- **A > B:** GT=1, EQ=0, LT=0
- **A == B:** GT=0, EQ=1, LT=0
- **A < B:** GT=0, EQ=0, LT=1

### Magnitude Comparison
The comparator treats the 4-bit input as an unsigned integer (0-15) and performs numerical comparison, not bitwise comparison.

### Testbench Verification
Using decimal display (`%2d`) makes it easier to verify correctness compared to binary values.

## Key Concepts

### Why Comparators Matter
Comparators are fundamental building blocks in:
- **CPU control logic:** Branch instructions (if statements)
- **Sorting networks:** Determining order of elements
- **Priority encoders:** Finding max/min values
- **ALUs:** Implementing comparison operations
- **State machines:** Condition checking

### Design Simplicity
Modern Verilog allows direct use of relational operators, making the implementation clean and readable. The synthesizer handles the underlying logic optimization.

### One-Hot vs Binary Encoding
One-hot encoding (used here) is beneficial because:
- Easy to decode (single signal indicates result)
- No priority encoding needed
- Clear and unambiguous outputs

## Applications

Real-world uses of comparators:
- **Microprocessors:** Conditional branching (if A > B then...)
- **Sorting algorithms:** Hardware-accelerated sorting
- **Control systems:** Threshold detection
- **Memory management:** Address comparison
- **Digital signal processing:** Peak detection

## Alternative Implementations

### Bit-by-bit Comparison (More Complex)
Could be built by comparing each bit position from MSB to LSB, but Verilog's relational operators abstract this complexity.

### Magnitude Comparator Chain
For larger bit widths, multiple 4-bit comparators can be cascaded with enable/cascade inputs.

## Results
✅ All comparison cases verified  
✅ One-hot encoding confirmed  
✅ Edge cases tested (0, 15, adjacent values)  
✅ Decimal verification matches binary results

---
<img width="1461" height="906" alt="output" src="https://github.com/user-attachments/assets/de73ebed-6c43-4fe1-9661-8b1be2bbb3fe" />
<img width="1244" height="773" alt="gtkwaveform" src="https://github.com/user-attachments/assets/4b6e2a41-a9a1-4f16-86c4-efe7a63533bd" />


**Part of 30-day Verilog learning journey**

**Week 1 Progress: 86% (6/7 projects complete)**
