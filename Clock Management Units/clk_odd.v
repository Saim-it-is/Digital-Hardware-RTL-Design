module clk_odd #(parameter divide_by = 7)
(
input sys_clk,sys_rstn,
output clk_out
);

localparam bitwidth = ($clog2(divide_by) == 0)? 1 : $clog2(divide_by);
localparam toggle = divide_by/2;
localparam reset_point = divide_by-1; 

reg[bitwidth-1:0] count_up;
reg pos_clk,neg_clk;

always@(posedge sys_clk or negedge sys_rstn) begin
	if(!sys_rstn)
		count_up <= {bitwidth{1'b0}};
	else if (count_up >= reset_point)
		count_up <= {bitwidth{1'b0}};
	else
		count_up <= count_up + 1;	
end

always@(posedge sys_clk or negedge sys_rstn) begin
	if(!sys_rstn)
		pos_clk <= 0;
	else
		pos_clk <= (count_up < toggle);
end

always@(negedge sys_clk or negedge sys_rstn) begin
	if(!sys_rstn)
		neg_clk <= 0;
	else
		neg_clk <= (count_up < toggle);
end

assign clk_out = pos_clk | neg_clk;  
endmodule