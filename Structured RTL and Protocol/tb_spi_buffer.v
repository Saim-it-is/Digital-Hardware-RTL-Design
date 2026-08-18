`timescale 1ns/1ps

module tb_spi_buffer();

reg clk,rst_n,s_in;
reg [1:0] mode;
reg [3:0] p_in;

wire [3:0] p_out;
wire s_out;

reg [3:0] expected_p_out;
reg expected_s_out;
reg [3:0] tb_temp;
reg checker_enable;

spi_buffer dut(
.clk(clk),.rst_n(rst_n),.s_in(s_in),.mode(mode),.p_in(p_in),
.p_out(p_out),.s_out(s_out)
);

always #5 clk<=~clk;

always @(posedge clk or negedge rst_n) begin  //behavior predictor
    if (!rst_n) begin
        tb_temp <= 4'b0000;
    end
    else begin
        case (mode)
            2'b00: tb_temp <= tb_temp;              
            2'b01: tb_temp <= p_in;                
            2'b10: tb_temp <= {s_in, tb_temp[3:1]};  
            2'b11: tb_temp <= 4'b0000;             
        endcase
    end
end

always @(*) begin
    expected_p_out = tb_temp;
    expected_s_out = tb_temp[0];
end

always@(posedge clk or negedge rst_n) begin //checker
	if(!rst_n)
		checker_enable <= 0;
	else	
		checker_enable <= 1;
end

always@(negedge clk) begin          //evaluator

	if(rst_n && checker_enable) begin
		if(expected_p_out !== p_out)begin
			$display("Mismatch at [Time:%0t]; expected p_out was %b while real p_out was %b",$time,expected_p_out,p_out);			
			$fflush;
			$stop;
			end
		if(expected_s_out !==s_out) begin
			$display("Mismatch at [Time:%0t]; expected s_out was %b while real s_out was %b",$time,expected_s_out,s_out);
			$stop;
			end
	end	
end

initial begin                  //stimulus

		{clk,rst_n,s_in} = 0; //initialization
		mode = 2'b00;
		p_in = 4'b0000;
		
		@(negedge clk)
		rst_n = 1;
		
		@(negedge clk)
		mode = 2'b01;       //loading 
		p_in = 4'b1001;
		
		@(negedge clk)   //shifting
		mode = 2'b10;
		s_in = 1;
		
		@(negedge clk)   //hold
		mode = 2'b00;
		
		@(negedge clk)   //clear
		mode = 2'b11;  
      
		@(negedge clk)
		$display("============================");
		$display("VERIFICATION WAS SUCCESSFUL!");
		$display("============================");
	$stop;	
			
end
endmodule