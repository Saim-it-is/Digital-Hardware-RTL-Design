module smart_battery_manager(
input [3:0]battery_level,
input charging,
output reg [1:0]status_code,
output reg warning_led
);

always @(*)
begin
	
	if( battery_level<3 && charging == 0) begin //critical_power_mode
		status_code=2'b11;
		warning_led=1;
		end
	else if ( (battery_level >=3 && battery_level<=7) && charging == 0) begin //low_power_mode
		status_code=2'b10;
		warning_led=1;
		end
	else if ( battery_level >= 8 && charging == 0) begin //normal_mode
		status_code=2'b01;
		warning_led=0;
		end
	else begin	                      //charging_override
		status_code=2'b00;
		warning_led=0;
		end
end

endmodule



