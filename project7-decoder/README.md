# Project 7: 3-to-8 Decoder

**Completed:** January 19, 2026

**🎉 WEEK 1 COMPLETE! Final combinational logic project.**

## Overview
A 3-to-8 decoder that converts a 3-bit binary input into an 8-bit one-hot output. Includes an enable signal for circuit activation control.

## What is a Decoder?

A decoder is a combinational circuit that converts binary-coded input into a one-hot output, where only one output line is active at a time.

**3-to-8 Decoder Logic:**
- 3 input bits can represent 8 different values (2³ = 8)
- 8 output bits, with exactly ONE high at any time
- Enable signal allows the decoder to be turned on/off

## Truth Table
```
En | In[2:0] | Output (Y7-Y0) | Active
------------------------------------------
0  | xxx     | 00000000       | None (disabled)
1  | 000     | 00000001       | Y0
1  | 001     | 00000010       | Y1
1  | 010     | 00000100       | Y2
1  | 011     | 00001000       | Y3
1  | 100     | 00010000       | Y4
1  | 101     | 00100000       | Y5
1  | 110     | 01000000       | Y6
1  | 111     | 10000000       | Y7
```

## Components

### 3-to-8 Decoder
- **Inputs:** in[2:0] (3-bit binary), enable (activation control)
- **Outputs:** out[7:0] (8-bit one-hot)
- **Behavior:** When enabled, the output bit corresponding to the input value is set high

## Files
- `decoder_3to8.v` - 3-to-8 decoder module
- `decoder_3to8_tb.v` - Comprehensive testbench
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Implementation

### Elegant Shift Operator Method
```verilog
assign out = enable ? (8'b00000001 << in) : 8'b00000000;
```

**How it works:**
- `8'b00000001 << 0` → `00000001` (Y0 active)
- `8'b00000001 << 3` → `00001000` (Y3 active)
- `8'b00000001 << 7` → `10000000` (Y7 active)

The shift operator elegantly creates one-hot encoding!

### Alternative: Case Statement
The commented-out section shows an alternative implementation using a case statement for each input combination.

## Test Results

All 13 test cases passed ✅
```
DISABLED MODE (Enable = 0):
  Input 000 → 00000000 (all off) ✓
  Input 111 → 00000000 (all off) ✓

ENABLED MODE (Enable = 1):
  Input 000 → 00000001 (Y0) ✓
  Input 001 → 00000010 (Y1) ✓
  Input 010 → 00000100 (Y2) ✓
  Input 011 → 00001000 (Y3) ✓
  Input 100 → 00010000 (Y4) ✓
  Input 101 → 00100000 (Y5) ✓
  Input 110 → 01000000 (Y6) ✓
  Input 111 → 10000000 (Y7) ✓

ENABLE TOGGLING:
  Enable off → All outputs 0 ✓
  Enable on  → Correct output ✓
```

## How to Run
```bash
# Compile
iverilog -o decoder.vvp decoder_3to8.v decoder_3to8_tb.v

# Simulate
vvp decoder.vvp

# View waveforms
gtkwave decoder.vcd
```

## What I Learned

### Shift Operator (`<<`)
```verilog
value << n  // Shift value left by n positions
```
A powerful operator for creating patterns and one-hot encoding.

### One-Hot Encoding
A coding scheme where only one bit is high at any time:
- Easy to decode (single bit identifies the state)
- No priority encoding needed
- Used extensively in control logic and state machines

### Enable Signals
Common in digital design for:
- Power management (disable unused circuits)
- Conditional operation
- Bus arbitration
- Chip select in memory systems

### Ternary Operator for Clean Code
```verilog
output = condition ? true_value : false_value;
```
Makes the code concise and readable.

## Key Concepts

### Binary to One-Hot Conversion
The decoder performs a fundamental operation in digital systems: converting a compact binary representation into a sparse one-hot format that's easy to use for selection and control.

### Decoder vs Demultiplexer
- **Decoder:** Activates one of N outputs based on input code
- **Demultiplexer:** Routes a data input to one of N outputs
- A decoder is essentially a demux with the data input always = 1

### Scalability
The same pattern works for any size:
- 2-to-4 decoder (2 inputs → 4 outputs)
- 4-to-16 decoder (4 inputs → 16 outputs)
- 6-to-64 decoder (6 inputs → 64 outputs)

## Real-World Applications

Decoders are fundamental building blocks in:

### Memory Systems
- **Address Decoding:** Selecting which memory chip to access
- **Row/Column Selection:** Inside DRAM and SRAM arrays
- **Chip Select Generation:** In multi-chip systems

### CPU Design
- **Instruction Decoding:** Converting opcodes to control signals
- **Register Selection:** Choosing which register to read/write
- **Interrupt Vector Decoding:** Determining which interrupt handler to call

### I/O Systems
- **Peripheral Selection:** Choosing which device to communicate with
- **Port Decoding:** Enabling specific I/O ports
- **Display Drivers:** 7-segment displays, LED matrices

### State Machines
- **State Encoding:** One-hot state machine implementation
- **Output Generation:** Activating specific outputs per state

## Design Considerations

### One-Hot vs Binary Encoding
**Advantages of one-hot (decoder output):**
- Fast decoding (no logic needed)
- Easy to add/remove states
- Glitch-free in many cases

**Disadvantages:**
- More bits needed (8 bits instead of 3)
- More wiring in hardware

### Enable Signal Benefits
- Reduces power when not in use
- Prevents spurious activations
- Allows tri-state outputs (high, low, high-Z)
- Essential for bus-based systems

## Results
✅ Perfect one-hot encoding verified  
✅ Enable control working correctly  
✅ All 8 output combinations tested  
✅ Timing diagram confirms sequential activation

---

**🏆 WEEK 1 COMPLETE!**

This completes the combinational logic module (Projects 1-7). Next: Sequential circuits with memory and state!

**Part of 30-day Verilog learning journey**
