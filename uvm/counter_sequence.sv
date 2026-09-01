class counter_sequence extends uvm_sequence#(counter_seq_item);

    `uvm_object_utils(counter_sequence)

    function new(string name = "counter_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        repeat(100)
        begin
            req = counter_seq_item::type_id::create("req");

            start_item(req);

            assert(req.randomize());

            finish_item(req);
        end

    endtask

endclass

class counter_up_sequence extends uvm_sequence #(counter_seq_item);

    `uvm_object_utils(counter_up_sequence)

    function new(string name = "counter_up_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        // Reset counter first
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 1;
        req.en  = 1;

        finish_item(req);


        // Up-count for 10 clock cycles
        repeat (30)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 1;

            finish_item(req);

        end

    endtask

endclass

class counter_down_sequence extends uvm_sequence #(counter_seq_item);

    `uvm_object_utils(counter_down_sequence)

    function new(string name = "counter_down_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        // Reset counter first
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 1;
        req.en  = 0;

        finish_item(req);


        // Down-count for 10 clock cycles
        repeat (50)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 0;

            finish_item(req);

        end

    endtask

endclass

class counter_reset_sequence extends uvm_sequence #(counter_seq_item);

    `uvm_object_utils(counter_reset_sequence)

    function new(string name = "counter_reset_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        repeat (10)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 1;
            req.en  = $urandom_range(0, 1);

            finish_item(req);

        end

    endtask

endclass

class counter_up_wrap_sequence extends uvm_sequence #(counter_seq_item);

    `uvm_object_utils(counter_up_wrap_sequence)

    function new(string name = "counter_up_wrap_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        // Reset
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 1;
        req.en  = 1;

        finish_item(req);


        // Count from 0 to 15 and wrap to 0
        repeat (30)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 1;

            finish_item(req);

        end

    endtask

endclass

class counter_down_wrap_sequence extends uvm_sequence #(counter_seq_item);

    `uvm_object_utils(counter_down_wrap_sequence)

    function new(string name = "counter_down_wrap_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        // Reset
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 1;
        req.en  = 0;

        finish_item(req);


        // Down-count and verify wrap-around
        repeat (25)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 0;

            finish_item(req);

        end

    endtask

endclass

class counter_reset_during_count_sequence extends uvm_sequence #(counter_seq_item);

    `uvm_object_utils(counter_reset_during_count_sequence)

    function new(string name = "counter_reset_during_count_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        // Initial reset
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 1;
        req.en  = 1;

        finish_item(req);


        // Count UP
        repeat (5)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 1;

            finish_item(req);

        end


        // Reset while counter has a non-zero value
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 1;
        req.en  = 0;

        finish_item(req);


        // Continue counting UP after reset
        repeat (5)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 1;

            finish_item(req);

        end

    endtask

endclass

class counter_up_down_sequence extends uvm_sequence #(counter_seq_item);

    `uvm_object_utils(counter_up_down_sequence)

    function new(string name = "counter_up_down_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        // Reset
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 1;
        req.en  = 1;

        finish_item(req);


        // Count UP
        repeat (5)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 1;

            finish_item(req);

        end


        // Count DOWN
        repeat (3)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 0;

            finish_item(req);

        end


        // Count UP again
        repeat (4)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 1;

            finish_item(req);

        end

    endtask

endclass

class counter_corner_sequence extends uvm_sequence #(counter_seq_item);

    `uvm_object_utils(counter_corner_sequence)

    function new(string name = "counter_corner_sequence");
        super.new(name);
    endfunction

    task body();

        counter_seq_item req;

        //==================================================
        // 1. Reset
        //==================================================
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 1;
        req.en  = 1;

        finish_item(req);


        //==================================================
        // 2. UP: Reach 15
        //==================================================
        repeat (15)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 1;

            finish_item(req);

        end


        //==================================================
        // 3. UP WRAP: 15 -> 0
        //==================================================
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 0;
        req.en  = 1;

        finish_item(req);


        //==================================================
        // 4. DOWN: 0 -> 15
        //==================================================
        req = counter_seq_item::type_id::create("req");

        start_item(req);

        req.rst = 0;
        req.en  = 0;

        finish_item(req);


        //==================================================
        // 5. DOWN: Continue from 15
        //==================================================
        repeat (14)
        begin

            req = counter_seq_item::type_id::create("req");

            start_item(req);

            req.rst = 0;
            req.en  = 0;

            finish_item(req);

        end

    endtask

endclass