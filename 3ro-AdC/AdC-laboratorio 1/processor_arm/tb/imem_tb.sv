`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 03:41:56 PM
// Design Name: 
// Module Name: imem_tb
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
`define N 32

module imem_tb();
    logic [5:0] addr;
    logic [(`N)-1:0] out;
    
    imem #(`N) dut(.addr(addr), .q(out));
    
    initial begin
        addr= 6'b000000; #5;
        for (int i = 0; i < 49; i++) begin
            addr = addr + 1; #5;
        end
        $stop;
    end
endmodule
