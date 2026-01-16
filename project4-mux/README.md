# Project 4: 2-to-1 Multiplexer

**Completed:** January 16, 2026

## Overview
A 2-to-1 multiplexer (MUX) that selects between two input signals based on a select control signal. This is a fundamental digital circuit used for data routing and selection.

## What is a Multiplexer?

A multiplexer acts as a digital switch, routing one of several inputs to a single output. Think of it like a railroad switch that directs trains (data) to different tracks.

**2-to-1 MUX Logic:**
- When `sel = 0` → output = input 0
- When `sel = 1` → output = input 1

## Components

### 2-to-1 Multiplexer
- **Inputs:** i0, i1 (data inputs), sel (select signal)
- **Output:** y
- **Implementation:** Uses ternary operator `sel ? i1 : i0`

## Truth Table
<img width="1250" height="781" alt="waveform" src="https://github.com/user-attachments/assets/dc72f860-5ec3-4ce9-95a0-da448734c6cf" />
<img width="940" height="626" alt="cmd" src="https://github.com/user-attachments/assets/26324e9a-8320-40d4-be49-dc19b41e2cf1" />
