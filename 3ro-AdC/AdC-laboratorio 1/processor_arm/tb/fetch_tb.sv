`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2025 20:17:35
// Design Name: 
// Module Name: fetch_tb
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


module fetch_tb();
    logic PCSrc, clk, reset;
    logic [63:0] PCBranch;
    logic [63:0] imem_addr;
    
    fetch #(64) dut (
    .PCSrc_F(PCSrc),
    .clk(clk), 
    .reset(reset),
    .PCBranch_F(PCBranch),
    .imem_addr_F(imem_addr)
    );

    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin 
        reset = 1; PCBranch = 64'hfe0cafec0cac01a0; PCSrc = 0;  #50;
        reset = 0; #50;
        PCSrc = 1; #50;
        $stop;
    end 
endmodule
