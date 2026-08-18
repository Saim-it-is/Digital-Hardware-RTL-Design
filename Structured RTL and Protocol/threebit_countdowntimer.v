module threebit_countdowntimer(
    input clk, rst_n,
    input [2:0] timer_set,
    input timer_start,
    output reg [2:0] current_time,
    output reg stop_timer
);

reg [2:0] count_next; 

always@(posedge clk or negedge rst_n) begin

		if(!rst_n) 
			current_time <= 3'b111;
		else
			current_time <= count_next;
			
end


always@(*) begin
	
		count_next = current_time; //default
		
		if(timer_start) begin
			if(current_time > 3'b000)
				count_next = current_time - 1;
			else
				count_next = 3'b000;
			 					
end		
		else 
			count_next = timer_set;
 		
end
always@(*) begin
	stop_timer = 0; //default
		
		if(current_time == 3'b000)
			stop_timer = 1;
		else
			stop_timer = 0;

end

endmodule