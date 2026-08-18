module clk_div_odd #(

parameter divide_by = 3

)(
input clk_in,rst_n,
output clk_out
);

localparam bit_width =($clog2(divide_by) == 0)? 1 : $clog2(divide_by); 
localparam threshold = divide_by - 1;

reg [bit_width-1:0] count_up;
reg pos_clk;
reg neg_clk;

always@(posedge clk_in or negedge rst_n) begin  //counter
	if(!rst_n)
		count_up <= {bit_width{1'b0}};
	else if (count_up >= threshold)
			count_up <= {bit_width{1'b0}};
	else			count_up <= count_up + 1;
end
always@(posedge clk_in or negedge rst_n) begin
	if(!rst_n)
		pos_clk <= 0;
	else 
		pos_clk <= (count_up < divide_by/2);
end
always@(negedge clk_in or negedge rst_n) begin
		if(!rst_n)
		neg_clk <= 0;
	else 
		neg_clk <= (count_up < divide_by/2);
end 
assign clk_out = pos_clk & neg_clk;
endmodule