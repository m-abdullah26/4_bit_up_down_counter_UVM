4-BIT UP/DOWN COUNTER - UVM VERIFICATION
=============================================

PROJECT OVERVIEW
----------------
A SystemVerilog UVM-based verification environment for a synchronous
4-bit up/down counter. The project verifies reset, up-counting,
down-counting, direction switching, overflow/underflow wrap-around,
corner cases, and functional coverage.


DUT FUNCTIONALITY
-----------------
The counter is controlled by reset (rst) and enable/direction (en):

    rst = 1              -> Counter resets to 0
    rst = 0, en = 1      -> Counter increments
    rst = 0, en = 0      -> Counter decrements

Because the counter is 4 bits wide:

    15 + 1 = 0           -> Up-count wrap-around
    0  - 1 = 15          -> Down-count wrap-around


UVM TESTBENCH ARCHITECTURE
--------------------------
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


TRANSACTION FLOW
----------------
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


PROJECT STRUCTURE
-----------------
4_bit_up_down_counter_UVM/
|
+-- rtl/
|   +-- dut.sv
|
+-- uvm/
|   +-- inf_counter.sv
|   +-- counter_pkg.sv
|   +-- counter_seq_item.sv
|   +-- counter_sequence.sv
|   +-- counter_sequencer.sv
|   +-- counter_driver.sv
|   +-- counter_monitor.sv
|   +-- counter_coverage.sv
|   +-- counter_scoreboard.sv
|   +-- counter_agent.sv
|   +-- counter_env.sv
|   +-- counter_test.sv
|
+-- tb/
|   +-- tb_top.sv
|


VERIFICATION TESTS
------------------
counter_test
    Random counter stimulus

counter_up_test
    Verifies up-counting operation

counter_down_test
    Verifies down-counting operation

counter_reset_test
    Verifies reset behavior

counter_up_wrap_test
    Verifies 15 -> 0 overflow

counter_down_wrap_test
    Verifies 0 -> 15 underflow

counter_reset_during_count_test
    Verifies reset during active counting

counter_up_down_test
    Verifies switching between up and down modes

counter_corner_test
    Verifies boundary and corner cases

counter_all_test
    Runs all verification sequences as a combined regression


SCOREBOARD
----------
The scoreboard implements a reference model of the counter and compares
the expected state against the output sampled by the monitor.

Reset:
    rst = 1 -> cout = 0

Up counting:
    rst = 0, en = 1 -> cout increments

Down counting:
    rst = 0, en = 0 -> cout decrements

The 4-bit width naturally provides modulo-16 behavior:

    15 + 1 = 0
    0  - 1 = 15


FUNCTIONAL COVERAGE
-------------------
The coverage model monitors input and output behavior.

Input Coverage:
    rst = 0
    rst = 1
    en  = 0
    en  = 1

Output Coverage:
    All 4-bit counter values from 0 through 15

Cross Coverage:
    rst x en
    en  x cout

The coverage model helps determine whether the verification stimulus
actually exercised the intended functional scenarios.


CLOCKING BLOCKS
---------------
Separate driver and monitor clocking blocks are used to provide
controlled synchronization between the testbench and DUT.

Driver clocking block:

    clocking driver_cb @(posedge clk);
        default output #1ns;
        output rst;
        output en;
    endclocking

Monitor clocking block:

    clocking monitor_cb @(posedge clk);
        default input #1ns;
        input rst;
        input en;
        input cout;
    endclocking

The driver uses clocking-block output assignments:

    vif.driver_cb.rst <= req.rst;
    vif.driver_cb.en  <= req.en;

The monitor samples through:

    @(vif.monitor_cb);

This helps avoid race conditions between the testbench and DUT.


RUNNING THE SIMULATION
----------------------

The script file performs the following:

    1. Cleans/creates the work library
    2. Compiles the DUT
    3. Compiles the interface
    4. Compiles the UVM package
    5. Compiles the testbench top
    6. Starts the simulation
    7. Runs counter_all_test
    8. Displays the simulation results and waveform


RUNNING A SPECIFIC TEST
-----------------------
A specific test can be selected using +UVM_TESTNAME.

+UVM_TESTNAME=counter_up_test

Other examples:

    +UVM_TESTNAME=counter_down_test
    +UVM_TESTNAME=counter_reset_test
    +UVM_TESTNAME=counter_up_wrap_test
    +UVM_TESTNAME=counter_down_wrap_test
    +UVM_TESTNAME=counter_corner_test
    +UVM_TESTNAME=counter_all_test


EXPECTED RESULTS
----------------
A successful simulation should report:

    UVM_ERROR   : 0
    UVM_FATAL   : 0

The scoreboard reports PASS/FAIL transaction checks.

The functional coverage component reports the achieved coverage
percentage during report_phase.

AUTHOR
------
M. Abdullah

Digital IC Design Verification
SystemVerilog | UVM | RTL Verification 
