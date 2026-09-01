class counter_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(counter_scoreboard)

    uvm_analysis_imp #(counter_seq_item, counter_scoreboard) analysis_export;
    logic [3:0] expected_count;

    function new(string name = "counter_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        expected_count = 4'd0; // Hardware naturally resets to 0
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        analysis_export = new("analysis_export", this);
    endfunction

    function void write(counter_seq_item item);
        
        // 1. COMPARE FIRST: Check the current hardware value against the expected state
        if (item.cout !== expected_count) begin
            $display("[COUNTER_SCB FAIL] rst=%0b, en=%0b, expected=%0d, actual=%0d", 
                     item.rst, item.en, expected_count, item.cout);
        end
        else begin
            $display("[COUNTER_SCB PASS] rst=%0b, en=%0b, cout=%0d", 
                     item.rst, item.en, item.cout);
        end

        // 2. PREDICT NEXT STATE: Compute the value expected on the NEXT clock edge
        if (item.rst) begin
            expected_count = 4'd0;
        end
        else if (item.en) begin
            expected_count = expected_count + 4'd1;
        end
        else begin
            expected_count = expected_count - 4'd1;
        end

    endfunction

endclass
