module spi_cmu_top(

input sys_clk,sys_rstn,
output reg sys_clk_out,
input [1:0] select

);
wire clk_out_even;
wire clk_out_odd;
wire clk_out_fractionaldivide;

clk_even inst_even(.sys_clk(sys_clk),.sys_rstn(sys_rstn),.clk_out(clk_out_even));
clk_odd inst_odd(.sys_clk(sys_clk),.sys_rstn(sys_rstn),.clk_out(clk_out_odd));
clk_fractionaldivide inst_fractionaldivide(.sys_clk(sys_clk),.sys_rstn(sys_rstn),.clk_out(clk_out_fractionaldivide));

always@(*) begin
	
	case(select)
	2'b00:sys_clk_out = sys_clk;
	2'b01:sys_clk_out = clk_out_even;
	2'b10:sys_clk_out = clk_out_odd;
	2'b11:sys_clk_out = clk_out_fractionaldivide;

	default: sys_clk_out = sys_clk;
	endcase	
end
endmodule