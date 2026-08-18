`timescale 1ns/1ps
module tb_packet_serializer();

reg clk,rst_n,load_payload;
reg [3:0] parallel_word;

wire tx_serial_out;
reg expected_output;
reg [3:0] tb_temp;
reg checker_enable;

packet_serializer dut(
.clk(clk),.rst_n(rst_n),.load_payload(load_payload),.parallel_word(parallel_word),
.tx_serial_out(tx_serial_out)
);

always #5 clk<=~clk; 

always@(posedge clk) begin
		if(!rst_n)
			tb_temp <= 4'b0000;
		else begin
			if(load_payload)
				tb_temp <= parallel_word;
			else 
				tb_temp <= {tb_temp[0],tb_temp[3:1]};		
	end
	end
	
always @(*) begin
    if (load_payload)
        expected_output = 1'b1;
    else 
        expected_output = tb_temp[0];
end

initial begin
				
				{clk,rst_n,load_payload} = 0;
				parallel_word = 4'b0000;	
				#12
					rst_n =1;	
				@(negedge clk)
					load_payload = 1;
					parallel_word = 4'b1001;
				@(negedge clk)
					load_payload = 0;
				#70
				 rst_n = 0;
				@(negedge clk)
					
					@(negedge clk);
    
    
    $display("========================================");
    $display("VERIFICATION WAS SUCCESSFUL! ALL PASSED");
    $display("========================================");
    
    $stop;
					
					
end
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        checker_enable <= 1'b0; 
    else
        checker_enable <= 1'b1; 
end

always@(negedge clk) begin
	if(rst_n && checker_enable) begin 
		if(expected_output !== tx_serial_out) begin
			$display("MISMATCH at [Time:%0t], expected output was %b,the hardware output we got is %b",$time,expected_output,tx_serial_out);
			$stop;
		end
	end	
end
endmodule