module smart_battery_manager(
input battery_level, charging,
output status_code, warning_led);

wire charging;

reg [3:0] battery_level;
reg [1:0] status_code;
reg warning_led;

always @(*)
begin

	if( battery_level<3 && charging == 0) //critial_power_mode
		status_code=2'b11;
		warning_led=1;
		
	else if ( (battery_level >=3 && battery_level<=7) && charging == 0) //low_power_mode
		status_code=2'b10;
		warning_led=1;
		
	else if ( battery_level >= 8) //normal_mode
		status_code=2'b01;
		warning_led=0;
	
	else 	                      //charging_override
		status_code=2'b00;
		warning_led=0;
end

endmodule



