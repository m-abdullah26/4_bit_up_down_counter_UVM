`timescale 1ns/1ps

module dut_tb();

logic clk;
logic rst;
logic en;
logic [3:0] cout;

counter DUT (.*);

// Continuous clock generation (Toggles every 5ns -> 10ns period)
always #5 clk = ~clk;

initial begin
    // 1. Initialize clock and control signals at time 0
    clk = 0;
    rst = 1;
    en = 1;

    // 2. Hold reset for 15ns to clearly see the synchronous reset clear the output
    #15;
    
    // 3. Release reset, keep enable high to count UP
    rst = 0;
    en = 1;

    // 4. Let it count up for 50ns (5 clock cycles)
    #50;

    // 5. Change enable to 0 to count DOWN
    en = 0;

    // 6. Let it count down for 50ns (5 clock cycles) so you can see it in the wave window
    #50;

    // Conclude simulation safely
    $display("Simulation finished successfully.");
    $stop;
end

endmodule