`timescale 1ns/1ps

module sequential_arbiter_switch_tb();

reg clk, rst_n;
reg [2:0]req_bus;
reg [3:0] alu_data, crypto_data, debug_data;

wire [1:0] active_id;
wire [3:0] routed_data;


sequential_arbiter_switch dut(

.clk(clk),.rst_n(rst_n),.req_bus(req_bus),.alu_data(alu_data),.crypto_data(crypto_data),.debug_data(debug_data),
.active_id(active_id),.routed_data(routed_data)

);

always begin
	
	#5 clk=~clk;
	
end


initial begin

$monitor("[Time: %0t ns] rst_n=%b | req_bus=%b | active_id=%b | routed_data=%b",$time, rst_n, req_bus, active_id, routed_data);

					{clk,rst_n} = 0;
					req_bus = 3'b000;
					alu_data = 4'b0000;
					crypto_data = 4'b0000;
					debug_data = 4'b0000;
					
					#12
					
					rst_n = 1; 
					
					#8
					
					req_bus = 3'b110;
					alu_data = 4'b1111;
					crypto_data = 4'b1000;
					debug_data = 4'b1001;
					
					#10
					
					req_bus = 3'b011;
					alu_data = 4'b1111;
					crypto_data = 4'b1000;
					debug_data = 4'b1001;
					
					#10
					
					req_bus = 3'b001;
					alu_data = 4'b1111;
					crypto_data = 4'b1000;
					debug_data = 4'b1001;
					
					#10
					
					rst_n=0;
					
					req_bus = 3'b001;
					alu_data = 4'b1111;
					crypto_data = 4'b1000;
					debug_data = 4'b1001;
					
					$stop;
					
end
endmodule