
## 📌 Project Overview
This project implements a **Digital Locker System** using **Verilog HDL**, designed around a **Finite State Machine (FSM)**.  
The locker unlocks only when the correct **serial password sequence `1100`** is entered. After successful authentication, the system enters an **UNLOCK** state and remains unlocked until the **submit** signal is asserted.

This project demonstrates core RTL design concepts such as FSM modeling, serial data handling, and simulation-based verification.

---

## 🧠 Design Concept
- **FSM Type**: Moore Machine  
- **Password Entry**: Serial (1 bit per clock cycle)  
- **Valid Password**: `1100`  
- **Reset Type**: Asynchronous, active-high  

---
## Block Diagram
![WhatsApp Image 2026-01-11 at 3 26 55 PM](https://github.com/user-attachments/assets/8af1e9d4-67de-493a-99cb-f2a32d999ec7)


## 🔧 Module Interface

### Inputs
| Signal | Width | Description |
|------|------|-------------|
| `clk` | 1 | System clock |
| `rst` | 1 | Asynchronous reset |
| `pwd_in` | 1 | Serial password input |
| `submit` | 1 | Reset / confirm signal |

### Outputs
| Signal | Width | Description |
|-------|------|-------------|
| `locked` | 1 | Indicates locker is locked |
| `unlocked` | 1 | Indicates locker is unlocked |

---
## 🧩 FSM 

![WhatsApp Image 2026-01-11 at 3 57 20 PM](https://github.com/user-attachments/assets/b1e0c9e9-f3ad-4e7f-a874-3a9b42a08521)


## 🧩 FSM States
| State | Description |
|------|-------------|
| `IDLE` | Waiting for first password bit |
| `S1` | First bit correct (`1`) |
| `S2` | Second bit correct (`1`) |
| `S3` | Third bit correct (`0`) |
| `UNLOCK` | Password verified successfully |
| `ERROR` | Incorrect password entered |

---

## 🔁 State Transition Flow

- Any incorrect bit moves the FSM to the `ERROR` state
- Asserting `submit` resets the system back to `IDLE`

---

## ⏱️ Working Sequence

1. Apply reset (`rst = 1`)
2. Deassert reset (`rst = 0`)
3. Enter the password bits serially:
4. FSM transitions to `UNLOCK`
5. Outputs become:
- `locked = 0`
- `unlocked = 1`
6. Assert `submit` to lock the system again

---

## 📈 Simulation & Verification

- Verified using **ModelSim / Icarus Verilog**
- Waveforms observed in **GTKWave**
- Confirmed correct FSM transitions and output behavior
- `unlocked` remains HIGH only while FSM stays in `UNLOCK` state

---

## ⚠️ Important Note

If `submit` is asserted while in the `UNLOCK` state, the FSM immediately transitions back to `IDLE`.  
This causes `unlocked` to go HIGH for only one clock cycle, which is **expected FSM behavior**.

---

## 🛠️ Tools Used

- **HDL**: Verilog 
- **Simulator**: Vivado
- **Waveform Viewer**: GTKWave
- **OS**: Linux

---

## 📂 Project Structure

digital_locker/

│
├── digital_locker.v # RTL design

├── tb_digital_locker.v # Testbench

├── waveform.png # Simulation waveform

└── README.md # Project documentation


---



## 👨‍💻 Author

**Ravindra Sidda**  
RTL Design & Verification Enthusiast  
Verilog | FSM | Digital Design

---

## ⭐ Acknowledgement
This project was developed to strengthen understanding of FSM-based digital system design using Verilog.

