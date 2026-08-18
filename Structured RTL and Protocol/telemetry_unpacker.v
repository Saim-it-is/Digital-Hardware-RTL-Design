module telemetry_unpacker(

input clk,rst_n,enb,
input s_in,

output s_out,
output [3:0] p_out
);

reg [3:0] temp;

always@(posedge clk or negedge rst_n) begin 
		if(!rst_n) begin
			temp <= 4'b0000;
		end
		else if(enb) begin
			temp <= {s_in,temp[3:1]};
			
		end
			
end


assign s_out = temp[0];
assign p_out = temp;


endmodule