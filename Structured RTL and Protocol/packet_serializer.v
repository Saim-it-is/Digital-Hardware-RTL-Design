module packet_serializer(

input clk, rst_n,load_payload,
input [3:0] parallel_word,

output reg tx_serial_out
);

reg [3:0] temp;

always@(posedge clk or negedge rst_n) begin

	if(!rst_n) 
		temp <= 4'b0000;
	else if(load_payload)
		temp <= parallel_word;
	else
		temp <= {temp[0],temp[3:1]};
	
end

always@(*) begin
	if(load_payload)
		tx_serial_out = 1'b1;
	else
		tx_serial_out = temp[0];
end
endmodule