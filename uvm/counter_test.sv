class counter_test extends uvm_test;

    `uvm_component_utils(counter_test)

    counter_env env;

    function new(string name = "counter_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        env = counter_env::type_id::create("env", this);
    
    endfunction

    task run_phase(uvm_phase phase);

        counter_sequence seq;

        phase.raise_objection(this);

        seq = counter_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);
    
    endtask

endclass

class counter_up_test extends uvm_test;

    `uvm_component_utils(counter_up_test)

    counter_env env;

    function new(
        string name = "counter_up_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction

    task run_phase(uvm_phase phase);

        counter_up_sequence seq;

        phase.raise_objection(this);

        seq = counter_up_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);

    endtask

endclass

class counter_down_test extends uvm_test;

    `uvm_component_utils(counter_down_test)

    counter_env env;

    function new(
        string name = "counter_down_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction

    task run_phase(uvm_phase phase);

        counter_down_sequence seq;

        phase.raise_objection(this);

        seq = counter_down_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);

    endtask

endclass

class counter_reset_test extends uvm_test;

    `uvm_component_utils(counter_reset_test)

    counter_env env;

    function new(
        string name = "counter_reset_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction

    task run_phase(uvm_phase phase);

        counter_reset_sequence seq;

        phase.raise_objection(this);

        seq = counter_reset_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);

    endtask

endclass

class counter_up_wrap_test extends uvm_test;

    `uvm_component_utils(counter_up_wrap_test)

    counter_env env;

    function new(
        string name = "counter_up_wrap_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction

    task run_phase(uvm_phase phase);

        counter_up_wrap_sequence seq;

        phase.raise_objection(this);

        seq = counter_up_wrap_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);

    endtask

endclass

class counter_down_wrap_test extends uvm_test;

    `uvm_component_utils(counter_down_wrap_test)

    counter_env env;

    function new(
        string name = "counter_down_wrap_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction

    task run_phase(uvm_phase phase);

        counter_down_wrap_sequence seq;

        phase.raise_objection(this);

        seq = counter_down_wrap_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);

    endtask

endclass

class counter_reset_during_count_test extends uvm_test;

    `uvm_component_utils(counter_reset_during_count_test)

    counter_env env;

    function new(
        string name = "counter_reset_during_count_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction

    task run_phase(uvm_phase phase);

        counter_reset_during_count_sequence seq;

        phase.raise_objection(this);

        seq = counter_reset_during_count_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);

    endtask

endclass

class counter_up_down_test extends uvm_test;

    `uvm_component_utils(counter_up_down_test)

    counter_env env;

    function new(
        string name = "counter_up_down_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction

    task run_phase(uvm_phase phase);

        counter_up_down_sequence seq;

        phase.raise_objection(this);

        seq = counter_up_down_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);

    endtask

endclass

class counter_corner_test extends uvm_test;

    `uvm_component_utils(counter_corner_test)

    counter_env env;

    function new(
        string name = "counter_corner_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction

    task run_phase(uvm_phase phase);

        counter_corner_sequence seq;

        phase.raise_objection(this);

        seq = counter_corner_sequence::type_id::create("seq");

        seq.start(env.agent.sequencer);

        phase.drop_objection(this);

    endtask

endclass

class counter_all_test extends uvm_test;

    `uvm_component_utils(counter_all_test)

    counter_env env;

    function new(
        string name = "counter_all_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = counter_env::type_id::create("env", this);

    endfunction


    task run_phase(uvm_phase phase);

        counter_sequence                    random_seq;
        counter_up_sequence                 up_seq;
        counter_down_sequence               down_seq;
        counter_reset_sequence              reset_seq;
        counter_up_wrap_sequence             up_wrap_seq;
        counter_down_wrap_sequence           down_wrap_seq;
        counter_reset_during_count_sequence  reset_count_seq;
        counter_up_down_sequence              up_down_seq;
        counter_corner_sequence               corner_seq;


        phase.raise_objection(this);


        //==================================================
        // 1. Random Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Random Sequence",
                  UVM_LOW)

        random_seq =
            counter_sequence::type_id::create("random_seq");

        random_seq.start(env.agent.sequencer);


        //==================================================
        // 2. Up Count Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Up Count Sequence",
                  UVM_LOW)

        up_seq =
            counter_up_sequence::type_id::create("up_seq");

        up_seq.start(env.agent.sequencer);


        //==================================================
        // 3. Down Count Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Down Count Sequence",
                  UVM_LOW)

        down_seq =
            counter_down_sequence::type_id::create("down_seq");

        down_seq.start(env.agent.sequencer);


        //==================================================
        // 4. Reset Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Reset Sequence",
                  UVM_LOW)

        reset_seq =
            counter_reset_sequence::type_id::create("reset_seq");

        reset_seq.start(env.agent.sequencer);


        //==================================================
        // 5. Up Wrap Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Up Wrap Sequence",
                  UVM_LOW)

        up_wrap_seq =
            counter_up_wrap_sequence::type_id::create("up_wrap_seq");

        up_wrap_seq.start(env.agent.sequencer);


        //==================================================
        // 6. Down Wrap Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Down Wrap Sequence",
                  UVM_LOW)

        down_wrap_seq =
            counter_down_wrap_sequence::type_id::create("down_wrap_seq");

        down_wrap_seq.start(env.agent.sequencer);


        //==================================================
        // 7. Reset During Count Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Reset During Count Sequence",
                  UVM_LOW)

        reset_count_seq =
            counter_reset_during_count_sequence::type_id::create(
                "reset_count_seq"
            );

        reset_count_seq.start(env.agent.sequencer);


        //==================================================
        // 8. Up-Down Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Up-Down Sequence",
                  UVM_LOW)

        up_down_seq =
            counter_up_down_sequence::type_id::create(
                "up_down_seq"
            );

        up_down_seq.start(env.agent.sequencer);


        //==================================================
        // 9. Corner Case Test
        //==================================================

        `uvm_info("ALL_TEST",
                  "Starting Corner Sequence",
                  UVM_LOW)

        corner_seq =
            counter_corner_sequence::type_id::create(
                "corner_seq"
            );

        corner_seq.start(env.agent.sequencer);


        //==================================================
        // ALL TESTS COMPLETED
        //==================================================

        `uvm_info("ALL_TEST",
                  "======================================",
                  UVM_NONE)

        `uvm_info("ALL_TEST",
                  "ALL COUNTER TESTS COMPLETED",
                  UVM_NONE)

        `uvm_info("ALL_TEST",
                  "======================================",
                  UVM_NONE)


        phase.drop_objection(this);

    endtask

endclass