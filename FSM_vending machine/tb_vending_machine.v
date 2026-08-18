`timescale 1ns/1ps

module tb_vending_machine();
reg clk,rst_n;
reg [2:0] coin_i;
wire dispense_o;
wire [1:0]change;

integer error_count = 0;

localparam s0= 3'b000; //0 cents
localparam s1= 3'b001; //5 cents
localparam s2= 3'b010; //10 cents 
localparam s3= 3'b011; //15 cents
localparam s4= 3'b100; //20 cents

vending_machine dut(
.clk(clk),.rst_n(rst_n),.coin_i(coin_i),.dispense_o(dispense_o),.change(change)
);

always #5 clk = ~clk;

task verify_outputs(input expected_dispense_o, input [1:0] expected_change); 
begin
    @(negedge clk); 
    if (dispense_o !== expected_dispense_o) begin
        $display("TEST FAILED! dispense output=%b not equal to expected=%b at [time:%0t]", dispense_o, expected_dispense_o, $time);
        error_count = error_count + 1;
    end
    else if (change !== expected_change) begin
        $display("TEST FAILED! change output=%b not equal to expected=%b at [time:%0t]", change, expected_change, $time);
        error_count = error_count + 1;
    end
    else begin
        $display("TEST PASSED at (time:%0t)", $time); 
    end
end
endtask


task verify_mealy(input expected_dispense_o, input [1:0] expected_change); 
begin
    if (dispense_o !== expected_dispense_o) begin
        $display("TEST FAILED! dispense output=%b not equal to expected=%b at [time:%0t]", dispense_o, expected_dispense_o, $time);
        error_count = error_count + 1;
    end
    else if (change !== expected_change) begin
        $display("TEST FAILED! change output=%b not equal to expected=%b at [time:%0t]", change, expected_change, $time);
        error_count = error_count + 1;
    end
    else begin
        $display("TEST PASSED at (time:%0t)", $time); 
    end
end
endtask

initial begin
	{clk, rst_n} <= 2'b00;
    coin_i <= 3'b000;
    @(negedge clk)
    rst_n <= 1;
    
    @(posedge clk);
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b001; 
    @(posedge clk); 
    coin_i <= 3'b000;
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b010;
    @(posedge clk); 
    coin_i <= 3'b000;
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b000; 
    @(posedge clk); 
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b010; 
    verify_mealy(1'd1, 2'd0); 
    @(posedge clk); 
    coin_i <= 3'b000;
    
    @(posedge clk); 
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b011;
    @(posedge clk); 
    coin_i <= 3'b000;
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b011;
    verify_mealy(1'd1, 2'd1); 
    @(posedge clk); 
    coin_i <= 3'b000;
    
    @(posedge clk); 
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b100;
    @(posedge clk); 
    coin_i <= 3'b000;
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b100;
    verify_mealy(1'd1, 2'd3); 
    @(posedge clk); 
    coin_i <= 3'b000;
    
    coin_i <= 3'b100;
    @(posedge clk); 
    coin_i <= 3'b000;
    verify_outputs(1'd0, 2'd0);
    
    coin_i <= 3'b011;
    verify_mealy(1'd1, 2'd2);
//==========================================================================	 

coin_i <= 3'b000;
rst_n  <= 1'b0;      
#1;                   
rst_n  <= 1'b1;      

@(posedge clk);   
coin_i <= 3'b000;      

@(posedge clk)
coin_i <= 3'b010;
rst_n = 0;
#1 
rst_n = 1;

coin_i <= 3'b111;
@(posedge clk)
#1
rst_n= 0;
#1
rst_n=1;

@(posedge clk)
coin_i <= 3'b100;
@(posedge clk) 
#1
rst_n = 0;
#1
rst_n = 1;
@(negedge clk)
coin_i <= 3'b001;
@(posedge clk)

coin_i <= 3'b001;
@(posedge clk)

rst_n = 0; #5; rst_n = 1; #5;
@(negedge clk); 
coin_i = 3'b001;                 // Drive 5c
@(posedge clk); #1;              // Step into s1
coin_i = 3'b010;                 // Drive 10c while inside s1
#10;                             // HOLD for 10ns so Questa logs Line 46!

// --- 2. CLEAR LINE 48 & 49 (15c in s1) ---
rst_n = 0; #5; rst_n = 1; #5;    // RESET AFTER THE HOLD TIME, NOT ON THE EDGE
@(negedge clk); 
coin_i = 3'b001;                 // Drive 5c
@(posedge clk); #1;              // Step into s1
coin_i = 3'b011;                 // Drive 15c while inside s1
#10;

$display("COVERAGE SWEEP COMPLETE");
    $display("\n--------------------------------------------");
    if (error_count == 0) begin
        $display("ALL TESTS PASSED SUCCESSFULLY!");
    end else begin
        $display("FAILURE: Simulation finished with %0d errors", error_count);
    end
    $display("--------------------------------------------\n");
    
    $finish;
end
endmodule
