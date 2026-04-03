# FPGA Rolling Average Compute Unit

## 💻 Overview
A sophisticated digital signal processing (DSP) ecosystem designed for real-time numeric analysis on FPGA hardware. Built with **VHDL**, this application orchestrates a dynamic filtering pipeline that calculates the rolling average of incoming data streams. Beyond simple summation, the system features a **modular signal generator** (LFSR & Square Wave) and a programmable filtering engine that optimizes hardware resources through power-of-two bit-shifting arithmetic.

---

## 🤍 Tech Stack
* **Hardware Language:** **VHDL-93** (Modular Design)
* **Target Device:** Xilinx Spartan-3 **XC3S200** FPGA
* **Simulation & Synthesis:** ModelSim, **Xilinx ISE WebPack 6.3**
* **Architecture:** Finite State Machines (FSM) & Structural RTL

![VHDL](https://img.shields.io/badge/VHDL-93-%23FF69B4.svg?style=for-the-badge&logo=vhdl&logoColor=white) ![Xilinx](https://img.shields.io/badge/Xilinx-ISE-%23FFB6C1.svg?style=for-the-badge&logo=xilinx&logoColor=black)

![Digital Signal Processing](https://img.shields.io/badge/DSP-Filtering-%234F4F4F.svg?style=for-the-badge&logo=cpu&logoColor=white) ![FPGA](https://img.shields.io/badge/Hardware-Spartan--3-%234F4F4F.svg?style=for-the-badge&logo=microchip&logoColor=white) ![RTL](https://img.shields.io/badge/RTL-Design-%234F4F4F.svg?style=for-the-badge&logo=diagrams.net&logoColor=white)

---

## 🎀 Core Functionality
* **Dynamic Data Orchestration:** Features an integrated generator capable of producing 0.25 Hz square waves and 4/8/9-bit **Linear Feedback Shift Register (LFSR)** sequences for pseudo-random data streams.
* **Adaptive Rolling Filter:** * **Programmable Window:** Selectable average lengths ($L = 2, 4, 8, 16$) via hardware switches.
    * **Resource Optimization:** Implements "Running Total" logic to minimize gate delay, using bit-shifting for division.
* **Real-time Visualization:** Synchronized output delivery to the 7-segment display unit, featuring a dedicated refresh controller for the Spartan-3 multiplexed display.
* **Control Intelligence:** Hardware-level debounce logic for buttons and synchronous reset state management.

---

## 📂 Project Structure
The architecture follows a strictly hierarchical RTL approach:
* **`top_level.vhd`**: The master orchestrator connecting the generator, filter, and display modules.
* **`data_generator.vhd`**: Logic for PRBS (Pseudo-Random Binary Sequence) and square wave synthesis.
* **`rolling_average.vhd`**: The core compute engine utilizing a shift-register buffer and accumulator.
* **`display_driver.vhd`**: Multiplexing logic for the 4-digit 7-segment display.
* **`constraints.ucf`**: Physical pin mapping for the Digilent S3 board (Switches, Buttons, Clock).

---

## Getting Started

Follow these steps to synthesize the project and deploy it to the FPGA:

```bash
# Clone the repository
git clone [https://github.com/patrrrrrrricia/vhdl-rolling-average-filter.git](https://github.com/patrrrrrrricia/vhdl-rolling-average-filter.git)
cd vhdl-rolling-average-filter

# 1. Open Xilinx ISE WebPack
# 2. Create a new project targeting XC3S200 (FT256 Package)
# 3. Add all .vhd files from the source directory

# Run Functional Simulation
# Using ModelSim to verify the rolling average logic
vsim work.testbench_rolling_average

# Synthesize and Implement
# Run 'Generate Programming File' to create the .bit file

# Deploy to Hardware
# Use Digilent ExPort or Adept to load the bitstream onto the S3 Board
```
© 2025 Glitter Geeks Coderun | Developed by [**𝐌𝐨𝐥𝐝𝐨𝐯𝐚𝐧 𝐈𝐮𝐥𝐢𝐚𝐧𝐚**](https://github.com/iulianamoldovan), [**𝐋𝐞𝐨𝐧𝐭𝐞 𝐏𝐚𝐭𝐫𝐢𝐜𝐢𝐚-𝐌𝐢𝐫𝐚𝐛𝐞𝐥𝐚**](https://github.com/patrrrrrrricia)
