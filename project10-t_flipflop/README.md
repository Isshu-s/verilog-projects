# Project 10: T Flip-Flop (Toggle Flip-Flop)

**Completed:** January 22, 2026

**🎉 ONE-THIRD COMPLETE! (33% of 30-day challenge)**

## Overview
A positive edge-triggered T (Toggle) flip-flop with asynchronous reset. The simplest flip-flop with only two modes: Hold and Toggle. Perfect for frequency division and binary counters.

## What is a T Flip-Flop?

The T flip-flop is the simplest flip-flop design with a single control input (T). It has one primary function: **toggle the output when commanded**.

**Key Characteristic:** When T=1, the output flips to its opposite value on every clock edge, creating a perfect frequency divider.

## Truth Table
```
Clock | T | Q(next)    | Mode        | Description
-----------------------------------------------------
  ↑   | 0 | Q(current) | HOLD        | Output unchanged
  ↑   | 1 |    ~Q      | TOGGLE      | Output flips
```

**↑ = Rising clock edge (0→1)**

**Simple and elegant - just two modes!**

## Two Operating Modes

### Mode 1: HOLD (T=0)
- Output Q remains unchanged
- Maintains current state
- Memory retention

### Mode 2: TOGGLE (T=1)
- Output Q flips to opposite value
- If Q=0 → becomes 1
- If Q=1 → becomes 0
- Creates square wave at half the clock frequency

## Components

### T Flip-Flop
- **Inputs:** clk (clock), reset (asynchronous), t (toggle control)
- **Outputs:** q (stored value), q_bar (inverted output)
- **Function:** Toggle when T=1, Hold when T=0
- **Special Feature:** Perfect frequency divider when T=1

## Files
- `t_flipflop.v` - T flip-flop module
- `t_flipflop_tb.v` - Comprehensive testbench with frequency division test
- `output.png` - Console test results
- `waveforms.png` - GTKWave timing diagram

## Implementation

### Three Equivalent Methods

**Method 1: If-Else (Clearest)**
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 1'b0;
    else begin
        if (t)
            q <= ~q;    // Toggle
        else
            q <= q;     // Hold
    end
end
```

**Method 2: Ternary Operator (Concise)**
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 1'b0;
    else
        q <= t ? ~q : q;
end
```

**Method 3: XOR (Hardware-Efficient)**
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 1'b0;
    else
        q <= q ^ t;  // Q XOR T
end
```

All three produce identical behavior!

## Test Results

All test cases passed ✅
```
HOLD MODE (T=0):
  Q stays at 0 when T=0 ✓
  Q stays at 1 when T=0 ✓

TOGGLE MODE (T=1):
  Q: 0→1 (first toggle) ✓
  Q: 1→0 (second toggle) ✓
  Q: 0→1 (third toggle) ✓
  Q: 1→0 (fourth toggle) ✓
  Q: 0→1 (fifth toggle) ✓
  Q: 1→0 (sixth toggle) ✓

FREQUENCY DIVISION:
  Clock period: 10 time units
  Q period (when T=1): 20 time units
  Frequency division ratio: 2 ✓
```

## How to Run
```bash
# Compile
iverilog -o tff.vvp t_flipflop.v t_flipflop_tb.v

# Simulate
vvp tff.vvp

# View waveforms (see the perfect square wave!)
gtkwave t_flipflop.vcd
```

## What I Learned

### Frequency Division

When T=1 continuously, the T flip-flop acts as a divide-by-2 circuit:
```
Input Clock:  ↑___↑___↑___↑___↑___↑___↑___↑
Output Q:     0   1   0   1   0   1   0   1
```

**Output frequency = Input frequency ÷ 2**

**Applications:**
- 100 MHz → 50 MHz (÷2)
- 8 MHz → 4 MHz (÷2)
- Chain 3 T-FFs: 8 MHz → 1 MHz (÷8)

### Binary Counter Building Block

Chain multiple T flip-flops to create binary counters:
```
Input → TFF0 → TFF1 → TFF2 → TFF3
        (÷2)   (÷4)   (÷8)   (÷16)
        LSB                   MSB
```

**4 T-FFs create a 4-bit counter (0-15)**

Each flip-flop:
- TFF0: Toggles every clock cycle (÷2)
- TFF1: Toggles every 2 clock cycles (÷4)
- TFF2: Toggles every 4 clock cycles (÷8)
- TFF3: Toggles every 8 clock cycles (÷16)

Result: Binary counting sequence!

### Simplicity vs Functionality

**Comparison of Flip-Flops:**

| Flip-Flop | Inputs | Modes | Best Use Case |
|-----------|--------|-------|---------------|
| D | 1 (D) | 1 | Data storage, registers |
| JK | 2 (J,K) | 4 | Versatile state machines |
| T | 1 (T) | 2 | Counters, frequency dividers |

**T flip-flop sweet spot:**
- Simpler than JK (fewer inputs)
- More versatile than pure toggle
- Perfect for counting/dividing

### XOR Implementation

The toggle operation is fundamentally an XOR:
```verilog
Q(next) = Q ⊕ T

Truth table:
Q T | Q(next)
0 0 |   0     (0 XOR 0 = 0)
0 1 |   1     (0 XOR 1 = 1, toggled!)
1 0 |   1     (1 XOR 0 = 1)
1 1 |   0     (1 XOR 1 = 0, toggled!)
```

This is why `q <= q ^ t;` works perfectly!

## Real-World Applications

### 1. Ripple Counters (Asynchronous Counters)

Connect T flip-flops in cascade with all T inputs tied high:
```
Clock → [TFF0] → [TFF1] → [TFF2] → [TFF3]
         Q0       Q1       Q2       Q3
```

**Counting sequence (Q3 Q2 Q1 Q0):**
```
0000 → 0001 → 0010 → 0011 → 0100 → ... → 1111 → 0000
```

Creates a 4-bit binary counter (0-15).

### 2. Clock Frequency Dividers

**Example: Generate multiple clock frequencies from one source**

Input: 16 MHz crystal oscillator
- After TFF0: 8 MHz
- After TFF1: 4 MHz
- After TFF2: 2 MHz
- After TFF3: 1 MHz

Used in:
- Microcontroller clock trees
- UART baud rate generation
- Timer prescalers

### 3. Toggle Switches

Physical toggle switches in digital systems:
- Button press → generates T=1 pulse
- Output toggles between ON/OFF
- Used in power switches, mode selectors

### 4. Duty Cycle Generation

Perfect 50% duty cycle square wave generation:
- Essential for clock signals
- Motor control PWM
- Communication timing

### 5. Frequency Synthesis

Building blocks for:
- Phase-locked loops (PLLs)
- Frequency dividers in RF circuits
- Clock multipliers/dividers

## Design Notes

### Why T Flip-Flop Exists

**Could we just use JK with J=K=1?**

Yes, but T flip-flop is better because:

1. **Simpler Hardware**
   - 1 input vs 2 inputs
   - Fewer gates, less area
   - Lower power consumption

2. **Clearer Design Intent**
   - Explicitly designed for toggle/divide
   - Self-documenting code
   - Easier to understand schematics

3. **Optimization**
   - Synthesizers can optimize T-FF specifically
   - Better performance in ASIC/FPGA

### Toggle Operation Analysis

**Behavioral equation:**
```
Q(t+1) = T ⊕ Q(t)
       = T·Q̄(t) + T̄·Q(t)
```

When T=0: Q(t+1) = Q(t) → Hold  
When T=1: Q(t+1) = Q̄(t) → Toggle

### Synchronous vs Asynchronous Counters

**Asynchronous (Ripple) Counter:**
- Uses T flip-flops cascaded
- Each FF clocks the next
- Simple but slower (ripple delay)

**Synchronous Counter:**
- All FFs share same clock
- More complex control logic
- Faster, no ripple delay

T flip-flops used in both, but ripple counters are simpler!

## Timing Diagram Observations

In GTKWave waveforms, observe:

1. **T=0 periods:** Q is flat (no changes)
2. **T=1 periods:** Q toggles creating square wave
3. **Perfect symmetry:** High time = Low time (50% duty cycle)
4. **Frequency division:** Q period = 2 × Clock period

**Key observation:** During the "Frequency Division Test" section, Q creates a perfect square wave at exactly half the clock frequency!

## Comparison with Previous Flip-Flops

### D Flip-Flop (Project 8)
- **Purpose:** Store data bit
- **Modes:** 1 (copy D)
- **Toggle:** Requires external NOT gate feedback

### JK Flip-Flop (Project 9)
- **Purpose:** Versatile state control
- **Modes:** 4 (hold/set/reset/toggle)
- **Toggle:** Available when J=K=1

### T Flip-Flop (Project 10)
- **Purpose:** Toggle/divide frequency
- **Modes:** 2 (hold/toggle)
- **Toggle:** Primary function, always available

**Design principle:** Use the simplest flip-flop that meets your needs!

## Mathematical Analysis

### Frequency Division Ratio

For n T flip-flops in cascade:
```
Output Frequency = Input Frequency / 2ⁿ
```

Examples:
- 1 T-FF: ÷2¹ = ÷2
- 2 T-FFs: ÷2² = ÷4
- 3 T-FFs: ÷2³ = ÷8
- 4 T-FFs: ÷2⁴ = ÷16

### Maximum Count

For n T flip-flops:
```
Maximum Count = 2ⁿ - 1
```

Examples:
- 4 T-FFs: 2⁴ = 16 states (0-15)
- 8 T-FFs: 2⁸ = 256 states (0-255)

## Results
✅ Hold mode verified (T=0)  
✅ Toggle mode verified (T=1)  
✅ Frequency division by 2 confirmed  
✅ Perfect square wave generation  
✅ Ready for use in counters (next project!)

---

**🎊 33% COMPLETE! One-third of 30-day challenge finished!**

Foundation for Project 12 (4-bit Counter) and beyond.

**Part of 30-day Verilog learning journey**
