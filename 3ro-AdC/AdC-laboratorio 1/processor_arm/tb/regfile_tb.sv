`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2025 20:48:46
// Design Name: 
// Module Name: regfile_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module regfile_tb;
    logic clk, we3;
    logic [4:0] ra1, ra2, wa3;
    logic [63:0] wd3;
    logic [63:0] rd1, rd2;
    
    regfile dut (
        .clk(clk),
        .we3(we3),
        .ra1(ra1),
        .ra2(ra2),
        .wa3(wa3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        // inicializamos variables
        we3 = 0;
        wd3 = 64'b0;
        ra1 = 5'd0;
        ra2 = 5'd0;
        wa3 = 5'd0;
        
        // recorrer registros inicializados
        for (int i = 0; i < 32; i++) begin
            ra1 = i;
            ra2 = i;
            #10;
        end
        
        // probar escritura
        wa3 = 5'd5;
        wd3 = 64'h123455678abcdef0;
        we3 = 1;
        ra1 = 5'd5;
        #10;
        
        // probar escritura con we3 = 0
        we3 = 0;
        wd3 = 64'hffffffffffffffff;
        wa3 = 5'd6;
        #10;
        ra2 = 5'd6;
        #10;
        
        // probar integridad del registro 31
        wa3 = 5'd31;
        wd3 = 64'hffffffffffffffff;
        we3 = 1;
        #10;
        ra1 = 5'd31;
        #10;
        
        $finish;
    end
    
endmodule
