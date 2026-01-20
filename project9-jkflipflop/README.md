# Project 9: JK Flip-Flop

**Completed:** January 21, 2026

## Overview
A positive edge-triggered JK flip-flop with asynchronous reset. The most versatile flip-flop with four operating modes: Hold, Set, Reset, and Toggle.

## What is a JK Flip-Flop?

The JK flip-flop is an enhanced version of flip-flops with more control. It has two inputs (J and K) that provide four different operating modes, making it extremely versatile for counters, frequency dividers, and state machines.

**Key Feature:** The toggle mode (J=K=1) where the output flips on every clock edge - perfect for building counters!

## Truth Table
```
Clock | J K | Q(next)    | Mode        | Description
--------------------------------------------------------
  ↑   | 0 0 | Q(current) | HOLD        | No change
  ↑   | 0 1 |     0      | RESET       | Force Q to 0
  ↑   | 1 0 |     1      | SET         | Force Q to 1
  ↑   | 1 1 |    ~Q      | TOGGLE      | Flip state
```

**↑ = Rising clock edge (0→1)**

## Four Operating Modes

### Mode 1: HOLD (J=0, K=0)
- Output Q remains unchanged
- Maintains current state
- Memory retention mode

### Mode 2: RESET (J=0, K=1)
- Output Q forced to 0
- Clears the stored bit
- Similar to D flip-flop with D=0

### Mode 3: SET (J=1, K=0)
- Output Q forced to 1
- Sets the stored bit
- Similar to D flip-flop with D=1

### Mode 4: TOGGLE (J=1, K=1)
- Output Q flips to opposite value
- If Q=0 → becomes 1
- If Q=1 → becomes 0
- **Unique to JK flip-flop!**

## Components

### JK Flip-Flop
- **Inputs:** clk (clock), reset (asynchronous), j (set control), k (reset control)
- **Outputs:** q (stored value), q_bar (inverted output)
- **Trigger:** Positive edge-triggered
- **Special Feature:** Toggle mode for frequency division

## Files
- `jk_flipflop.v` - JK flip-flop module
- `jk_flipflop_tb.v` - Comprehensive testbench testing all 4 modes
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Implementation

### Using Case Statement for Mode Selection
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 1'b0;
    else begin
        case ({j, k})           // Concatenate J and K
            2'b00: q <= q;      // HOLD
            2'b01: q <= 1'b0;   // RESET
            2'b10: q <= 1'b1;   // SET
            2'b11: q <= ~q;     // TOGGLE
        endcase
    end
end
```

**Key Concept:** `{j, k}` concatenates the two 1-bit signals into a 2-bit value for the case statement.

## Test Results

All 4 modes verified ✅
```
RESET MODE (J=0, K=1):
  Q forced to 0 ✓

SET MODE (J=1, K=0):
  Q forced to 1 ✓

HOLD MODE (J=0, K=0):
  Q unchanged when 0 ✓
  Q unchanged when 1 ✓

TOGGLE MODE (J=1, K=1):
  Q=0 → Q=1 (first toggle) ✓
  Q=1 → Q=0 (second toggle) ✓
  Q=0 → Q=1 (third toggle) ✓
  Q=1 → Q=0 (fourth toggle) ✓
  Creates square wave at half clock frequency ✓
```

## How to Run
```bash
# Compile
iverilog -o jkff.vvp jk_flipflop.v jk_flipflop_tb.v

# Simulate
vvp jkff.vvp

# View waveforms (see the toggle action!)
gtkwave jk_flipflop.vcd
```

## What I Learned

### Toggle Mode = Frequency Divider

When J=K=1, the flip-flop toggles on every clock edge:
```
CLK: ↑___↑___↑___↑___↑___↑___↑___↑
Q:   0   1   0   1   0   1   0   1
```

**Output frequency = Input frequency / 2**

This is fundamental to:
- Binary counters
- Frequency synthesizers
- Clock dividers
- Timing circuits

### Case Statement in Verilog
```verilog
case (expression)
    value1: statement1;
    value2: statement2;
    default: statement3;
endcase
```

Evaluates expression and executes matching statement. Similar to switch/case in C/C++.

### Bit Concatenation
```verilog
{j, k}  // Combines two 1-bit signals into 2-bit value
```

Examples:
- j=0, k=0 → {j,k} = 2'b00
- j=1, k=0 → {j,k} = 2'b10
- j=1, k=1 → {j,k} = 2'b11

### Advantages Over D Flip-Flop

**D Flip-Flop:**
- 1 mode (copy input)
- Simple data storage
- Requires external logic for toggle

**JK Flip-Flop:**
- 4 modes (hold/set/reset/toggle)
- Built-in toggle capability
- More versatile control

**Trade-off:** JK requires 2 inputs vs 1 for D, but provides more functionality.

## Real-World Applications

### Binary Counters
Chain multiple JK flip-flops in toggle mode:
```
FF1 → FF2 → FF3 → FF4
(LSB)            (MSB)
```

- 1 JK FF: 1-bit counter (0→1→0...)
- 2 JK FFs: 2-bit counter (0→1→2→3→0...)
- 4 JK FFs: 4-bit counter (0→15)

### Frequency Division
Each JK flip-flop in toggle mode divides frequency by 2:
- Input: 8 MHz → Output: 4 MHz (÷2)
- Chain 3 FFs: 8 MHz → 1 MHz (÷8)
- Used in clock generation circuits

### State Machines
Use different modes for state transitions:
- SET mode: Force to specific state
- RESET mode: Return to initial state
- TOGGLE mode: Alternate between two states

### Ripple Counters
Asynchronous counters built by cascading JK flip-flops:
- First FF toggles every clock
- Second FF toggles when first FF goes 1→0
- Creates binary counting sequence

### Shift Registers
Can be configured as shift registers with appropriate J-K connections.

## Design Notes

### Toggle Mode Analysis

**Behavioral Equation:**
```
Q(next) = J·Q̄ + K̄·Q
```

When J=K=1:
```
Q(next) = 1·Q̄ + 0·Q = Q̄
```

Output is always the complement of current state → Toggle!

### Master-Slave Configuration
In real hardware, JK flip-flops often use master-slave design:
- Master captures on clock high
- Slave updates on clock low
- Prevents race conditions

This behavioral model abstracts that complexity.

### Race Condition (Historical)
Original SR (Set-Reset) flip-flops had undefined behavior when S=R=1. JK flip-flop solves this with toggle mode instead of undefined state.

## Timing Diagram Observations

In GTKWave waveforms:

1. **HOLD mode:** Q flat (no transitions)
2. **SET mode:** Q jumps to high
3. **RESET mode:** Q drops to low
4. **TOGGLE mode:** Q creates perfect square wave
   - Period = 2 × clock period
   - Frequency = clock frequency / 2

**Key observation:** In toggle mode (time 82-112), Q oscillates creating a frequency divider!

## Comparison with D Flip-Flop

| Feature | D Flip-Flop (Project 8) | JK Flip-Flop (Project 9) |
|---------|------------------------|--------------------------|
| Inputs | D (1 bit) | J, K (2 bits) |
| Modes | 1 (copy D) | 4 (hold/set/reset/toggle) |
| Toggle | Needs external XOR | Built-in (J=K=1) |
| Counters | Requires feedback logic | Natural toggle mode |
| Complexity | Simpler | More versatile |
| Use Case | Data storage/registers | Counters/dividers |

## Results
✅ All 4 operating modes verified  
✅ Toggle mode creates perfect frequency division  
✅ Set/Reset modes force output correctly  
✅ Hold mode maintains state  
✅ Asynchronous reset working  

---

**Foundation for binary counters (Project 12)!**

**Part of 30-day Verilog learning journey**
