`timescale 1ns/1ps

interface counter_if(input logic clk);
    logic rst;
    logic en;
    logic [3:0] cout;

    // Monitor Clocking Block (For safe sampling)
    clocking monitor_cb @(posedge clk);
        default input #1ns;
        input rst;
        input en;
        input cout;
    endclocking

    // Driver Clocking Block (Fixed: Added output skew to prevent race conditions)
    clocking driver_cb @(posedge clk);
        default output #1ns;
        output rst;
        output en;
    endclocking

endinterface
