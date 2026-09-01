# 4-Bit Up/Down Counter — UVM Verification

A SystemVerilog **UVM-based verification environment** for a synchronous 4-bit up/down counter. The project verifies reset, up/down counting, direction switching, overflow/underflow wrap-around, corner cases, and functional coverage using **QuestaSim**.

## 📌 Project Overview

The DUT is controlled by reset (`rst`) and enable/direction (`en`):

| Condition | Operation |
|---|---|
| `rst = 1` | Counter resets to `0` |
| `rst = 0, en = 1` | Counter increments |
| `rst = 0, en = 0` | Counter decrements |
| `15 + 1` | Wraps to `0` |
| `0 - 1` | Wraps to `15` |

## 🧩 DUT

```systemverilog
module counter(
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    output logic [3:0] cout
);

    always_ff @(posedge clk) begin
        if (rst)
            cout <= 4'b0000;
        else if (en)
            cout <= cout + 1;
        else
            cout <= cout - 1;
    end

endmodule
```

## 🏗️ UVM Testbench Architecture

```text
tb_top
  |
  +-- DUT
  |
  +-- counter_if
  |
  +-- counter_all_test
          |
          +-- counter_env
                  |
                  +-- counter_agent
                  |       |
                  |       +-- sequencer
                  |       +-- driver
                  |       +-- monitor
                  |
                  +-- scoreboard
                  |
                  +-- coverage
```

### Transaction Flow

```text
Sequence
   |
   v
Sequencer
   |
   v
Driver
   |
   v
DUT
   |
   v
Monitor
   |
   +-----------> Scoreboard
   |
   +-----------> Functional Coverage
```

## 📁 Project Structure

```text
4_bit_up_down_counter_UVM/
│
├── rtl/
│   └── dut.sv
│
├── uvm/
│   ├── inf_counter.sv
│   ├── counter_pkg.sv
│   ├── counter_seq_item.sv
│   ├── counter_sequence.sv
│   ├── counter_sequencer.sv
│   ├── counter_driver.sv
│   ├── counter_monitor.sv
│   ├── counter_coverage.sv
│   ├── counter_scoreboard.sv
│   ├── counter_agent.sv
│   ├── counter_env.sv
│   ├── counter_test.sv
│   ├── counter_up_test.sv
│   ├── counter_down_test.sv
│   ├── counter_reset_test.sv
│   ├── counter_up_wrap_test.sv
│   ├── counter_down_wrap_test.sv
│   ├── counter_reset_during_count_test.sv
│   ├── counter_up_down_test.sv
│   ├── counter_corner_test.sv
│   └── counter_all_test.sv
│
├── tb/
│   └── tb_top.sv
│
└── run.do
```

## 🧪 Verification Tests

| Test | Verification Scenario |
|---|---|
| `counter_test` | Random counter stimulus |
| `counter_up_test` | Up-counting operation |
| `counter_down_test` | Down-counting operation |
| `counter_reset_test` | Reset behavior |
| `counter_up_wrap_test` | `15 → 0` overflow |
| `counter_down_wrap_test` | `0 → 15` underflow |
| `counter_reset_during_count_test` | Reset during active counting |
| `counter_up_down_test` | Direction switching |
| `counter_corner_test` | Boundary and corner cases |
| `counter_all_test` | Runs all verification sequences |

## 🔍 Scoreboard

The scoreboard implements a reference model of the counter and compares the expected state against the output sampled by the monitor.

### Reset

```text
rst = 1 → cout = 0
```

### Up Counting

```text
rst = 0, en = 1 → cout increments
```

### Down Counting

```text
rst = 0, en = 0 → cout decrements
```

The 4-bit width naturally provides modulo-16 behavior:

```text
15 + 1 = 0
0  - 1 = 15
```

## 📊 Functional Coverage

The coverage model monitors both inputs and outputs.

### Input Coverage

- `rst = 0`
- `rst = 1`
- `en = 0`
- `en = 1`

### Output Coverage

All 4-bit counter values from `0` through `15`.

### Cross Coverage

- `rst × en`
- `en × cout`

This helps determine whether the verification stimulus actually exercised the intended functional scenarios.

## ⏱️ Clocking Blocks

Separate driver and monitor clocking blocks provide controlled synchronization between the testbench and DUT.

```systemverilog
clocking monitor_cb @(posedge clk);
    default input #1ns;
    input rst;
    input en;
    input cout;
endclocking

clocking driver_cb @(posedge clk);
    default output #1ns;
    output rst;
    output en;
endclocking
```

The driver uses clocking-block output assignments:

```systemverilog
vif.driver_cb.rst <= req.rst;
vif.driver_cb.en  <= req.en;
```

The monitor samples through:

```systemverilog
@(vif.monitor_cb);
```

This helps avoid race conditions between the testbench and DUT.

## ▶️ Running the Simulation

Open QuestaSim in the project directory and execute:

```tcl
do run.do
```

The `run.do` script:

1. Cleans/creates the `work` library
2. Compiles the DUT
3. Compiles the interface
4. Compiles the UVM package
5. Compiles the testbench top
6. Starts the simulation
7. Runs `counter_all_test`
8. Displays simulation results and waveforms

### Run a Specific Test

```tcl
vsim -voptargs=+acc work.tb_top +UVM_TESTNAME=counter_up_test
```

Other tests can be selected with:

```text
+UVM_TESTNAME=counter_down_test
+UVM_TESTNAME=counter_reset_test
+UVM_TESTNAME=counter_up_wrap_test
+UVM_TESTNAME=counter_down_wrap_test
+UVM_TESTNAME=counter_corner_test
+UVM_TESTNAME=counter_all_test
```

## 📈 Expected Results

A successful simulation should report:

```text
UVM_ERROR   : 0
UVM_FATAL   : 0
```

The scoreboard reports transaction-level PASS/FAIL results, while the coverage component reports functional coverage during `report_phase()`.

Example:

```text
==============================================
          FUNCTIONAL COVERAGE REPORT
==============================================

INPUT COVERAGE        = XX.XX%
OUTPUT COVERAGE       = XX.XX%
INPUT/OUTPUT COVERAGE = XX.XX%

==============================================
```

Replace the example values with actual measured coverage before publishing results.

## 🛠️ Tools & Technologies

- SystemVerilog
- UVM 1.1d
- QuestaSim 2024.1
- RTL Simulation
- UVM Testbench Architecture
- Functional Coverage
- Constrained/Random Verification
- Directed Testing
- Scoreboard-Based Checking
- SystemVerilog Clocking Blocks

## 🎯 Key Verification Features

- Reusable UVM sequence items
- Directed and random stimulus
- UVM sequencer-driver communication
- Virtual interface
- Clocking-block-based synchronization
- Active UVM agent
- Transaction-level monitoring
- Reference-model scoreboard
- Reset verification
- Up/down counting verification
- Overflow and underflow verification
- Direction switching
- Corner-case testing
- Functional input/output coverage
- Combined regression test

## 🚀 Future Improvements

- Add transition coverage for `15 → 0` and `0 → 15`
- Add SystemVerilog Assertions (SVA)
- Add Questa code coverage
- Add coverage-driven constrained-random testing
- Add virtual sequences
- Add automated regression reporting
- Improve functional coverage closure

## 👨‍💻 Author

**Abdullah**

Digital Design & Verification

SystemVerilog • UVM • RTL Verification • QuestaSim
