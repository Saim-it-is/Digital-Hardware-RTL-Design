`timescale 1ns/1ps

module tb_spi_cmu_top();

reg sys_clk;
    reg sys_rstn;
    reg [1:0] select;
    wire sys_clk_out;

	 integer errors_count = 0;
	 
spi_cmu_top uut (
        .sys_clk(sys_clk),
        .sys_rstn(sys_rstn),
        .select(select),
        .sys_clk_out(sys_clk_out)
    );
	 
	always #5 sys_clk = ~sys_clk;
	 
//evaluation block

task evaluate(input [63:0] expected_period,input[63:0] expected_high);
	
	time t_rise1,t_rise2,t_fall;
	time measured_period,measured_high;
	begin
	
	@(posedge sys_clk_out) t_rise1 = $time;
	@(negedge sys_clk_out) t_fall = $time;
	@(posedge sys_clk_out) t_rise2 = $time;
	
	measured_period = t_rise2 - t_rise1;
	measured_high = t_fall - t_rise1;
	
	if(measured_period == expected_period && measured_high == expected_high)
		$display("PASS at mode %b, Evaluation: period is %0t and duty cycle is 50%%",select,measured_period); 
	else begin
		errors_count = errors_count + 1;
		$error("FAIL at mode %b, Evaluation: expected high is at %0t while measured high is at %0t and expected period is %0t while measured period is %0t",select,expected_high,measured_high,expected_period,measured_period);
	end
end		
endtask

initial begin
	{sys_clk,sys_rstn} = 0;
	select = 2'b00;
	
	#10
	sys_rstn = 1;
	
	#20 //30ns
	select = 2'b01; //even clock select
	#80 //110ns
	evaluate(80,40); //even mode check
	//210ns
	#10 //220ns
	select = 2'b10; //odd clock select
	#80 //290ns
	evaluate(70,35); //odd mode check
	//380ns
	#10 //390ns
	select = 2'b11; //fractional divide select
   #70              
   evaluate(70,40);
	
	if (errors_count == 0) begin
            $display("ALL SIMULATION TESTS PASSED SUCCESSFULLY!!");
        end else begin
            $display("SIMULATION FINISHED WITH %0d ERRORS.", errors_count);
        end
        
        $finish;
	
end
endmodule	 
	 