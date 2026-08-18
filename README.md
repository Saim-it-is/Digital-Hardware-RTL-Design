# Synthesizable Digital Hardware & RTL Designs

This repository contains synthesizable Verilog HDL modules, finite state machines (FSMs), sequential logic, clock management blocks, and verification testbenches developed and simulated using **Intel Quartus Prime Lite** and HDL simulation tools.

---

## 📂 Repository Structure

### 1. `Arithmetic and Basic Logic/`
* **Subtractor Architectures:** Synthesizable Half Subtractor and Full Subtractor built via structural half-subtractor instantiation.
* **Control Units:** Behavioral modeling blocks and a smart battery management logic controller.

### 2. `Clock Management Units/`
* **Clock Division:** Synthesizable even, odd, and fractional clock division units.
* **Clock Management Unit (CMU):** Top-level CMU integrating internal division logic.
* **Interface Generation:** SPI clock generation and subsystem verification testbenches.

### 3. `Structured RTL and Protocol/`
* **Bus & Switching Logic:** Sequential arbiter switch with self-checking testbench.
* **Protocol & Buffers:** SPI buffer modules and top-level subsystem interfacing.
* **Serialization & Packet Handling:** Packet serializer and telemetry unpacker modules with automated testbenches.
* **Timers:** 3-bit synchronous countdown timer logic.

### 4. `FSM_vending machine/`
* **Finite State Machine:** Synthesizable multi-state vending machine controller.
* **Verification:** Dedicated testbench verifying state transitions, coin acceptance, and dispensing logic.

---

## 🛠️ Toolchain & Environment
* **Hardware Description Language:** Verilog HDL (IEEE 1364 Synthesizable RTL)
* **EDA & Synthesis:** Intel Quartus Prime Lite Edition
* **Simulation & Verification:** ModelSim / QuestaSim / NativeLink testbench simulation

---

## 👨‍💻 Author
**Saim Imran** — Electronic Engineering Undergraduate  
*Focus: Digital IC Design, Synthesizable RTL & FPGA Systems*
