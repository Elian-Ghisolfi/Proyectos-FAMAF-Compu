`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2025 11:01:42
// Design Name: 
// Module Name: fetch
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


module fetch  #(parameter N=64)
              (input logic PCSrc_F, clk, reset, 
              input logic [N-1:0] PCBranch_F,
              input logic PCWrite,
              output logic [N-1:0] imem_addr_F );
    
    logic [N-1:0] y_adder;
    logic [N-1:0] y_mux2;
    logic [N-1:0] q_flopr;
     
    adder #(N) adder_F (.a(q_flopr), .b(N'('d4)), .y(y_adder));
              
    mux2 #(N) mux2_F (.d0(y_adder), .d1(PCBranch_F), .s(PCSrc_F), .y(y_mux2));
    
    flopre #(N) flopre_F (.clk(clk), .reset(reset), .d(y_mux2), .q(q_flopr), .enable(PCWrite));
    
    assign imem_addr_F = q_flopr;
                  
endmodule
