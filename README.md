# 4_bit_up_down_counter_UVM
Designed and verified a 4-bit up/down counter using UVM, featuring reusable sequences, sequencer, driver, monitor, scoreboard, functional coverage, reset testing, direction switching, and boundary wrap-around verification. Built and simulated in QuestaSim with structured UVM methodology.
A complete SystemVerilog UVM verification environment for a 4-bit synchronous up/down counter. The project demonstrates a structured UVM testbench with reusable sequences, constrained/random stimulus, functional checking, corner-case verification, and functional coverage.

📌 Project Overview

The DUT is a 4-bit up/down counter controlled by reset and enable signals:

rst = 1 → Counter resets to 0
rst = 0, en = 1 → Counter increments
rst = 0, en = 0 → Counter decrements
4-bit overflow: 15 → 0
4-bit underflow: 0 → 15

The verification environment uses UVM 1.1d/QuestaSim and includes a scoreboard for functional checking and coverage collection for measuring verification completeness.

🧩 DUT
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
🏗️ UVM Testbench Architecture
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
Transaction Flow
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
📁 Project Structure
uvm_project/
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
🧪 Verification Tests

The project contains dedicated tests for different functional scenarios:

Test	Purpose
counter_test	Random counter stimulus
counter_up_test	Up-counting operation
counter_down_test	Down-counting operation
counter_reset_test	Reset behavior
counter_up_wrap_test	15 → 0 overflow
counter_down_wrap_test	0 → 15 underflow
counter_reset_during_count_test	Reset during active counting
counter_up_down_test	Switching between up/down modes
counter_corner_test	Boundary and wrap-around cases
counter_all_test	Executes all verification sequences
🔍 Scoreboard

The scoreboard maintains a reference model of the counter and compares the expected state against the monitored DUT output.

It verifies:

Reset:
rst = 1 → cout = 0

Up:
rst = 0, en = 1 → cout + 1

Down:
rst = 0, en = 0 → cout - 1

The 4-bit width naturally provides modulo-16 behavior:

15 + 1 = 0
0  - 1 = 15
📊 Functional Coverage

The coverage model monitors:

Input Coverage
rst = 0
rst = 1

en = 0
en = 1
Output Coverage

All 4-bit counter values:

0 through 15
Cross Coverage

The environment also measures combinations such as:

rst × en
en × cout

This helps determine whether the verification tests actually exercised the intended functional scenarios rather than simply completing without errors.

⏱️ Clocking Blocks

The interface uses separate clocking blocks for the driver and monitor to avoid race conditions between the DUT and testbench.

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

The driver uses clocking-block output assignments:

vif.driver_cb.rst <= req.rst;
vif.driver_cb.en  <= req.en;

The monitor samples through:

@(vif.monitor_cb);

This provides controlled testbench/DUT synchronization.
