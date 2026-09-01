`timescale 1ns/1ps 
module counter( 
    input logic clk, 
    input logic rst, 
    input logic en, 
    output logic [3:0] cout); 

always_ff @(posedge clk) 
begin 
    if(rst) 
    cout <= 4'b0000; 
    else 
        if(en) 
            cout <= cout +1; 
        else 
            cout <= cout-1; 
end 
endmodule