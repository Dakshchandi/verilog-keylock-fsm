# 🔐 Verilog Keylock FSM

A Verilog-based digital keypad lock system implemented using a **Finite State Machine (FSM)**. This project authenticates a predefined password entered through a keypad, unlocks the system upon successful verification, tracks failed password attempts, and temporarily locks the keypad after three consecutive incorrect attempts. A timer-based lockout mechanism and a comprehensive testbench are included to verify the functionality through simulation.

---

## 📌 Features

### Password Authentication

- Predefined password verification
- Sequential key validation using a Finite State Machine (FSM)
- Unlocks only after the **ENTER** key is pressed
- Generates an **unlock pulse** upon successful authentication

### Security Features

- Tracks consecutive incorrect password attempts
- Automatically locks the keypad after **3 failed attempts**
- Ignores keypad inputs while locked
- Automatically unlocks after the lock timer expires
- Resets the failed-attempt counter after a successful unlock

### Verification

- Complete Verilog testbench
- Functional simulation using Xilinx Vivado Simulator
- Waveform verification of all major features

---

## ⚙️ Module Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| `clk` | 1 | System clock |
| `reset` | 1 | Asynchronous reset |
| `key_valid` | 1 | Indicates a valid keypad input |
| `ENTER` | 1 | Confirms password entry |
| `key` | 4 | Current keypad digit |

---

## 📤 Module Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| `unlock` | 1 | High for one clock cycle after a correct password |
| `locked` | 1 | Indicates the keypad is locked after multiple failed attempts |

---

## 🔐 Password Sequence

The predefined password is:

```text
3 → 8 → 2 → 9 → ENTER
```

Only this sequence successfully unlocks the system.

---

## 🔄 Finite State Machine

| State | Description |
|--------|-------------|
| **S0** | Idle state, waiting for the first digit |
| **S1** | First digit (3) matched |
| **S2** | Second digit (8) matched |
| **S3** | Third digit (2) matched |
| **S4** | Fourth digit (9) matched, waiting for ENTER |
| **S5** | Unlock state |

Any incorrect key resets the FSM back to the idle state.

---

## 🚀 How It Works

1. The FSM waits for keypad input.
2. Each entered digit is checked against the stored password.
3. If the sequence `3 → 8 → 2 → 9` is entered correctly, the system waits for the **ENTER** signal.
4. Pressing **ENTER** generates an **unlock pulse**.
5. Any incorrect key resets the FSM and increments the failed-attempt counter.
6. After **three consecutive incorrect attempts**, the keypad enters a locked state.
7. During the lock period, all keypad inputs are ignored.
8. When the timer expires, the keypad automatically unlocks and the failed-attempt counter is reset.

---

## 🧪 Testbench

The included testbench verifies the following scenarios:

- ✅ Correct password entry
- ✅ Unlock signal generation
- ✅ Incorrect password handling
- ✅ Failed-attempt counter operation
- ✅ Automatic keypad lock after three failed attempts
- ✅ Automatic unlock after the timer expires

---
## 📷 Simulation

The design was simulated using **Xilinx Vivado Simulator**. The simulation files and waveform screenshots are included in the **`keylock sim`** folder.

### Simulation Waveform

![Simulation Waveform](keylock%20sim/simulation.png)

---

## 🛠️ Tools Used

- Verilog HDL
- Xilinx Vivado
- Vivado Simulator
- Finite State Machine (FSM)

---

## 📚 Concepts Demonstrated

- Finite State Machine (FSM) Design
- Sequential Logic Design
- Combinational Logic Design
- Password Authentication
- Digital Security Concepts
- Timer-Based Control Logic
- Verilog HDL Coding
- Testbench Development
- Functional Simulation

---

## 🎯 Applications

- FPGA-Based Digital Door Locks
- Password Authentication Systems
- Embedded Security Systems
- Digital Electronics Projects
- Verilog HDL Learning
- FSM Design Practice

---

## 🚀 Future Improvements

- Configurable password storage
- Matrix keypad interface
- Keypad debouncing
- Seven-segment display integration
- LCD/OLED display support
- Alarm or buzzer after repeated failed attempts
- Configurable lock timeout
- FPGA hardware implementation

---

## 🤝 Contributing

Contributions, improvements, and suggestions are welcome.

1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Push the branch.
5. Open a Pull Request.

---

## 📄 License

This project is licensed under the **MIT License**.

---

## ⭐ Support

If you found this project useful or learned something from it, consider giving the repository a **⭐ Star**.
