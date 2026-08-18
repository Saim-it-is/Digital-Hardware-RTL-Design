`timescale 1ns/1ps // Tells the simulator that #1 means 1 nanosecond

module tb_threebit_countdowntimer();

    // 1. Inputs to the Design under test (Declared as reg because we drive them)
    reg clk;
    reg rst_n;
    reg [2:0] timer_set;
    reg timer_start;

    // 2. Outputs from the Design under test (Declared as wire because we listen)
    wire [2:0] current_time;
    wire stop_timer;

    // 3. INSTANTIATION: Hook up your timer module like a chip on a circuit board
    threebit_countdowntimer UUT (
        .clk(clk),
        .rst_n(rst_n),
        .timer_set(timer_set),
        .timer_start(timer_start),
        .current_time(current_time),
        .stop_timer(stop_timer)
    );

    // 4. CLOCK GENERATOR: Toggles the clock every 5ns (Creates a 100MHz clock)
    always begin
        #5 clk = ~clk;
    end

    // 5. THE EXPERIMENT: Driving the simulation signals step-by-step
    initial begin
        // Initialize your starting inputs
        clk = 0;
        rst_n = 0;          // Start in a reset state
        timer_start = 0;
        timer_set = 3'b101; // We want to load a timer value of 5

        #12;                // Wait 12 nanoseconds
        rst_n = 1;          // Release the reset button!

        #10;                // Wait one clock cycle
        // Timer should now copy timer_set (5) into current_time because timer_start is 0

        #10;
        timer_start = 1;    // Turn ON the timer! Let's watch it count down!

        #80;                // Wait 80ns to let it count down (5 -> 4 -> 3 -> 2 -> 1 -> 0)
        
        $stop;              // Tells the simulator to freeze so you can look at the waves!
    end

endmodule
