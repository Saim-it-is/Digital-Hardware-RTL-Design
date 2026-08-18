module sequential_arbiter_switch(

input clk, rst_n,
input [2:0]req_bus,
input [3:0] alu_data, crypto_data, debug_data,

output reg [1:0] active_id,
output reg [3:0] routed_data
);

reg [1:0] next_id;
reg [3:0] next_data;

always@(posedge clk or negedge rst_n) begin //sequential logic

	if(!rst_n) begin
		active_id <= 2'b00;
		routed_data <= 4'b0000;
		end
	else begin
		active_id = next_id;
		routed_data = next_data;
		end
end

always@(*) begin // combinational logic
		
		casex(req_bus) 
		
	   3'b1xx: next_id = 2'b10;
		3'b01x: next_id = 2'b01;
		3'b001: next_id = 2'b00;
		
		default: next_id = 2'b00;
		
		endcase
		
		
		case(next_id)
		
		2'b10: next_data = alu_data;
		2'b01: next_data = crypto_data;
		2'b00: next_data = debug_data;
		
		default: next_data = 4'b0000;
		
		endcase
end







endmodule