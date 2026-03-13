`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2025 04:43:52 PM
// Design Name: 
// Module Name: flopre
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


module flopre #(parameter N = 64)
    (input logic clk,
    input logic reset,
    input logic [N-1:0] d,
    input logic enable,
    output logic [N-1:0] q
    );
    
    always_ff @(posedge clk, posedge reset)
        begin
            if(reset) q <= N'('b0);
            else if (enable) q <= d;
        end
endmodule
