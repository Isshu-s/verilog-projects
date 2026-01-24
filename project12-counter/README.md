# Project 12: 4-bit Binary Counter

**Completed:** January 24,2026

**🎉 40% COMPLETE! Almost halfway through the 30-day challenge!**

## Overview
A 4-bit synchronous binary counter that counts from 0 to 15 and wraps around. Includes enable control for pausing/resuming counting and asynchronous reset.

## What is a Binary Counter?

A binary counter is a sequential circuit that counts in binary sequence. Each clock edge increments the count by 1, creating the familiar binary counting pattern used in timers, address generators, and frequency dividers.

**Counting Sequence:**
```
0000 → 0001 → 0010 → 0011 → 0100 → ... → 1111 → 0000 (wrap)
  0  →   1  →   2  →   3  →   4  → ... →  15  →   0
```

## Components

### 4-bit Synchronous Counter
- **Inputs:** clk (clock), reset (asynchronous), enable (count control)
- **Outputs:** count[3:0] (4-bit count value)
- **Range:** 0 to 15 (2⁴ states)
- **Type:** Synchronous (all flip-flops share same clock)
- **Features:** Enable control, automatic wrap-around

## Files
- `counter_4bit.v` - 4-bit counter module
- `counter_4bit_tb.v` - Comprehensive testbench
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Implementation

### Behavioral Counter Design
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        count_reg <= 4'b0000;
    else if (enable)
        count_reg <= count_reg + 1;  // Automatic increment!
end
```

**Key Features:**
1. **Arithmetic operator `+1`:** Verilog synthesizes this into an adder circuit
2. **Automatic wrap-around:** 15 (1111) + 1 = 0 (0000) - overflow bit discarded
3. **Enable control:** When enable=0, counter holds current value
4. **Asynchronous reset:** Immediately clears to 0

## Counting Sequence
```
Clock | Enable | Count (Binary) | Count (Decimal)
----------------------------------------------------
  0   |   1    |      0000      |        0
  1   |   1    |      0001      |        1
  2   |   1    |      0010      |        2
  3   |   1    |      0011      |        3
  4   |   1    |      0100      |        4
  5   |   1    |      0101      |        5
  6   |   1    |      0110      |        6
  7   |   1    |      0111      |        7
  8   |   1    |      1000      |        8
  9   |   1    |      1001      |        9
 10   |   1    |      1010      |       10
 11   |   1    |      1011      |       11
 12   |   1    |      1100      |       12
 13   |   1    |      1101      |       13
 14   |   1    |      1110      |       14
 15   |   1    |      1111      |       15
 16   |   1    |      0000      |        0  ← Wrap-around!
```

## Test Results

All test cases passed ✅
```
COUNTING TEST:
  Counts 0 → 15 sequentially ✓
  Each increment happens on clock edge ✓

WRAP-AROUND TEST:
  15 (1111) + 1 = 0 (0000) ✓
  Automatic overflow handling ✓

ENABLE CONTROL TEST:
  Enable=1: Counter increments ✓
  Enable=0: Counter holds value ✓
  Resume from held value ✓

ASYNCHRONOUS RESET TEST:
  Reset=1: Immediate clear to 0 ✓
  Doesn't wait for clock edge ✓
  Can reset during counting ✓
```

## How to Run
```bash
# Compile
iverilog -o counter.vvp counter_4bit.v counter_4bit_tb.v

# Simulate
vvp counter.vvp

# View waveforms (watch it count!)
gtkwave counter.vcd
```

## What I Learned

### Arithmetic in Hardware Description
```verilog
count_reg <= count_reg + 1;
```

**What this synthesizes to:**
- 4-bit adder circuit
- Feedback path (output connects to input)
- Registers to hold state
- Carry chain for multi-bit addition

**Hardware realization:**
```
[4-bit Register] → [4-bit Adder (+1)] → [4-bit Register]
       ↑                                        |
       └────────────────────────────────────────┘
```

### Automatic Overflow Handling

**4-bit register can only hold 0-15:**
```
Binary addition:
  1111  (15)
+    1  (1)
------
 10000  (16 in 5 bits)

Only 4 bits stored: 0000 (overflow bit discarded)
```

This is **modulo arithmetic:** (15 + 1) mod 16 = 0

### Enable Signal for Control

Common control pattern in sequential circuits:
```verilog
if (enable)
    // perform operation
else
    // hold current state
```

**Applications:**
- Pause/resume functionality
- Conditional operation
- Power saving (reduce switching when idle)

### Synchronous vs Asynchronous Design

**Synchronous Counter (this project):**
- All flip-flops clocked simultaneously
- Parallel update of all bits
- No propagation delay between bits
- Modern standard design

**Asynchronous/Ripple Counter:**
- Cascade of T flip-flops
- Output of one FF clocks next FF
- Sequential bit updates (ripple effect)
- Simpler but slower

### Bit Toggle Patterns

Observe individual bit behavior:
- **Q0 (LSB):** Toggles every clock cycle
- **Q1:** Toggles every 2 clock cycles
- **Q2:** Toggles every 4 clock cycles
- **Q3 (MSB):** Toggles every 8 clock cycles

**Each bit is a frequency divider:**
- Q0: Clock ÷ 2
- Q1: Clock ÷ 4
- Q2: Clock ÷ 8
- Q3: Clock ÷ 16

## Real-World Applications

### 1. Program Counter in CPUs

**The most important counter in computing:**
```
loop:
    Fetch instruction at address PC
    Decode instruction
    Execute instruction
    PC = PC + 1        ← Counter increment!
    goto loop
```

Every CPU has a program counter that sequences through instructions.

### 2. Timer Peripherals

**Microcontroller timers (Arduino, STM32, etc.):**
- Count clock cycles
- Generate time delays
- Create periodic interrupts
- PWM generation

**Example: 1ms timer with 1 MHz clock**
```
Count 0 → 999 (1000 cycles)
At 1 MHz: 1000 cycles = 1 ms
Reset and repeat
```

### 3. Memory Address Generation

**Sequential memory access:**
```
for (address = 0; address < 256; address++) {
    data = memory[address];  // Counter generates addresses
    process(data);
}
```

Used in:
- DMA (Direct Memory Access)
- Video frame buffers
- Memory testing

### 4. Frequency Division

**Clock generation circuits:**
```
Input: 16 MHz system clock
Output Q3: 1 MHz (÷16)
Output Q2: 2 MHz (÷8)
Output Q1: 4 MHz (÷4)
Output Q0: 8 MHz (÷2)
```

### 5. Digital Clocks and Watches

**Time keeping:**
```
Counter 1: Count 0-9 (seconds ones)
Counter 2: Count 0-5 (seconds tens)
Counter 3: Count 0-9 (minutes ones)
Counter 4: Count 0-5 (minutes tens)
...
```

Chain counters with different modulos for time display.

### 6. Event Counting

- Pulse counters
- Revolution counters (tachometers)
- People counters
- Inventory systems

## Design Variations

### Up Counter (This Project)
```verilog
count <= count + 1;  // Increment
```

### Down Counter
```verilog
count <= count - 1;  // Decrement
// Wraps: 0 → 15 → 14 → 13 ...
```

### Up/Down Counter
```verilog
if (up_down)
    count <= count + 1;
else
    count <= count - 1;
```

### Loadable Counter
```verilog
if (load)
    count <= preset_value;  // Parallel load
else if (enable)
    count <= count + 1;
```

### Modulo-N Counter

**Count to specific value then reset:**
```verilog
if (count == N-1)
    count <= 0;
else
    count <= count + 1;
```

**Example: Decade counter (0-9):**
```verilog
if (count == 9)
    count <= 0;
else
    count <= count + 1;
```

### Ring Counter

**One-hot rotating pattern:**
```
0001 → 0010 → 0100 → 1000 → 0001 ...
```

Used in stepper motor control.

## Comparison: Counter Implementations

### Behavioral (This Project)
**Pros:**
- Clean, readable code
- Synthesizer optimizes
- Easy to modify

**Cons:**
- Less control over exact hardware

### Structural (Using T Flip-Flops)
**Pros:**
- Explicit hardware structure
- Educational value
- Can optimize specific paths

**Cons:**
- More verbose code
- Manual optimization needed

### Built-in (Using Generate)
**Pros:**
- Scalable to any bit width
- Parameterized designs
- Reusable modules

**Cons:**
- More complex syntax

**Modern practice:** Use behavioral for clarity, trust synthesizer!

## Timing Analysis

### Propagation Delay

**Synchronous counter:**
- All bits update simultaneously on clock edge
- Delay = Clock-to-Q + Setup time
- **No ripple delay!**

**Asynchronous counter:**
- Bits update sequentially
- Delay = n × (Clock-to-Q + Setup)
- Slower for large bit widths

### Maximum Frequency

**Limiting factors:**
1. Adder propagation delay
2. Register setup time
3. Clock-to-Q delay

**For 4-bit counter:**
- Typical: 100+ MHz in modern FPGAs
- ASIC: GHz range possible

### Power Consumption

**Factors:**
- Switching activity (how many bits toggle)
- Clock frequency
- Enable control can reduce power

**Power saving:**
- Use enable to gate counting when idle
- Clock gating techniques
- Dynamic voltage/frequency scaling

## Timing Diagram Observations

In GTKWave waveforms:

1. **count[3:0] overall:** See smooth progression 0→15
2. **count[0]:** Square wave (toggles every clock)
3. **count[1]:** Half frequency of count[0]
4. **count[2]:** Half frequency of count[1]
5. **count[3]:** Slowest, toggles every 8 clocks
6. **Enable=0:** All bits freeze (flat lines)
7. **Reset:** Immediate jump to 0000

**Beautiful staircase pattern showing binary progression!**

## Mathematical Properties

### Modulo Arithmetic
```
count(n+1) = (count(n) + 1) mod 16
```

### Period
- Full cycle: 16 clock periods
- Any bit k: Period = 2^(k+1) clocks

### State Space
- Total states: 2⁴ = 16
- All states utilized (no unused states)

## Advanced Concepts

### Gray Code Counter

**Alternative encoding:**
- Only 1 bit changes per transition
- Reduces glitches
- Used in asynchronous designs
```
Binary vs Gray:
0000 → 0001    vs    0000 → 0001
0001 → 0010    vs    0001 → 0011  (only 1 bit changed)
0010 → 0011    vs    0011 → 0010
```

### Johnson Counter

**Shift register with inverted feedback:**
```
0000 → 0001 → 0011 → 0111 → 1111 →
1110 → 1100 → 1000 → 0000 (repeat)
```

Uses 2n states for n flip-flops.

### Prescaler Application

**Divide high-frequency clock for slower peripherals:**
```
System: 100 MHz
UART: Needs 9600 Hz for baud rate

Prescaler: 100,000,000 / 9600 ≈ 10,417
Use 14-bit counter (2^14 = 16,384)
```

## Results
✅ Counts 0 to 15 in perfect binary sequence  
✅ Automatic wrap-around verified  
✅ Enable control allows pause/resume  
✅ Asynchronous reset works correctly  
✅ All bits toggle at correct frequencies  
✅ Foundation for timers, CPUs, and addressing!

---

**🎊 71% of Week 2 complete! Only 2 projects left!**

**Part of 30-day Verilog learning journey**
