class counter_monitor extends uvm_monitor;

    `uvm_component_utils(counter_monitor)

    virtual counter_if vif;
    uvm_analysis_port #(counter_seq_item) analysis_port;

    function new(string name = "counter_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        analysis_port = new("analysis_port", this);
        
        if(!uvm_config_db#(virtual counter_if)::get(this, "", "vif", vif)) begin
            $display("[NOVIF] Virtual interface reference not found in monitor");
        end
    endfunction

    task run_phase(uvm_phase phase);
        counter_seq_item item;

        forever begin
            // 1. Synchronize to the clocking block edge instead of raw clk
            @(vif.monitor_cb);

            // 2. Filter out initial uninitialized 'X' values
            if ($isunknown(vif.monitor_cb.cout)) begin
                continue; 
            end

            item = counter_seq_item::type_id::create("item");

            // 3. Sample values safely from the clocking block
            item.rst  = vif.monitor_cb.rst;
            item.en   = vif.monitor_cb.en;
            item.cout = vif.monitor_cb.cout;

            analysis_port.write(item);
        end
    endtask

endclass
