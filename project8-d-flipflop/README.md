# Project 8: D Flip-Flop

**Completed:** January 21, 2026

**🎉 WEEK 2 BEGINS! First sequential circuit with memory.**

## Overview
A positive edge-triggered D flip-flop with asynchronous reset. This is the first sequential logic project - introducing circuits that have memory and respond to clock timing.

## What is a D Flip-Flop?

A D (Data) flip-flop is a basic memory element that stores one bit of information. Unlike combinational circuits, the output depends on:
- Current input (D)
- Clock timing (changes only on clock edges)
- Previous state (memory!)

**Key Behavior:**
- On **rising clock edge** (0→1): Output Q captures the value of input D
- Between clock edges: Output Q holds its value (MEMORY)
- **Asynchronous reset**: Forces Q to 0 immediately, regardless of clock

## Truth Table
```
Clock | Reset | D | Q(next) | Description
----------------------------------------------
  ↑   |   0   | 0 |    0    | Capture D=0
  ↑   |   0   | 1 |    1    | Capture D=1
  -   |   0   | x | Q(prev) | Hold value (no clock edge)
  x   |   1   | x |    0    | Reset (asynchronous)
```

**↑ = Rising edge (0→1)**

## Components

### D Flip-Flop
- **Inputs:** clk (clock), reset (asynchronous), d (data)
- **Outputs:** q (stored value), q_bar (inverted output)
- **Trigger:** Positive edge-triggered (posedge clk)
- **Reset:** Asynchronous (doesn't wait for clock)

## Files
- `d_flipflop.v` - D flip-flop module
- `d_flipflop_tb.v` - Comprehensive testbench with clock generation
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Implementation

### Behavioral Modeling with Always Block
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 1'b0;      // Reset takes priority
    else
        q <= d;         // Capture D on clock edge
end
```

**Key Verilog Concepts:**
- `always @(posedge clk)` - Triggers on rising clock edge
- `<=` - Non-blocking assignment (used in sequential logic)
- `reg` type for outputs that hold values
- Sensitivity list with multiple events (clk OR reset)

## Test Results

All test cases passed ✅
```
RESET BEHAVIOR:
  Reset active → Q=0 (immediate) ✓
  Reset released → Q stable ✓

CLOCK-SYNCHRONIZED OPERATION:
  D=0, clock edge → Q=0 ✓
  D=1, clock edge → Q=1 ✓
  D changes, NO clock edge → Q unchanged (holds value) ✓

ASYNCHRONOUS RESET:
  Reset activates → Q=0 immediately (doesn't wait for clock) ✓

COMPLEMENTARY OUTPUT:
  Q_bar always = ~Q ✓
```

## How to Run
```bash
# Compile
iverilog -o dff.vvp d_flipflop.v d_flipflop_tb.v

# Simulate
vvp dff.vvp

# View waveforms (IMPORTANT - see the clock!)
gtkwave d_flipflop.vcd
```

## What I Learned

### Sequential vs Combinational Logic

**Combinational (Week 1):**
- Output changes immediately when input changes
- No memory of previous states
- No clock required
- Examples: Gates, adders, multiplexers

**Sequential (Week 2):**
- Output changes only on clock edges
- Remembers previous state (MEMORY!)
- Clock-synchronized operation
- Examples: Flip-flops, registers, counters

### Clock Signal
A periodic square wave that synchronizes operations:
```
CLK: ___┌─┐___┌─┐___┌─┐___
         ↑     ↑     ↑
    Rising edges (posedge)
```

All flip-flops in a system typically share the same clock for synchronization.

### Non-blocking Assignment (`<=`)
```verilog
q <= d;  // Non-blocking (parallel, sequential logic)
```
vs.
```verilog
q = d;   // Blocking (sequential execution, combinational)
```

**Rule:** Always use `<=` in clocked always blocks!

### Asynchronous vs Synchronous Reset

**Asynchronous (this project):**
```verilog
always @(posedge clk or posedge reset)
```
- Reset happens immediately
- Doesn't wait for clock edge
- Used when instant reset is critical

**Synchronous (alternative):**
```verilog
always @(posedge clk)
    if (reset) ...
```
- Reset waits for clock edge
- Better for avoiding metastability
- More common in modern designs

### Register (`reg`) Type
```verilog
output reg q;
```
Outputs that hold values (memory) must be declared as `reg` type, even though they're not always registers in hardware.

## Key Concepts

### Edge-Triggered Operation
The flip-flop responds to the **edge** (transition) of the clock, not the level:
- **Positive edge:** 0→1 transition
- **Negative edge:** 1→0 transition

This project uses positive edge triggering.

### Setup and Hold Time
In real hardware, D must be stable for a certain time:
- **Setup time:** Before clock edge
- **Hold time:** After clock edge

Violations cause metastability (unpredictable behavior).

### Metastability
If D changes exactly at clock edge, Q can enter an unstable state. Good design ensures D is stable during setup/hold windows.

## Real-World Applications

D flip-flops are fundamental building blocks in:

### Registers
- CPU registers are arrays of D flip-flops
- Each bit is stored in one flip-flop
- Example: 32-bit register = 32 D flip-flops

### Pipeline Stages
- Processors use flip-flops between pipeline stages
- Data is captured at each clock cycle
- Enables parallel processing

### Synchronization
- Crossing clock domains
- Preventing metastability
- Input buffering

### State Storage
- Finite state machines (FSMs)
- Control logic
- Sequence detection

### Memory Elements
- Cache tag storage
- FIFO buffers
- Shift registers (next project!)

## Design Notes

### Why Asynchronous Reset?
- Ensures known initial state
- Can reset without waiting for clock
- Critical for system startup

### Q and Q_bar Outputs
- Q_bar is simply the inverse of Q
- Some circuits need both polarities
- Implemented with combinational logic (`assign`)

### Clock Generation in Testbench
```verilog
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 time unit period
end
```
Creates a continuous clock for testing.

## Timing Diagram Observations

In GTKWave, observe:
1. **CLK:** Regular square wave
2. **D:** Changes at various times
3. **Q:** Changes ONLY on rising edges of CLK
4. **Q:** Holds value between edges (flat lines = memory!)
5. **RESET:** Immediately forces Q=0 when activated

**Critical observation:** Between times 66-73, D changes but Q doesn't update until the clock edge arrives!

## Results
✅ Clock-synchronized operation verified  
✅ Memory behavior confirmed (holds value)  
✅ Asynchronous reset working correctly  
✅ Q_bar always complements Q  
✅ Timing diagram shows proper edge-triggered behavior

---

**🎊 First sequential circuit complete!**

This flip-flop is the foundation for all remaining Week 2 projects: JK flip-flop, T flip-flop, shift registers, counters, and state machines.

**Part of 30-day Verilog learning journey**
