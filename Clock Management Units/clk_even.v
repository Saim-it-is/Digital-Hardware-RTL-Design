module clk_even #(parameter divide_by = 8)
(
input sys_clk,sys_rstn,
output reg clk_out
);

localparam bitwidth = ($clog2(divide_by)== 0)? 1 : $clog2(divide_by);
localparam toggle = divide_by/2 - 1;

reg [bitwidth-1:0] count_up;

always@(posedge sys_clk or negedge sys_rstn)begin
	if(!sys_rstn) begin
		count_up <= {bitwidth{1'b0}};
		clk_out <= 0;
	end
	else if (count_up >= toggle) begin
		count_up <= {bitwidth{1'b0}};
		clk_out <= ~clk_out;
	end
	else count_up <= count_up + 1;
end

endmodule