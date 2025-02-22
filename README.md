# Traffic Light Control System - CO221 Assignment

## Overview
This project implements a **Traffic Light Control System** for a four-way junction using **combinational logic circuits**. The system ensures smooth traffic flow while adhering to pedestrian safety guidelines and traffic rules.

## Features
- Designed using **Boolean logic expressions**.
- Controls traffic flow for **four lanes** with pedestrian crossings.
- Includes **priority management** for traffic lanes.
- Simulated using **Proteus 8** and verified with **Verilog testbenches**.
- Optimized with **K-Map reduction** for efficient logic design.

## System Design
### 1. Lane Configuration
- Each lane consists of six tracks, three for each direction.
- Separate signals for:
  - **Pedestrian Crossing (P)**
  - **Left Turn (L)**
  - **Right Turn (R)**
  - **Forward Movement (F)**

### 2. Safety and Priority
- Only one pedestrian crossing (or two opposite-direction crossings) active at a time.
- Adjacent pedestrian crossings are prohibited.
- **Left lane vehicles** get priority in case of conflicts.

## Implementation
- **Boolean expressions** define signal logic.
- **Proteus 8 Simulation** for circuit validation.
- **Verilog code** for hardware implementation.
- **Testbench** for functional verification.

## Verification
- **Python script** for permutation-based testing.
- **Manual truth table validation** for accuracy.
- **Simulation tests** in **Proteus 8**.

## Files in This Repository
- `traffic_light.sv` - Verilog code for traffic light logic.
- `testbench.sv` - Testbench for Verilog simulation.
- `simulation.pdsprj` - Proteus project file for circuit validation.
- `Report.pdf` - Full documentation including design, logic, and verification.

## How to Run
1. Open the Verilog files in a simulator like **ModelSim** or **Vivado**.
2. Run the **testbench** to verify logic.
3. Open the **Proteus project** and simulate the circuit.
4. Check `Report.pdf` for detailed analysis.
---

### Contact
For any queries, feel free to contact us.
