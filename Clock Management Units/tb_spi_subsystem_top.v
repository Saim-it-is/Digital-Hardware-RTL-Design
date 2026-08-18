`timescale 1ns/1ps

module tb_spi_subsystem_top();

    
    reg sys_clk;
    reg sys_rst_n;
    reg s_in;
    reg [1:0] mode;
    reg [3:0] p_in;

    wire [3:0] p_out;
    wire s_out;
    wire spi_clk_out; 

    
    reg [3:0] expected_p_out;
    reg expected_s_out;
    reg [3:0] tb_temp;
    reg checker_enable;

    spi_subsystem_top dut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .s_in(s_in),
        .mode(mode),
        .p_in(p_in),
        .p_out(p_out),
        .s_out(s_out),
        .spi_clk_out(spi_clk_out)
    );


    always begin
        sys_clk = 1'b0;
        #5;
        sys_clk = 1'b1;
        #5;
    end

   
    always @(posedge spi_clk_out or negedge sys_rst_n) begin  
        if (!sys_rst_n) begin
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

    always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (!sys_rst_n)
            checker_enable <= 0;
        else    
            checker_enable <= 1;
    end

  
    always @(negedge sys_clk) begin  
        if (sys_rst_n && checker_enable) begin
            if (expected_p_out !== p_out) begin
                $display("Mismatch at [Time:%0t]; expected p_out was %b while real p_out was %b", $time, expected_p_out, p_out);            
                $stop;
            end
            if (expected_s_out !== s_out) begin
                $display("Mismatch at [Time:%0t]; expected s_out was %b while real s_out was %b", $time, expected_s_out, s_out);
                $stop;
            end
        end    
    end

    
    initial begin                 
        
        sys_rst_n = 0;
        s_in = 0;
        mode = 2'b00;
        p_in = 4'b0000;
        
        #30; 
        @(negedge sys_clk);
        sys_rst_n = 1; 
        
      
        @(negedge sys_clk);
        mode = 2'b01;       
        p_in = 4'b1001;
        
        #100; 
        
        @(negedge sys_clk);   
        mode = 2'b10;
        s_in = 1;
        
        #200; 
        
        
        @(negedge sys_clk);   
        mode = 2'b00;
        #100;
        
        
        @(negedge sys_clk);   
        mode = 2'b11;  
      
        #100;
        
        $display("========================================");
        $display("SUCCESS: ALL SUBSYSTEM TESTS PASSED!");
        $display("========================================");
        $stop;            
    end

endmodule