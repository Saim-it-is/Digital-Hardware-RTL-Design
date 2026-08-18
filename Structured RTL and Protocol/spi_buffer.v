module spi_buffer(

input clk,rst_n,s_in,
input [1:0] mode,
input [3:0] p_in,

output wire [3:0] p_out, 
output wire s_out

);

reg [3:0] temp;

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) 
		temp <= 4'b0000;
	else begin	
		case(mode)
		2'b00: temp <= temp; //hold
		2'b01: temp <= p_in; //parallel_load
		2'b10: temp <= {s_in,temp[3:1]}; //right shift bits to the sensor
		2'b11: temp <= 4'b0000; //clear
      endcase
   end
end

assign s_out = temp[0];
assign p_out = temp; 

endmodule