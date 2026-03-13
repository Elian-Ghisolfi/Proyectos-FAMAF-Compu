`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2025 20:12:28
// Design Name: 
// Module Name: regfile
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


module regfile (input logic clk, we3, 
                input logic [4:0] ra1, ra2, wa3,
                input logic [63:0] wd3, 
                output logic [63:0] rd1, rd2 );
                
    logic [63:0] regs [0:31];
    
    initial begin
        for ( int i = 0; i < 31; i++) begin
            regs[i] = i;
        end 
        regs[31] = 63'b0;
    end
    
    always_ff @(posedge clk) begin
        if ( we3 && (wa3 != 5'd31)) begin
            regs[wa3] = wd3;
        end 
    end
    
    assign rd1 = (ra1 == 5'd31) ? regs[31] : (we3 && (wa3 == ra1)) ? wd3 : regs[ra1];
    assign rd2 = (ra2 == 5'd31) ? regs[31] : (we3 && (wa3 == ra2))  ? wd3 : regs[ra2];
    
endmodule
    