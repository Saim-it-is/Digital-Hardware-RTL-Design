`timescale 1ns/1ps

module tb_telemetry_unpacker();

reg clk,rst_n,enb,s_in;
wire s_out;
wire [3:0] p_out;


telemetry_unpacker dut(.clk(clk),.rst_n(rst_n),.enb(enb),.s_in(s_in),
.s_out(s_out),.p_out(p_out));

always #5 clk <= ~clk;

initial begin

$monitor("[time:%0t] || rst_n=%b || enb=%b || s_in=%b || temp=%b || s_out=%b || p_out =%b",$time,rst_n,enb,s_in,dut.temp,s_out,p_out);

		{clk,rst_n,enb,s_in} = 0;
		
		#12 
		rst_n = 1;
		@(negedge clk)
		enb = 1;
		s_in = 1;
		@(negedge clk)
		s_in = 0;
		@(negedge clk)
		s_in = 0;
		@(negedge clk)
		s_in = 1;
		@(negedge clk)
		enb = 0;
		@(negedge clk)
		enb = 1;
		@(negedge clk)
		rst_n = 0;
		
		#10
		$stop;
end
endmodule