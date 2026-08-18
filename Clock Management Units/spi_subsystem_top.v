module spi_subsystem_top(

//global inputs

input sys_clk,sys_rst_n,  

//SPI inputs
input s_in,
input [3:0] p_in,
input [1:0] mode,

//SPI outputs
output [3:0] p_out,
output s_out,
output spi_clk_out
);

wire slow_clk_in;

spi_buffer inst_buffer ( .clk(slow_clk_in),.rst_n(sys_rst_n),.mode(mode),.s_in(s_in),
.p_in(p_in),.p_out(p_out),.s_out(s_out)
);

clk_div_odd #(.divide_by(5)) inst_clk ( .clk_in(sys_clk),.rst_n(sys_rst_n),.clk_out(slow_clk_in));

assign spi_clk_out = slow_clk_in;
endmodule