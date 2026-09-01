`timescale 1ns/1ps

`include "uvm_macros.svh"

module tb_top;
    import uvm_pkg::*;
    import counter_pkg::*; // Imports all your verification components

    logic clk;

    // 1. Separate clock initialization and clock generation blocks cleanly
    initial begin
        clk = 0;
    end
    
    always #5 clk = ~clk;

    // Interface instantiation
    counter_if vif(clk);

    // DUT instantiation
    counter dut (
        .clk(vif.clk), 
        .rst(vif.rst), 
        .en(vif.en), 
        .cout(vif.cout)
    );

    initial begin
        // Set virtual interface reference in config_db
        uvm_config_db#(virtual counter_if)::set(null, "*", "vif", vif);

        // 2. Fixed: Enclosed the test name inside double quotes as a string literal
        run_test("counter_test");
    end

endmodule
