class counter_coverage extends uvm_subscriber #(counter_seq_item);

    `uvm_component_utils(counter_coverage)

    counter_seq_item item;

    //========================================================
    // INPUT COVERAGE
    //========================================================

    covergroup input_cg;

        // Reset input
        cp_rst: coverpoint item.rst {
            bins reset_active   = {1};
            bins reset_inactive = {0};
        }

        // Enable / direction input
        cp_en: coverpoint item.en {
            bins down_count = {0};
            bins up_count   = {1};
        }

        // Reset x Enable
        rst_en_cross: cross cp_rst, cp_en;

    endgroup


    //========================================================
    // OUTPUT COVERAGE
    //========================================================

    covergroup output_cg;

        cp_cout: coverpoint item.cout {

            bins zero = {0};
            bins one  = {1};

            bins low_values[] = {[2:6]};

            bins mid_values[] = {[7:9]};

            bins high_values[] = {[10:14]};

            bins max = {15};

        }

    endgroup


    //========================================================
    // INPUT × OUTPUT COVERAGE
    //========================================================

    covergroup input_output_cg;

        cp_en: coverpoint item.en {
            bins down = {0};
            bins up   = {1};
        }

        cp_cout: coverpoint item.cout {
            bins zero = {0};
            bins one  = {1};
            bins low_values[] = {[2:6]};
            bins mid_values[] = {[7:9]};
            bins high_values[] = {[10:14]};
            bins max = {15};
        }

        en_cout_cross: cross cp_en, cp_cout;

    endgroup


    //========================================================
    // CONSTRUCTOR
    //========================================================

    function new(
        string name = "counter_coverage",
        uvm_component parent = null
    );

        super.new(name, parent);

        input_cg       = new();
        output_cg      = new();
        input_output_cg = new();

    endfunction


    //========================================================
    // WRITE
    //========================================================

    function void write(counter_seq_item t);

        item = t;

        // Sample input coverage
        input_cg.sample();

        // Sample output coverage
        output_cg.sample();

        // Sample input/output coverage
        input_output_cg.sample();

    endfunction


    //========================================================
    // REPORT PHASE
    //========================================================

    function void report_phase(uvm_phase phase);

        super.report_phase(phase);

        `uvm_info("COVERAGE",
            "==============================================",
            UVM_NONE)

        `uvm_info("COVERAGE",
            "          FUNCTIONAL COVERAGE REPORT",
            UVM_NONE)

        `uvm_info("COVERAGE",
            "==============================================",
            UVM_NONE)


        // Input coverage
        `uvm_info("COVERAGE",
            $sformatf(
                "INPUT COVERAGE        = %0.2f%%",
                input_cg.get_coverage()
            ),
            UVM_NONE)


        // Output coverage
        `uvm_info("COVERAGE",
            $sformatf(
                "OUTPUT COVERAGE       = %0.2f%%",
                output_cg.get_coverage()
            ),
            UVM_NONE)


        // Input/Output cross coverage
        `uvm_info("COVERAGE",
            $sformatf(
                "INPUT/OUTPUT COVERAGE = %0.2f%%",
                input_output_cg.get_coverage()
            ),
            UVM_NONE)


        // Individual coverpoints
        `uvm_info("COVERAGE",
            $sformatf(
                "rst coverage          = %0.2f%%",
                input_cg.cp_rst.get_coverage()
            ),
            UVM_NONE)

        `uvm_info("COVERAGE",
            $sformatf(
                "en coverage           = %0.2f%%",
                input_cg.cp_en.get_coverage()
            ),
            UVM_NONE)

        `uvm_info("COVERAGE",
            $sformatf(
                "cout coverage         = %0.2f%%",
                output_cg.cp_cout.get_coverage()
            ),
            UVM_NONE)


        `uvm_info("COVERAGE",
            "==============================================",
            UVM_NONE)

    endfunction

endclass