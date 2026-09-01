import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_seq_item extends uvm_sequence_item;

    rand bit rst;
    rand bit en;

    logic [3:0] cout;

    `uvm_object_utils(counter_seq_item)

    function new (string name = "counter_seq_item");
        super.new(name);
    endfunction

endclass