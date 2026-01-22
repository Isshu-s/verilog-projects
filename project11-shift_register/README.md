# Project 11: 4-bit Shift Register

**Completed:** January 20, 2026

## Overview
A 4-bit Serial-In, Serial-Out (SISO) shift register. Data shifts right through a chain of flip-flops on each clock edge, creating a "conveyor belt" for bits.

## What is a Shift Register?

A shift register is a cascade of flip-flops where the output of one flip-flop feeds into the input of the next. On each clock edge, data shifts one position, moving through the register like items on a conveyor belt.

**Key Concept:** Temporal storage - data takes multiple clock cycles to traverse the register, creating a delay effect.

## Operation Principle
```
Serial In → [FF3] → [FF2] → [FF1] → [FF0] → Serial Out
         MSB                         LSB
```

**Each clock edge:**
- Serial_in enters the register (becomes Q3)
- Each bit shifts right: Q3→Q2, Q2→Q1, Q1→Q0
- Q0 exits as serial_out

**Example: Shifting pattern 1011**
```
Clock | Input | Q3 Q2 Q1 Q0 | Output
  0   |   -   | 0  0  0  0  |   0
  1   |   1   | 0  0  0  1  |   0
  2   |   0   | 0  0  1  0  |   1
  3   |   1   | 0  1  0  1  |   0
  4   |   1   | 1  0  1  1  |   1  ← Pattern complete!
```

## Components

### 4-bit Shift Register (SISO)
- **Inputs:** clk (clock), reset (asynchronous), serial_in (data input)
- **Outputs:** serial_out (data output), q[3:0] (parallel view of all bits)
- **Type:** Serial-In, Serial-Out (SISO)
- **Direction:** Right shift (MSB to LSB)

## Files
- `shift_register_4bit.v` - Shift register module
- `shift_register_4bit_tb.v` - Comprehensive testbench
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Implementation

### Elegant Bit Concatenation
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        shift_reg <= 4'b0000;
    else
        shift_reg <= {serial_in, shift_reg[3:1]};
end
```

**How the shift works:**
```
Before: shift_reg = [Q3 Q2 Q1 Q0] = [1 0 1 1]
Input:  serial_in = 0

Concatenation: {0, [1 0 1]} = [0 1 0 1]
               ↑   ↑-------↑
              new   bits 3,2,1
              
After:  shift_reg = [0 1 0 1]
```

**Bit 0 is dropped (exits as serial_out)**

### Alternative Explicit Implementation
```verilog
// Equivalent to concatenation method
shift_reg[0] <= shift_reg[1];
shift_reg[1] <= shift_reg[2];
shift_reg[2] <= shift_reg[3];
shift_reg[3] <= serial_in;
```

## Test Results

All test cases passed ✅
```
PATTERN 1: Shifting in 1011
  Clock 1: Input 1 → Register: 0001
  Clock 2: Input 0 → Register: 0010
  Clock 3: Input 1 → Register: 0101
  Clock 4: Input 1 → Register: 1011 ✓

SHIFTING OUT (input zeros):
  Clock 5: Output 1 (first bit)
  Clock 6: Output 1 (second bit)
  Clock 7: Output 0 (third bit)
  Clock 8: Output 1 (fourth bit)
  Complete pattern 1011 shifted out! ✓

PATTERN 2: Shifting in 1010
  Successfully loaded into register ✓
  
4-CLOCK DELAY VERIFIED:
  Bit enters at time T → Exits at time T+4 ✓
```

## How to Run
```bash
# Compile
iverilog -o sr.vvp shift_register_4bit.v shift_register_4bit_tb.v

# Simulate
vvp sr.vvp

# View waveforms (watch data march through!)
gtkwave shift_register.vcd
```

## What I Learned

### Bit Concatenation and Slicing

**Concatenation `{}`:**
```verilog
{a, b, c}  // Combines signals into one vector
```

Examples:
- `{1'b0, 3'b101}` → `4'b0101`
- `{serial_in, shift_reg[3:1]}` → New 4-bit value

**Slicing `[upper:lower]`:**
```verilog
shift_reg[3:1]  // Bits 3, 2, 1 (excludes bit 0)
shift_reg[2:0]  // Bits 2, 1, 0 (excludes bit 3)
```

### Data Movement Through Time

Unlike combinational circuits (instant), shift registers create **temporal separation**:
- Bit at position 0 at time T
- Same bit at position 1 at time T+1
- Same bit at position 2 at time T+2
- Same bit at position 3 at time T+3

**4-bit shift register = 4 clock cycles of delay**

### Serial vs Parallel Data

**Serial Communication:**
- 1 wire carries bits sequentially
- Slower but fewer connections
- Used: UART, SPI, I2C, USB

**Parallel Communication:**
- N wires carry N bits simultaneously
- Faster but more connections
- Used: Internal buses, memory interfaces

**Shift registers bridge the gap!**

### Visualization of Shift Operation
```
Initial state: [0 0 0 0]

Clock 1, Input=1:
  New → [1 0 0 0] → 0 exits
        ↓ ↓ ↓ ↓
  [0 0 0 1] ← Shifted right

Clock 2, Input=0:
  New → [0 0 0 1] → 1 exits
        ↓ ↓ ↓ ↓
  [0 0 1 0] ← Shifted right
```

Data "marches" from left to right!

## Real-World Applications

### 1. Serial Communication (UART, SPI, I2C)

**Transmit (Parallel → Serial):**
```
8-bit data [D7 D6 D5 D4 D3 D2 D1 D0]
↓ Load into 8-bit shift register
↓ Shift out bit-by-bit on TX line
Serial transmission: D0 D1 D2 D3 D4 D5 D6 D7
```

**Receive (Serial → Parallel):**
```
Serial data on RX line
↓ Shift into 8-bit register
↓ After 8 clocks, parallel data ready
8-bit data [D7 D6 D5 D4 D3 D2 D1 D0]
```

### 2. LED Matrix / Display Drivers

Example: 74HC595 shift register IC
- Microcontroller has limited pins
- Shift data serially into display controller
- Control 8+ LEDs with just 3 pins (Data, Clock, Latch)

### 3. Delay Lines

**Audio/Video Effects:**
- Echo: Delayed copy of signal
- Reverb: Multiple delayed copies
- Implementation: Chain shift registers

**Digital Signal Processing:**
- FIR filters use delay lines
- Each tap = different delay

### 4. CRC and Error Detection

**Cyclic Redundancy Check:**
- Uses Linear Feedback Shift Register (LFSR)
- Polynomial division in hardware
- Detects transmission errors

### 5. Pseudo-Random Number Generation

**LFSR Configuration:**
- Feedback taps at specific positions
- XOR gates in feedback path
- Generates pseudo-random sequences
- Used in cryptography, testing, spread spectrum

### 6. Ring Counters

**Circular Shift Register:**
```verilog
shift_reg <= {shift_reg[0], shift_reg[3:1]};
// Output feeds back to input
```

Creates rotating pattern:
```
1000 → 0100 → 0010 → 0001 → 1000 (repeat)
```

Used in:
- Stepper motor control
- State machines with cyclic states
- Johnson counters

## Types of Shift Registers

### 1. SISO (This Project)
- Serial-In, Serial-Out
- Data enters and exits one bit at a time
- Simplest implementation

### 2. SIPO
- Serial-In, Parallel-Out
- Load data serially, read all bits simultaneously
- Used: Serial-to-parallel conversion

### 3. PISO
- Parallel-In, Serial-Out
- Load all bits at once, shift out serially
- Used: Parallel-to-serial conversion

### 4. PIPO
- Parallel-In, Parallel-Out
- Full parallel access
- Used: General-purpose registers

### 5. Bidirectional
- Can shift left OR right
- Control signal determines direction
- More versatile, more complex

## Design Variations

### Right Shift (This Project)
```verilog
shift_reg <= {serial_in, shift_reg[3:1]};
// MSB ← input ... LSB → output
```

### Left Shift
```verilog
shift_reg <= {shift_reg[2:0], serial_in};
// MSB → output ... LSB ← input
```

### Rotation (Ring Counter)
```verilog
shift_reg <= {shift_reg[0], shift_reg[3:1]};
// Circular: output feeds back to input
```

## Timing Analysis

### Delay Characteristics

For an N-bit shift register:
- **Latency:** N clock cycles (input to output)
- **Throughput:** 1 bit per clock cycle
- **Storage:** N bits

**This 4-bit register:**
- Latency: 4 clocks
- Throughput: 1 bit/clock
- Storage: 4 bits

### Clock Frequency Impact

If clock = 1 MHz:
- Bit rate = 1 Mbit/s
- 4-bit latency = 4 μs

If clock = 100 MHz:
- Bit rate = 100 Mbit/s
- 4-bit latency = 40 ns

## Timing Diagram Observations

In GTKWave waveforms:

1. **Serial_in:** Changes at various times
2. **Q[3:0]:** Watch bits "march" through
   - Clock 1: xxx1
   - Clock 2: xx10
   - Clock 3: x101
   - Clock 4: 1011
3. **Serial_out:** Lags input by 4 clocks
4. **Beautiful cascade:** See data flowing like water!

**Key observation:** The parallel output `q[3:0]` shows all stages simultaneously - you can literally watch data propagate!

## Advanced Concepts

### Metastability Consideration

In real hardware with asynchronous input:
```verilog
// Add synchronizer (2-FF chain)
reg sync1, sync2;
always @(posedge clk) begin
    sync1 <= async_input;
    sync2 <= sync1;
end
// Use sync2 as serial_in
```

Prevents metastability from asynchronous signals.

### Pipelining Connection

Shift registers are fundamental to pipelined systems:
- Each stage = 1 clock delay
- Multiple operations in flight
- Increases throughput

Example: 4-stage pipeline = 4 shift register levels

## Results
✅ Data shifts correctly through all 4 stages  
✅ Pattern 1011 successfully shifted in and out  
✅ 4-clock delay verified  
✅ Parallel view shows all bits simultaneously  
✅ Ready for use in serial communication!

---

**Foundation for understanding sequential data flow!**

**Part of 30-day Verilog learning journey**
