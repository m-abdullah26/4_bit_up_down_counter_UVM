class counter_driver extends uvm_driver #(counter_seq_item);

    `uvm_component_utils(counter_driver)

    virtual counter_if vif;

    function new(string name = "counter_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual counter_if)::get(this, "", "vif", vif)) begin
            $display("[NOVIF] Virtual interface reference not found in driver");
        end
    endfunction

    task run_phase(uvm_phase phase);
        counter_seq_item req;

        forever begin
            seq_item_port.get_next_item(req);

            // Wait for the synchronous driver clocking block edge
            @(vif.driver_cb);

            // Fixed: Drive signals through the clocking block using normal blocking '='
            vif.driver_cb.rst <= req.rst;
            vif.driver_cb.en  <= req.en;

            seq_item_port.item_done();
        end
    endtask

endclass
