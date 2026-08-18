module vending_machine(

input clk,rst_n,
input [2:0]coin_i,
output reg dispense_o,
output reg [1:0] change
);

reg [2:0]current_state;
reg [2:0]next_state;

localparam s0= 3'b000; //0 cents
localparam s1= 3'b001; //5 cents
localparam s2= 3'b010; //10 cents 
localparam s3= 3'b011; //15 cents
localparam s4= 3'b100; //20 cents

//==========================================================================
always@(posedge clk or negedge rst_n) begin //current state sequential logic
	if(!rst_n)
		current_state <= 3'b000;
	else
		current_state <= next_state;
end
//==========================================================================
always@(*) begin //next state combinational logic
	case(current_state)
	s0: begin
		if(coin_i == 3'd0)
		next_state = current_state; 
		else if(coin_i == 3'd1) //5 cents addition
		next_state = 3'b001;
		else if(coin_i == 3'd2) //10 cents addition
		next_state = 3'b010;
		else if(coin_i == 3'd3) //15 cents addition
		next_state = 3'b011;
		else if(coin_i == 3'd4) //20 cents addition
		next_state = 3'b100;
		else next_state = current_state;
	end	
	s1: begin
		if(coin_i == 3'd0)
		next_state = current_state; 
		else if(coin_i == 3'd1) //5 cents addition
		next_state = 3'b010;
		else if(coin_i == 3'd2) //10 cents addition
		next_state = 3'b011;
		else if(coin_i == 3'd3) //15 cents addition
		next_state = 3'b100;
		else if(coin_i == 3'd4) //20 cents addition
		next_state = 3'b000; 
		else next_state = current_state;
	end
	s2: begin
		if(coin_i == 3'd0)
		next_state = current_state; 
		else if(coin_i == 3'd1) //5 cents addition
		next_state = 3'b011;
		else if(coin_i == 3'd2) //10 cents addition
		next_state = 3'b100;
		else if(coin_i == 3'd3) //15 cents addition
		next_state = 3'b000;  
		else next_state = current_state;
	end
	s3: begin
		if(coin_i == 3'd0)
		next_state = current_state; 
		else if(coin_i == 3'd1) //5 cents addition
		next_state = 3'b100;
		else if(coin_i == 3'd2) //10 cents addition
		next_state = 3'b000; 
		else next_state = current_state;		
	end
	s4: begin
		if(coin_i == 3'd0)
		next_state = current_state; 
		else if(coin_i == 3'd1) //5 cents addition
		next_state = 3'b000; 
		else next_state = current_state;	
	end
	default: next_state = s0;
	endcase
end
//==========================================================================
always@(*) begin //output combinational block
	case(current_state)
	s0: begin 
		if(coin_i <= 3'd4)
		dispense_o = 0; 
		change = 2'b00; //no change
	end
	s1: begin 
		if(coin_i <= 3'd3)begin
		dispense_o = 0; 
		change = 2'b00; //no change
		end
		else if(coin_i >= 3'd4) begin
			dispense_o = 1;
			change = 2'b00; //because it is exactly at 25 cents
			end
	end
	s2: begin 
		if(coin_i <= 3'd2) begin
		dispense_o = 0; 
		change = 2'b00; //no change
		end
		else if(coin_i == 3'd3)begin
			dispense_o = 1;
			change = 2'b00; //exactly at 25 cents
			end
		else if(coin_i >= 3'd4)begin
			dispense_o = 1;
			change = 2'b01; //5 cents change
			end
	end
	s3: begin 
		if(coin_i <= 3'd1)begin
		dispense_o = 0; 
		change = 2'b00; //no change
		end
		else if(coin_i == 3'd2)begin
			dispense_o = 1;
			change = 2'b00;//exactly at 25 cents
			end
		else if(coin_i == 3'd3)begin
			dispense_o = 1;
			change = 2'b01; //5 cents change
			end
		else if(coin_i >= 3'd4)begin
			dispense_o = 1;
			change = 2'b10; //10 cents change
			end	
	end
	s4: begin 
		if(coin_i == 3'd0)begin
		dispense_o = 0; 
		change = 2'b00; //no change
		end
		else if(coin_i == 3'd1)begin
			dispense_o = 1;
			change = 2'b00;//exactly at 25 cents
			end
		else if(coin_i == 3'd2)begin
			dispense_o = 1;
			change = 2'b01; //5 cents change
			end
		else if(coin_i == 3'd3)begin
			dispense_o = 1;
			change = 2'b10; //10 cents change
			end
		else if(coin_i >= 3'd4)begin
			dispense_o = 1;
			change = 2'b11; //15 cents change
			end
	end
	default: begin
		dispense_o = 0;
		change = 2'b00;
		end
	endcase
end
//==========================================================================
endmodule