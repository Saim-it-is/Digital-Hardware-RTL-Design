module clk_fractionaldivide
(
input sys_clk,sys_rstn,
output reg clk_out
);

reg [1:0] count_up;
reg state; //cycle 1 and cycle 2

always@(posedge sys_clk or negedge sys_rstn) begin
	if(!sys_rstn) begin
		count_up <= 2'b0;
		state <= 0;
		clk_out <= 0;	
	end
	else begin
	count_up <= count_up + 1;
	
	case(state)
		1'b0: begin
			if(count_up >= 2'd2)begin
				count_up <= 2'b0;
				state <= 1;
				clk_out <= ~clk_out;
			end
	end	
		1'b1: begin
			if(count_up >= 2'd3)begin
				count_up <= 2'b0;
				state <= 0;
				clk_out <= ~clk_out;
			end
	end
	default: state <= 0;
	endcase
	end
end
endmodule